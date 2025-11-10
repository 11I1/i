getgenv().Signals = getgenv().Signals or {}
for i, v in getgenv().Signals do
    if typeof(v) ~= "RBXScriptConnection" then continue end
    v:Disconnect(); getgenv().Signals[i] = nil
    print(`Disconnected "{i}": <{typeof(v)}> | Memory Cleared!`)
end

local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()
local P, R, V, RS, UI = game.Players, game.ReplicatedStorage, game.VirtualInputManager, game.RunService, game.UserInputService
local L, F, G = P.LocalPlayer, R.Football.Value, require(R.Controllers.GoalieController)
local C = L.Character
local H, HUM, OP, Q, cross = C.Head, C.Humanoid, F.OnPlayer, Enum.KeyCode.Q, 0

local function Press(K)
    V:SendKeyEvent(true, K, false, game)
    task.wait(.02)
    V:SendKeyEvent(false, K, false, game)
end

local DL, DR = function() Press("A") G:Dive() end, function() Press("D") G:Dive() end

AddSignal["b"] = UI.InputBegan:Connect(function(i, g)
	if g or i.KeyCode ~= Q or OP.Value then return end; HUM:ChangeState(3)
    task.wait(.015)
	if PP.CFrame.LookVector:Cross(((F.Position + (F.AssemblyLinearVelocity * 3)) - H.Position).Unit).Y > 0 then DL() else DR() end
end)
