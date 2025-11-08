local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local P, R, V, RS, UI = game.Players, game.ReplicatedStorage, game.VirtualInputManager, game.RunService, game.UserInputService
local L, F, G = P.LocalPlayer, R.Football.Value, require(R.Controllers.GoalieController)
local PP, Q, OP, Log = L.Character.PrimaryPart, Enum.KeyCode.Q, F.OnPlayer, 0

local function Press(K)
	V:SendKeyEvent(true, K, false, game)
	task.wait(.03)
	V:SendKeyEvent(false, K, false, game)
end

local DL, DR = function() Press("A") G:Dive() end, function() Press("D") G:Dive() end

AddSignal["p"] = OP:GetPropertyChangedSignal("Value"):Connect(function()
    if OP.Value then return end; Log = 0
    task.wait(.03)
    Log = ((F.Position + (F.AssemblyLinearVelocity * 3)) - PP.Position).Unit:Dot(PP.CFrame.RightVector)
end)

AddSignal["a"] = UI.InputBegan:Connect(function(i, g)
	if g or i.KeyCode ~= Q or OP.Value or Log == 0 then return end
    if Log > 0 then DR() else DL() end
end)
