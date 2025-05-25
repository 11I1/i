local Workspace, Objects = workspace, {
    ['nutmeg'] = true,
    ['WheelSpin'] = true,
    ['UpdateTimer'] = true,
    ['ToxicProx'] = true,
    ['Shop'] = true,
    ['Christmas'] = true,
    ['Billboardchristmas'] = true,
    ['Billboard'] = true,
    ['Billbaorddon'] = true,
    ['BG'] = true,
    ['AnimeProx'] = true,
    ['Cylinder'] = true,
    ['VIP'] = true,
    ['Texts'] = true,
    ['Surfboard'] = true,
    ['SoccerMap3'] = true,
    ['Showroom'] = true,
    ['ShopRig'] = true,
    ['Rubber Duck Floaty'] = true,
    ['CrowdMap2'] = true,
    ['Quests3'] = true,
    ['Quests2'] = true,
    ['Quests'] = true,
    ['PreloadDummy'] = true,
    ['OriginalLimiteds'] = true,
    ['NewLobby'] = true,
    ['Model'] = true,
    ['FlowCharacter'] = true,
    ['WaterStuff'] = true,
    ['Stocks'] = true,
    ['Rin SimpleDomain'] = true,
    ['Plankton'] = true,
    ['PassoBemSoltoEmote'] = true,
    ['Mythics'] = true,
    ['MTX_ZONES'] = true,
    ['LobbyVFX'] = true,
    ['Limiteds'] = true,
    ['Leaderboards'] = true,
    ['Ignore'] = true,
    ['Hiori'] = true,
    ['GoalEffect'] = true,
    ['Goal Explosions 4'] = true,
    ['FlowJunk(Client)'] = true,
    ['FlowJunk'] = true,
    ['EgoSummer'] = true,
    ['EggModels'] = true,
    ['EggHuntContent'] = true,
    ['EasterEvent'] = true,
    ['Debris'] = true,
    ['Cards'] = true,
    ['Awakening Hiori with VL'] = true
}

Workspace.Terrain:ClearAllChildren()

for _, v in Workspace:GetChildren() do local Name = v.Name if Objects[Name] then Objects[Name] = nil v:Remove() end Name = nil end

Objects = nil

local Camera, Classes = Workspace.Camera, {
    Texture = true,
    Decal = true
}

for _, v in game:GetDescendants() do if Classes[v.ClassName] and not v:IsDescendantOf(Camera) then v:Remove() end end

for i in Classes do Classes[i] = nil end
Workspace, Camera, Classes = nil, nil, nil
