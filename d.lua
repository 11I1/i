getgenv().Signals = getgenv().Signals or {}
for i, v in getgenv().Signals do
    if typeof(v) ~= "RBXScriptConnection" then continue end
    v:Disconnect(); getgenv().Signals[i] = nil
    print(`Disconnected "{i}": <{typeof(v)}> | Memory Cleared!`)
end

local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local P, R, V, RS, UI = game.Players, game.ReplicatedStorage, game.VirtualInputManager, game.RunService, game.UserInputService
local L, F, G = P.LocalPlayer, R.Football.Value, require(R.Controllers.GoalieController)
local PP, OP, before, Q = L.Character.PrimaryPart, F.OnPlayer, F.Before, Enum.KeyCode.Q

local function Press(K)
	V:SendKeyEvent(true, K, false, game)
	task.wait(.02)
	V:SendKeyEvent(false, K, false, game)
end

local DL, DR = function() Press("A") G:Dive() end, function() Press("D") G:Dive() end

AddSignal["a"] = OP:GetPropertyChangedSignal("Value"):Connect(function()
    if OP.Value then return end; Log = 0
    repeat task.wait() until (before.Value.PrimaryPart.Position - F.Position).Magnitude > 11
    Log = PP.CFrame:PointToObjectSpace(F.Position + (F.AssemblyLinearVelocity * 4)).X
end)

AddSignal["b"] = UI.InputBegan:Connect(function(i, g)
	if g or i.KeyCode ~= Q or OP.Value or Log == 0 then return end
    if Log > 0 then DR() else DL() end
end)
