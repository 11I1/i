getgenv().Signals = getgenv().Signals or {}
for i, v in getgenv().Signals do
    if typeof(v) ~= "RBXScriptConnection" then continue end
    v:Disconnect(); getgenv().Signals[i] = nil
    print(`Disconnected "{i}": <{typeof(v)}> | Memory Cleared!`)
end

local AddSignal = setmetatable(getgenv().Signals, {
    __newindex = function(t, k, v)
        if typeof(v) ~= "RBXScriptConnection" then
            rawset(t, k, nil); print(`Removed "{k}": <{typeof(v)}>`)
            return
        end
        rawset(t, k, v); print(`Added "{k}": <{typeof(v)}>`)
    end
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local ms = require(ReplicatedStorage.Controllers.GoalieController)
local vim = game:GetService("VirtualInputManager")

local function pressKey(k)
	vim:SendKeyEvent(true,k,false,game)
	task.wait(0.02)
	vim:SendKeyEvent(false,k,false,game)
end
local function L() pressKey("A") ms:Dive() end
local function R() pressKey("D") ms:Dive() end

local footballRef = ReplicatedStorage:FindFirstChild("Football")
local ball = footballRef and footballRef.Value
local OnPlayer = ball and ball.OnPlayer

local MAX_T = 2.0
local EPS = 1e-6
local THRESH = 0.06
local RECENT_WINDOW = 0.28
local KICK_SPEED = 60

local predX, predZ = 0,0
local sampledVX, sampledVZ = 0,0
local sampleT = 0
local attached = false
local ownerHRP

local function tryOwner(p)
	if not p then return nil end
	local par = p.Parent
	if par and par:IsA("Model") then
		local h = par:FindFirstChild("HumanoidRootPart")
		if h and h:IsA("BasePart") then return h end
	end
	return nil
end

if OnPlayer and OnPlayer:IsA("BoolValue") then
	attached = OnPlayer.Value
	OnPlayer:GetPropertyChangedSignal("Value"):Connect(function()
		attached = OnPlayer.Value
		if attached then
			ownerHRP = tryOwner(OnPlayer.Parent) or tryOwner(ball)
			sampledVX, sampledVZ = 0,0
			sampleT = 0
		else
			if ball and ball:IsA("BasePart") then
				local bv = ball.Velocity
				sampledVX, sampledVZ = bv.X, bv.Z
				sampleT = tick()
				if math.abs(sampledVX) < EPS and math.abs(sampledVZ) < EPS and ownerHRP then
					local f = ownerHRP.CFrame.LookVector
					sampledVX = f.X * KICK_SPEED + ownerHRP.Velocity.X
					sampledVZ = f.Z * KICK_SPEED + ownerHRP.Velocity.Z
					sampleT = tick()
				end
			else
				sampledVX, sampledVZ = 0,0
				sampleT = 0
			end
			ownerHRP = nil
		end
	end)
else
	attached = false
end

AddSignal["math"] = RunService.PreRender:Connect(function()
	if not ball or not ball:IsA("BasePart") then
		if footballRef and footballRef.Value and footballRef.Value:IsA("BasePart") then
			ball = footballRef.Value
		else
			return
		end
	end

	local bx, bz = ball.Position.X, ball.Position.Z
	local liveVX, liveVZ = ball.Velocity.X, ball.Velocity.Z

	local useVX, useVZ = 0,0
	local now = tick()
	if sampleT > 0 and (now - sampleT) <= RECENT_WINDOW then
		useVX, useVZ = sampledVX, sampledVZ
	elseif not attached then
		useVX, useVZ = liveVX, liveVZ
	else
		if ownerHRP then
			local f = ownerHRP.CFrame.LookVector
			useVX = f.X * KICK_SPEED + ownerHRP.Velocity.X
			useVZ = f.Z * KICK_SPEED + ownerHRP.Velocity.Z
		else
			useVX, useVZ = liveVX, liveVZ
		end
	end

	local gx, gz = hrp.Position.X, hrp.Position.Z
	local rx, rz = bx - gx, bz - gz

	local vv = useVX*useVX + useVZ*useVZ
	local t = 0
	if vv > EPS then
		local vr = useVX * rx + useVZ * rz
		t = - vr / vv
		if t < 0 then t = 0 end
		if t > MAX_T then t = MAX_T end
	else
		t = 0
	end

	predX = bx + useVX * t
	predZ = bz + useVZ * t
end)

local function dive()
	local gx, gz = hrp.Position.X, hrp.Position.Z
	local hx, hz = predX - gx, predZ - gz
	local h2 = hx*hx + hz*hz
	if h2 < 0.01 then return end
	local invH = 1 / math.sqrt(h2)
	local hxU, hzU = hx * invH, hz * invH
	local rv = hrp.CFrame.RightVector
	local rvx, rvz = rv.X, rv.Z
	local r2 = rvx*rvx + rvz*rvz
	if r2 < EPS then return end
	local invR = 1 / math.sqrt(r2)
	local rvxU, rvzU = rvx * invR, rvz * invR
	local dot = hxU * rvxU + hzU * rvzU
	if dot > THRESH then R() elseif dot < -THRESH then L() else ms:Dive() end
end

AddSignal["b2d"] = player:GetMouse().Button2Down:Connect(dive)
