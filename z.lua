local Game, GetGenv, Workspace = game, getgenv(), workspace
sethiddenproperty(Workspace, 'StreamingMinRadius', 0) sethiddenproperty(Workspace, 'StreamingTargetRadius', 0)
settings().Network.IncomingReplicationLag, Workspace.StreamingEnabled = 0, true
for i, v in GetGenv do if typeof(v) == 'RBXScriptConnection' then v:Disconnect() GetGenv[i] = nil end end

local Football
for _, v in Workspace:GetDescendants() do if v.Name == 'Football' then Football = v; break end end
if not Football then return end

local Hitbox = Football:FindFirstChild'Hitbox'
if not Hitbox then return end

local Players, ReplicatedStorage, RunService = Game.Players, Game.ReplicatedStorage, Game:GetService'RunService'
local Player = Players.LocalPlayer

local function Highlight(Name, Character)
    if not Character then return end
    local Humanoid = Character:FindFirstChild'Humanoid'
    if not Humanoid or Humanoid.Health == 0 then return end

    local Dribbling = Character:FindFirstChild'Values' and Character.Values:FindFirstChild'Dribbling'
    if not Dribbling then return end

    for _, v in Character:GetChildren() do if v:IsA'ForceField' and v.Name == 'Display' then v:Remove() end end

    local ForceField = Instance.new('ForceField', Character)
    ForceField.Name, ForceField.Visible = 'Display', false

    GetGenv[Name] = Dribbling:GetPropertyChangedSignal'Value':Connect(function() if not Dribbling.Value then ForceField.Visible = true task.delay(2, function() ForceField.Visible = false end) end end)
end

local user, model
local function connectCharacterAdded(player) user, model = player.Name, player.Character if model then Highlight(user, model) end GetGenv[user] = player.CharacterAdded:Connect(function(Character) if Character then Highlight(user, Character) end end) end
for _, v in Players:GetPlayers() do connectCharacterAdded(v) end
GetGenv['PlayerAdded'] = Players.PlayerAdded:Connect(connectCharacterAdded)
GetGenv['PlayerRemoving'] = Players.PlayerRemoving:Connect(function(Client) if GetGenv[Client.Name] then GetGenv[Client.Name]:Disconnect() GetGenv[Client.Name] = nil end end)

local Character, Constant, Vector = Player.Character, Vector3.zero, Vector3.new(25, 15, 25)
for i, v in Workspace:GetDescendants() do if v:IsA'MeshPart' and not (v:IsDescendantOf(Character) and v:IsDescendantOf(Football)) and v.Name ~= 'Football' then v:Remove() end end
GetGenv['PostSimulation'] = RunService.PostSimulation:Connect(function() Hitbox.Size = Constant end)
local Max, PlayerStats, Values = math.huge, Player.PlayerStats, Character.Values
local Stamina, Controllers = PlayerStats.Stamina, ReplicatedStorage.Controllers
GetGenv['Stamina'] = Stamina:GetPropertyChangedSignal'Value':Connect(function() Stamina.Value = Max end)
local Mouse, OnPlayer, Char, ModelHitbox, HasBall, BallController = Player:GetMouse(), Football.OnPlayer, Football.Char, Character.Hitbox, Values.HasBall, require(Controllers.BallController)
GetGenv['Size'] = Football:GetPropertyChangedSignal'Parent':Connect(function() if ModelHitbox then ModelHitbox.Size = (Football.Parent == Character) and Constant or Vector end end)
GetGenv['Slide'] = Mouse.KeyDown:Connect(function(Key)
    if Key ~= 'e' or HasBall.Value then return end

    Character:PivotTo(CFrame.lookAt(Character:GetModelCFrame().Position, Football.Position + (Football.AssemblyLinearVelocity * 1)))
    BallController:Slide()

    local Model = Char.Value
    if Model and not (Workspace:FindFirstChild'Football' and Value.Values.Dribbling.Value) then firetouchinterest(ModelHitbox, Hitbox, 0) end
end)
