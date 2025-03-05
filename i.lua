local Game, api = game
api = loadstring(Game:HttpGet('https://gist.githubusercontent.com/I1Il/b76a5bb315aefda7687ad6d5705c5946/raw/ac2e5c08aca5b80d22317a34d3bde5dfebe37457/api.lua'))()

local Workspace, plrs, rstorage, startergui, rservice = workspace, Game.Players, Game.ReplicatedStorage, Game.StarterGui, Game:GetService'RunService'
local id, plr, dcsce = Game.PlaceId, plrs.LocalPlayer, rstorage.DefaultChatSystemChatEvents or nil

local utilities, signals, loops, ranking, ids = {['DevConsoleVisible'] = false}, {}, {}, {[plr] = 1}, {[1662219031] = 'Life In Paradise'}
local findID, Commands = ids[id], {}

Workspace.FallenPartsDestroyHeight = 0/0

task.defer(function()
    for i, v in api.cmds do Commands[#Commands + 1] = i:sub(2, #i) end
    Commands = table.concat(Commands, ' | ')
end)

if findID then
    local p, v = plrs:GetPlayers()
    for i = 1, #p do v = p[i] if v ~= plr then ranking[v] = ranking[plr] + 1 end end
    Workspace.ChildAdded:Connect(function(o)
        if not o:IsA'Model' then return end

        s, e = pcall(function()
            o = plrs[o.Name]
        end) if not s then return warn(`{e} : Invalid Player!`) end

        ranking[o], p = 1, plrs:GetPlayers()
        for i = 1, #p do v = p[i] if v ~= o then ranking[v] = ranking[v] + 1 end end
    end)
end

local function getRank(p)
    if not findID then return end
    return ranking[plr] < ranking[p]
end

local function getPlayer(p)
    p = tostring(p):lower()

    local s, x, v, n, d = plrs:GetPlayers(), #p
    for i = 1, #s do v = s[i] n, d = v.Name:lower(), v.DisplayName:lower() if n:sub(1, x) == p or d:sub(1, x) == p then return v end end return
end

local function getIndexes(a)
    if type(a) ~= 'table' then return end

    for i = 1, #a do utilities.indexes += 1 end return utilities.indexes
end

local function status(p)
    return p.Character ~= nil
end

local function property()
    if not status(plr) then return end

    local c, v = plr.Character:GetChildren()
    for i = 1, #c do v = c[i] if v:IsA'BasePart' then v.Velocity, v.RotVelocity = Vector3.zero, Vector3.zero end end
end

local function radius(o)
    if not o or not status(plr) then return end

    o = typeof(o) == 'Vector3' and o or typeof(o) == 'CFrame' and o.Position or o:IsA('BasePart') and (o.CFrame).Position

    return (o - (plr.Character.PrimaryPart.CFrame).Position).Magnitude <= 5
end

local function privateMsg(n, m)
    dcsce.SayMessageRequest:FireServer(`/w {tostring(n)} {m}`, 'All')
end

insertCommand('stop', function()
    for i, v in signals do v:Disconnect() end
    for i, v in loops do loops[i] = false end
end)

insertCommand('csl', function()
    utilities.DevConsoleVisible = not utilities.DevConsoleVisible
    startergui:SetCore('DevConsoleVisible', utilities.DevConsoleVisible)
end)

insertCommand('goto', function(p)
    if not status(plr) then return end

    p = getPlayer(p)
    if not p or not status(p) then return end

    api.cmds[`{api.prefix.new}stop`]()

    local o = plr.Character
    o.Humanoid:ChangeState(1) property() o:PivotTo(p.Character:GetModelCFrame())
end)

insertCommand('cmds', function()
    if not Commands or #Commands <= 0 then return end privateMsg(api.fplr.Name, `{'Commands'} [{getIndexes(api.cmds)}]: {Commands}`)
end)

insertCommand('wl', function(p)
    p = getPlayer(p).Name
    if table.find(api.wl, p) then return end
    api.wl[#api.wl + 1] = p
end)

insertCommand('bl', function(p)
    p = getPlayer(p).Name
    if not table.find(api.wl, p) then return end
    for i = 1, #api.wl do if api.wl[i] == p then api.wl[i] = nil; break end end
end)

insertCommand('kill', function(p)
    if not status(plr) then return end

    local o = plr.Character
    o:PivotTo(o.PrimaryPart.CFrame * CFrame.new(0, workspace.FallenPartsDestroyHeight - 2, 0))
    task.wait(0.1)
 
    local h = o.Humanoid
    h:UnequipTools()

    p = getPlayer(p)
    if not p or not status(p) then return elseif not getRank(p) then h.Health = 0 return end
    p = p.Character

    local q, s, j, v, a, k = p.PrimaryPart, plr.Backpack.Stroller, workspace['Police Station']:GetChildren() local g = s:GetChildren()
    for i = 1, #g do v = g[i] if v:IsA'BasePart' and v:FindFirstChild'TouchInterest' then a = v; break end end
    for i = 1, #j do v = j[i] if v:IsA'BasePart' and v:FindFirstChild'TouchInterest' then k = v; break end end

    s.Parent = o

    firetouchinterest(a, q, 0, task.wait(), firetouchinterest(a, q, 1))
    firetouchinterest(q, k, 0, task.wait(0.25), firetouchinterest(q, k, 1))

    task.wait(0.1) h.Health = 0
end)

insertCommand('lkill', function(p)
    api.cmds[`{api.prefix.new}stop`]()

    loops.lkill = true
    for i = 1, math.huge do
        if not loops.lkill then break end

        api.cmds[`{api.prefix.new}kill`](p)

        plr.CharacterAdded:Wait()
        repeat task.wait() until plr.Character:FindFirstChild'Humanoid'
    end
end)

insertCommand('re', function()
    if not status(plr) then return end
    plr.Character.Humanoid.Health = 0
end)

insertCommand('rt', function()
    local c, h, t
    for i, v in plrs:GetPlayers() do
        c = v.Character or nil
        if not c then continue end

        h, t = c.Head, c.Torso
        if not h:FindFirstChild'130213380' then continue end
        for _, o in t:GetChildren() do if not (o:IsA'Part' or o:IsA'Weld') then continue end o:Remove() end
    end
end)
