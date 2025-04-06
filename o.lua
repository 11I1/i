local Workspace = workspace
local Running = {'SmartBoneRuntime', 'Strange'}
local Delete = {
    'Cards',
    'Debris',
    'FlowJunk',
    'FlowJunk(Client)',
    'Leaderboards',
    'Limiteds',
    'LobbyVFX',
    'Mythics',
    'ValentinesVFX',
    'Week1',
    'loveemote',
    'BG',
    'AnimeProx',
    'Billbaorddon',
    'Billboard',
    'Billboardchristmas',
    'Christmas',
    'GoalEffectCam',
    'LobbyCam',
    'SelectTeam',
    'Shop',
    'ToxicProx',
    'UpdateTimer',
    'WheelSpin',
    'gamepass',
    'Ignore',
    'ServerSettings',
    'Quests',
    'Quests2',
    'Quests3',
    'ShopRig',
    'TextModel14',
    'Texts',
    'VIP',
    'Model',
    'FlowCharacter',
}

game.MaterialService:ClearAllChildren()
Workspace.Camera:ClearAllChildren()
Workspace.Terrain:ClearAllChildren()

for i, v in getrunningscripts() do if table.find(Running, v.Name) then v:Remove() end end
for i, v in Workspace:GetChildren() do if table.find(Delete, v.Name) then v:Remove() end end

Workspace, Delete, Running = nil, nil, nil
