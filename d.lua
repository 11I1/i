local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local P, R, V, RS, UI = game.Players, game.ReplicatedStorage, game.VirtualInputManager, game.RunService, game.UserInputService
local L, F, G = P.LocalPlayer, R.Football.Value, require(R.Controllers.GoalieController)
local PP, MB2 = L.Character.PrimaryPart, Enum.UserInputType.MouseButton2

local function Press(K)
	V:SendKeyEvent(true, K, false, game)
	task.wait(0.01)
	V:SendKeyEvent(false, K, false, game)
end

local DL, DR = function() Press("A") G:Dive() end, function() Press("D") G:Dive() end

AddSignal["b"] = UI.InputBegan:Connect(function(i, g)
	if g or i.UserInputType ~= MB2 then return end
	if PP.CFrame:PointToObjectSpace(F.Position).X > 0 then DR() else DL() end
end)
