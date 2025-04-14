local Game, GetGenv = game, getgenv()

for i, v in GetGenv do if typeof(v) == 'RBXScriptConnection' then v:Disconnect() GetGenv[i] = nil end end

local Players, ReplicatedStorage = Game.Players, Game.ReplicatedStorage
if #Players:GetPlayers() == 1 then return warn'Not Enough Players!' end
local LocalPlayer = Players.LocalPlayer

local function Show(Player)
    local Name = Player.Name
    task.wait(1)
    local Character = Player.Character if not Character then return warn(`Failed: {Name}`) end
    local Folder = Character:FindFirstChild'Values' if not Folder then return warn(`Folder Invalid: {Name}`) end
    local Dribbling = Folder.Dribbling
    local ForceField = Instance.new('ForceField', Character)

    ForceField.Name, ForceField.Visible = 'Display', false

    GetGenv[Name] = Dribbling:GetPropertyChangedSignal'Value':Connect(function() if not Dribbling.Value then ForceField.Visible = true task.delay(2, function() ForceField.Visible = false end) end end)
    GetGenv[`@{Name}`] = Player.CharacterRemoving:Connect(function() GetGenv[Name]:Disconnect() GetGenv[`@{Name}`]:Disconnect() GetGenv[Name], GetGenv[`@{Name}`], Name, Dribbling, ForceField = nil, nil, nil, nil, nil end)
    Success, Character, Folder = nil, nil, nil
end

for _, v in Players:GetPlayers() do if v ~= LocalPlayer then GetGenv[`#{v.Name}`] = v.CharacterAdded:Connect(function() Show(v) end) Show(v) end end

Players.PlayerAdded:Connect(Show)
Players.PlayerRemoving:Connect(function(Player)
    local Name = `#{Player.Name}`

    if not GetGenv[Name] then return warn(`Failed To Clear {Player.Name}'s Data!`) end

    GetGenv[Name]:Disconnect()
    GetGenv[Name], Name = nil, nil
end)

Game, ReplicatedStorage, Players = nil, nil, nil
