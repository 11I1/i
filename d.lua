local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local P, R, V, RS, UI = game.Players, game.ReplicatedStorage, game.VirtualInputManager, game.RunService, game.UserInputService
local L, F, G = P.LocalPlayer, R.Football.Value, require(R.Controllers.GoalieController)
local PP, OP, Q = L.Character.PrimaryPart, F.OnPlayer, Enum.KeyCode.Q
local hum = L.Character.Humanoid

local function Press(K)
	V:SendKeyEvent(true, K, false, game)
	task.wait(.067)
	V:SendKeyEvent(false, K, false, game)
end

local DL, DR = function() Press("A") G:Dive() end, function() Press("D") G:Dive() end

AddSignal["a"] = OP:GetPropertyChangedSignal("Value"):Connect(function()
    if OP.Value then return end; Log = 0
    repeat task.wait() until (F.Before.Value.HumanoidRootPart.Position - F.Position).Magnitude > 15
    Log = PP.CFrame:PointToObjectSpace((F.Position + (F.AssemblyLinearVelocity * 15)) - PP.Position).X
end)

AddSignal["b"] = UI.InputBegan:Connect(function(i, g)
	if g or i.KeyCode ~= Q or OP.Value or Log == 0 then return end
    if Log > 0 then DR() else DL() end
end)
