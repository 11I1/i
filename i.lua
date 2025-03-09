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

local killPart
if findID then
    local p, v = plrs:GetPlayers()
    for i = 1, #p do v = p[i] if v ~= plr then ranking[v] = ranking[plr] + 1 end end
    Workspace.ChildAdded:Connect(function(o)
        if not o:IsA'Model' then return end

        s, e = pcall(function() o = plrs[o.Name] end) if not s then return warn(`{e} : Invalid Player!`) end

        ranking[o], p = 1, plrs:GetPlayers()
        for i = 1, #p do v = p[i] if v ~= o then ranking[v] = ranking[v] + 1 end end
    end)

    for _, v in Workspace['Police Station']:GetChildren() do if not (v:IsA'Part' or v:FindFirstChild'Script') then continue end killPart = v; break end
end

warn(killPart)

local function getRank(p) return ranking[plr] < ranking[p] end

local function getPlayer(p)
    p = tostring(p):lower()

    local s, x, v, n, d = plrs:GetPlayers(), #p
    for i = 1, #s do v = s[i] n, d = v.Name:lower(), v.DisplayName:lower() if n:sub(1, x) == p or d:sub(1, x) == p then return v end end return
end

local function getIndexes(a)
    if type(a) ~= 'table' then return end

    for i = 1, #a do utilities.indexes += 1 end return utilities.indexes
end

local function status(p) return p.Character and p.Character.Humanoid.Health ~= 0 or false end

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

local function privateMsg(n, m) dcsce.SayMessageRequest:FireServer(`/w {tostring(n)} {m}`, 'All') end

local function UnequipTools()
    local me = plr.Character
    for _, v in plr.Backpack:GetChildren() do if v.Name ~= 'Stroller' then continue end v.Parent = me end
    task.wait(.1)
    me.Humanoid:UnequipTools()
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
    p = getPlayer(p)
    if not (status(plr) or p or status(p)) then return end

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
    p = getPlayer(p)

    local you, me = p.Character.PrimaryPart, plr.Character

    UnequipTools()

    local tool = plr.Backpack.Stroller
    tool.Parent = me
    tool.Parent = Workspace

    firetouchinterest(tool.Handle, you, 0)
    task.wait(.15)
    p.Character.Humanoid.Health = 0
end)
