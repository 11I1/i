local Game, GetGenv = game, getgenv()
for i, v in GetGenv do if typeof(v) ~= 'RBXScriptConnection' then continue end v:Disconnect() GetGenv[i] = nil end

local Players, ReplicatedStorage, GuiService, VirtualInputManager = Game.Players, Game.ReplicatedStorage, Game.GuiService, Game:GetService("VirtualInputManager")
local LocalPlayer, Events = Players.LocalPlayer, ReplicatedStorage.events
local Character, Backpack, PlayerGui, Sell, Catch = LocalPlayer.Character, LocalPlayer.Backpack, LocalPlayer.PlayerGui, Events.SellAll, Events['reelfinished ']
local Tool = Backpack:FindFirstChild('Ethereal Prism Rod') or Character:FindFirstChild('Ethereal Prism Rod')
local Folder = Tool.events
local Cast, Reset = Folder.cast, Folder.reset

GetGenv['PlayerGui'] = PlayerGui.ChildAdded:Connect(function(Object)
    if Object.Name == 'shakeui' then
        local SafeZone = Object.safezone
        repeat
            repeat task.wait() until SafeZone:FindFirstChild('button')
            local Button = SafeZone.button
            GuiService.SelectedObject = Button
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, Game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, Game)
        until not PlayerGui:FindFirstChild('shakeui')
    elseif Object.Name == 'reel' then
        local Bar = Object.bar
        local PlayerBar = Bar.playerbar
        PlayerBar.Size = UDim2.new(.75, 0, 1, 0)
        Catch:FireServer(100, true)
        Reset:FireServer() Sell:InvokeServer()
    end
end)

Tool.Parent = Character
task.wait(1/2)

GetGenv['Cast'] = Game:GetService("RunService").Heartbeat:Connect(function()
    if PlayerGui:FindFirstChild('reel') or Tool.Parent ~= Character then return end
    Cast:FireServer(100, 1)
end)