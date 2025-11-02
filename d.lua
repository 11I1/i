local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local G = game
local S = G.GetService
local P = S(G,"Players")
local RS = S(G,"ReplicatedStorage")
local Rn = S(G,"RunService")
local VIM = S(G,"VirtualInputManager")

local plr = P.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local ms = require(RS.Controllers.GoalieController)

local k1, k2, s, t = "A", "D", task.wait, 0.02
local function p(k) VIM:SendKeyEvent(true,k,false,G) s(t) VIM:SendKeyEvent(false,k,false,G) end
local function L() p(k1) ms:Dive() end
local function R() p(k2) ms:Dive() end

local fRef, ball = RS:FindFirstChild("Football"), nil
if fRef then ball = fRef.Value end
if not ball then return end

local OnP = ball.OnPlayer
local MAX_T, EPS, THRESH, WINDOW, KICK = 2.0, 1e-6, 0.06, 0.28, 60
local bx, bz, gx, gz, vx, vz, rx, rz, vr, vv, tPred, predX, predZ, hx, hz, h2, invH, dot
local sVX, sVZ, sT, attached, ownerHRP = 0,0,0,false,nil

local function getHRP(p)
	if not p then return end
	local par = p.Parent
	if par and par:IsA("Model") then
		local h = par:FindFirstChild("HumanoidRootPart")
		if h then return h end
	end
end

if OnP and OnP:IsA("BoolValue") then
	attached = OnP.Value
	OnP:GetPropertyChangedSignal("Value"):Connect(function()
		attached = OnP.Value
		if attached then
			ownerHRP = getHRP(OnP.Parent) or getHRP(ball)
			sVX, sVZ, sT = 0,0,0
		else
			local bv = ball.Velocity
			sVX, sVZ, sT = bv.X, bv.Z, tick()
			if math.abs(sVX) < EPS and math.abs(sVZ) < EPS and ownerHRP then
				local f = ownerHRP.CFrame.LookVector
				sVX = f.X*KICK + ownerHRP.Velocity.X
				sVZ = f.Z*KICK + ownerHRP.Velocity.Z
				sT = tick()
			end
			ownerHRP = nil
		end
	end)
end

AddSignal["A"] = Rn.PreRender:Connect(function()
	if not ball:IsA("BasePart") then return end
	bx, bz = ball.Position.X, ball.Position.Z
	local lvx, lvz = ball.Velocity.X, ball.Velocity.Z
	local now = tick()

	if sT > 0 and now - sT <= WINDOW then
		vx, vz = sVX, sVZ
	elseif not attached then
		vx, vz = lvx, lvz
	elseif ownerHRP then
		local f = ownerHRP.CFrame.LookVector
		vx, vz = f.X*KICK + ownerHRP.Velocity.X, f.Z*KICK + ownerHRP.Velocity.Z
	else
		vx, vz = lvx, lvz
	end

	gx, gz = hrp.Position.X, hrp.Position.Z
	rx, rz = bx - gx, bz - gz
	vv = vx*vx + vz*vz
	tPred = 0
	if vv > EPS then
		vr = vx*rx + vz*rz
		tPred = -vr/vv
		if tPred < 0 then tPred = 0 elseif tPred > MAX_T then tPred = MAX_T end
	end
	predX, predZ = bx + vx*tPred, bz + vz*tPred
end)

local rvx, rvz, r2, invR, rvxU, rvzU
local function dive()
	gx, gz = hrp.Position.X, hrp.Position.Z
	hx, hz = predX - gx, predZ - gz
	h2 = hx*hx + hz*hz
	if h2 < 0.01 then return end
	invH = 1/math.sqrt(h2)
	hx, hz = hx*invH, hz*invH
	local rv = hrp.CFrame.RightVector
	rvx, rvz = rv.X, rv.Z
	r2 = rvx*rvx + rvz*rvz
	if r2 < EPS then return end
	invR = 1/math.sqrt(r2)
	rvxU, rvzU = rvx*invR, rvz*invR
	dot = hx*rvxU + hz*rvzU
	if dot > THRESH then R() elseif dot < -THRESH then L() end
end

AddSignal["B"] = plr:GetMouse().Button2Down:Connect(dive)
