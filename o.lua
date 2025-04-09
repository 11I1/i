local Game = game
local Workspace, Players, ReplicatedStorage = workspace, Game.Players, Game.ReplicatedStorage
local Player, Football = Players.LocalPlayer, ReplicatedStorage.Football
local Character, Value = Player.Character, Football.Value
local Table = {
    'Cards',
    'Debris',
    'FlowJunk',
    'FlowJunk(Client)',
    'Ignore',
    'Leaderboards',
    'Limited',
    'Limiteds',
    'LobbyVFX',
    'Mythics',
    'PenaltyArea',
    'Plankton',
    'ServerSettings',
    'SmallSquare',
    'TeamPositions',
    'ValentinesVFX',
    'Week1',
    'loveemote',
    'BallSpawn',
    'PERMA_AWAKEN',
    'SPAWN_ON_PITCH',
    'SpawnLocation',
    'FlowCharacter',
    'Model',
    'Quests',
    'Quests2',
    'Quests3',
    'ShopRig',
    'SoccerMap2',
    'TempPodium',
    'TextModel14',
    'Texts',
    'VIP',
    'AnimeProx',
    'BG',
    'Billbaorddon',
    'Billboard',
    'Billboardchristmas',
    'Christmas',
    'SelectTeam',
    'Shop',
    'ToxicProx',
    'UpdateTimer',
    'WheelSpin',
    'gamepass',
    'CrowdMap2',
    'LobbyCam'
}

Workspace.Camera:ClearAllChildren()
Workspace.Terrain:ClearAllChildren()

for _, v in Workspace:GetChildren() do if table.find(Table, v.Name) then v:Remove() end end
for _, v in Workspace:GetDescendants() do if v:IsA'MeshPart' and v ~= Value and not (v:IsDescendantOf(Character) and v:IsDescendantOf(Value)) then v:Remove() elseif v:IsA'ParticleEmitter' or v:IsA'Beam' or v:IsA'Trail' then v:Remove() end end

for _, v in Game.MaterialService:GetChildren() do if v.Name ~= 'Artificial Grass Material' then v:Remove() end end

for _, v in Game.Lighting:GetChildren() do if v.Name ~= 'Blur' then v:Remove() end end

local Scripts = {
    'Strange',
    'RbxCharacterSounds',
    'LocalScript',
    'ClientReplicatorHandler',
    'CrowdAnim',
    'SmartBoneRuntime',
    'ProximityPrompt'
}

for _, v in getrunningscripts() do if table.find(Scripts, v.Name) then v.Disabled = true v:Remove() end end

for _, v in ReplicatedStorage:GetDescendants() do if v:IsA'ParticleEmitter' or v:IsA'Trail' or v:IsA'Beam' or v:IsA'Texture' or v:IsA'Decal' or (v:IsA'MeshPart' and v.Name ~= 'Ring') then v:Remove() end end

Game, Workspace, Players, ReplicatedStorage, Player, Football, Character, Value, Table, Scripts = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
