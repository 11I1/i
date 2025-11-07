local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local P, R, V, RS, UI = game.Players, game.ReplicatedStorage, game.VirtualInputManager, game.RunService, game.UserInputService
local L, F, G = P.LocalPlayer, R.Football.Value, require(R.Controllers.GoalieController)
local C, MB2 = L.Character, Enum.UserInputType.MouseButton2

local function Press(K)
	V:SendKeyEvent(true, K, false, game)
	task.wait(.02)
	V:SendKeyEvent(false, K, false, game)
end

local DL, DR = function() Press("A") G:Dive() end, function() Press("D") G:Dive() end

AddSignal["b"] = UI.InputBegan:Connect(function(i, g)
	if g or i.UserInputType ~= MB2 then return end
	local vel = F.AssemblyLinearVelocity
	if vel.Magnitude < 5 then
		repeat
			task.wait()
			vel = F.AssemblyLinearVelocity
		until vel.Magnitude >= 5 or not F.Parent
	end
	if not F.Parent then return end
	local pivot = C:GetPivot()
	local pos = F.Position
	local velRel = pivot:VectorToObjectSpace(vel)
	local posRel = pivot:PointToObjectSpace(pos)
	local timeToReach = 0
	if math.abs(velRel.Z) > 0.1 then
		timeToReach = -posRel.Z / velRel.Z
	end
	local predictedX = posRel.X + velRel.X * timeToReach
	if predictedX > 0 then
		DR()
	else
		DL()
	end
	task.spawn(function()
		repeat
			task.wait()
			local newRel = pivot:PointToObjectSpace(F.Position)
		until not F.Parent or newRel.Z > 0
	end)
end)
