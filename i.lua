local api = loadstring(game:HttpGet("https://gist.githubusercontent.com/I1Il/b76a5bb315aefda7687ad6d5705c5946/raw/ac2e5c08aca5b80d22317a34d3bde5dfebe37457/api.lua"))()

local workspace, plrs, rstorage, startergui, rservice = workspace, game.Players, game.ReplicatedStorage, game.StarterGui, game:GetService("RunService")
local id, plr, dcsce = game.PlaceId, plrs.LocalPlayer, rstorage.DefaultChatSystemChatEvents or nil

local utilities, signals, loops, ranking, ids = {["DevConsoleVisible"] = false}, {}, {}, {[plr] = 1}, {[1662219031] = "Life In Paradise"}
local findID, Commands = ids[id], {}

task.defer(function()
    for i, v in next, api.cmds do Commands[#Commands + 1] = string.sub(i, 2, #i) end
    Commands = table.concat(Commands, " | ")
end)

if findID then
    local p, v = plrs:GetPlayers()
    for i = 1, #p do v = p[i] if v ~= plr then ranking[v] = ranking[plr] + 1 end end
    workspace.ChildAdded:Connect(function(o)
        if not o:IsA("Model") then return end

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
    for i = 1, #s do v = s[i]; n, d = v.Name:lower(), v.DisplayName:lower() if n:sub(1, x) == p or d:sub(1, x) == p then return v end end

    return nil
end

local function getIndexes(a)
    if not a or type(a) ~= "table" then return end

    for i = 1, #a do utilities.indexes += 1 end return utilities.indexes
end

local function timer(s, f)
    if not tonumber(s) or type(f) ~= "function" then return end

    utilities.osTime = os.time()
    repeat task.wait() until (os.time() - utilities.osTime) >= s

    f()
end

local function status(p)
    if not p or not p.Parent ~= plrs then return end

    local c = plr.Character or nil
    return c and c.Humanoid or nil ~= nil
end

local function property()
    if not status(plr) then return end

    local c, v = plr.Character:GetChildren()
    for i = 1, #c do v = c[i] if v:IsA("BasePart") then v.Velocity, v.RotVelocity = Vector3.zero, Vector3.zero end end
end

local function radius(o)
    if not o or not status(plr) then return end

    o = typeof(o) == "Vector3" and o or typeof(o) == "CFrame" and o.Position or o:IsA("BasePart") and (o.CFrame).Position

    return (o - plr.Character:GetModelCFrame().Position).Magnitude <= 5
end

local function privateMsg(n, m)
    if not n or not m then return end
    dcsce.SayMessageRequest:FireServer(`/w {n} {m}`, "All")
end

insertCommand("stop", function()
    for i, v in next, signals do v:Disconnect() end
    for i, v in next, loops do loops[i] = false end
end)

insertCommand("csl", function()
    utilities.DevConsoleVisible = not utilities.DevConsoleVisible
    startergui:SetCore("DevConsoleVisible", utilities.DevConsoleVisible)
end)

insertCommand("goto", function(p)
    if not status(plr) then return end

    p = getPlayer(p)
    if not p or not status(p) then return end

    api.cmds[`{api.prefix.new}stop`]()

    local o = plr.Character
    o.Humanoid:ChangeState(1) property() o:PivotTo(p.Character:GetModelCFrame())
end)

insertCommand("cmds", function()
    if not Commands or #Commands <= 0 then return end privateMsg(api.fplr.Name, `{"Commands"} [{getIndexes(api.cmds)}]: {Commands}`)
end)

insertCommand("wl", function(p)
    p = getPlayer(p)
    if not p or table.find(api.wl, p.Name) then return end

    api.wl[#api.wl + 1] = p.Name
end)

insertCommand("bl", function(p)
    p = getPlayer(p)
    if not p or not table.find(api.wl, p.Name) then return end

    local p, v = p.Name
    for i = 1, #api.wl do v = api.wl[i] if p == v then api.wl[i] = nil; break end end
end)

insertCommand("kill", function(p)
    if not findID then return end

    p= getPlayer(p)
    if not p or not status(p) or not status(plr) then return elseif not getRank(p) then return plr.Character.Humanoid:ChangeState(15) end

    local obj, objt = plr.Character, p.Character

    task.defer(function() timer(5, function() if status(plr) then obj.Humanoid:ChangeState(15) end end) end)

    local tool, toolParts, killPart = plr.Backpack.Stroller or obj.Stroller, {}
    for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then toolParts[#toolParts + 1] = v end end
    for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then killPart = v; break end end

    obj.Humanoid:UnequipTools()
    for i = 1, 3 do obj.Humanoid.Jump = true task.wait(1/8) end
    tool.Parent = obj

    for i = 1, #toolParts do firetouchinterest(toolParts[i], objt.PrimaryPart, 0, task.wait(), firetouchinterest(toolParts[i], objt.PrimaryPart, 1)) end
    repeat task.wait() until radius(objt:GetModelCFrame()) and objt:FindFirstChild("Sitting")
    firetouchinterest(objt.PrimaryPart, killPart, 0, firetouchinterest(objt.PrimaryPart, killPart, 1))
end)

insertCommand("lkill", function(p)
    api.cmds[`{api.prefix.new}stop`]()

    loops.lkill = true
    for i = 1, math.huge do
        if not loops.lkill then break end

        api.cmds[`{api.prefix.new}kill`](p)

        plr.CharacterAdded:Wait()
        local chr = plr.Character
        repeat task.wait() until chr:FindFirstChildOfClass("Humanoid")
    end
end)

insertCommand("as", function(getPlayer)
    if not table.find(id, game.PlaceId) then return end
    local name = tostring(getPlayer):lower()
    for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

    if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 then
        return
    end

    if getPlayer.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Stroller") then return elseif plr.Character.Humanoid.Sit or plr.Character:FindFirstChild("Sitting") then plr.Character.Humanoid:ChangeState(1) end

    plr.Character.Humanoid:UnequipTools()
    local tool, parts = plr.Backpack["Stroller"] or plr.Character["Stroller"], {}
    for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then table.insert(parts, v) end end

    local function run(clock)
        tool.Parent = plr.Character

        repeat task.wait()
            if not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 or (os.time() - clock) >= 5 then break end
            for i, v in next, parts do firetouchinterest(getPlayer.Character.PrimaryPart, v, 0) end
        until plr.Character.Humanoid.Health <= 0
    end; spawn(function() pcall(run, os.time()) end)

    local clock = os.time()
    repeat task.wait(); if (os.time() - clock) >= 5 then plr.Character.Humanoid:ChangeState(15); return end until plr.Character.Humanoid.Health <= 0
end)

insertCommand("skill2", function(getPlayer)
    if not table.find(id, game.PlaceId) then return end
    local name = tostring(getPlayer):lower()
    for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

    if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 then
        return
    end

    if not getRank(getPlayer) then plr.Character.Humanoid:ChangeState(15); return end

    if plr.Character.Humanoid.Sit or plr.Character:FindFirstChild("Sitting") then plr.Character.Humanoid:ChangeState(1) end

    plr.Character.Humanoid:UnequipTools()
    plr.Character:PivotTo(CFrame.new(0, -250, 0)); wait(1/8)

    local tool, part = plr.Backpack["Stroller"] or plr.Character["Stroller"]
    for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then part = v; break end end

    local function run(clock)
        repeat
            if not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 or (os.time() - clock) >= 5 then break end
            plr.Character:PivotTo(part.CFrame * CFrame.new(0, 5, -3/2) * CFrame.Angles(-1.5, 0, 0))
            firetouchinterest(tool.Handle, getPlayer.Character.PrimaryPart, 0, task.wait(), firetouchinterest(getPlayer.Character.PrimaryPart, part, 0))
        until plr.Character.Humanoid.Health <= 0
    end; spawn(function() pcall(run, os.time()) end)

    tool.Parent, tool.Parent = plr.Character, workspace

    local clock = os.time()
    repeat task.wait(); if (os.time() - clock) >= 5 then plr.Character.Humanoid:ChangeState(15); return end until plr.Character.Humanoid.Health <= 0
end)

insertCommand("svoid", function(getPlayer)
    if not table.find(id, game.PlaceId) then return end
    local name = tostring(getPlayer):lower()
    for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

    if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 then
        return
    end

    if plr.Character.Humanoid.Sit or plr.Character:FindFirstChild("Sitting") then plr.Character.Humanoid:ChangeState(1) end

    plr.Character.Humanoid:UnequipTools()
    plr.Character:PivotTo(CFrame.new(0, workspace.FallenPartsDestroyHeight + 250, 0)); wait(1)

    local tool = plr.Backpack["Stroller"] or plr.Character["Stroller"]
    tool.Parent = plr.Character
    tool.Parent = workspace
    firetouchinterest(tool.Handle, getPlayer.Character.PrimaryPart, 0)
end)

insertCommand("vs", function()
    if not table.find(id, game.PlaceId) then return end
    local name = tostring(getPlayer):lower()
    for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

    if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 then
        return
    end

    local oldCF = plr.Character:GetModelCFrame()

    workspace.FallenPartsDestroyHeight = 0/0

    plr.Character.Humanoid:ChangeState(1)
    plr.Character:PivotTo(CFrame.new(0, workspace.FallenPartsDestroyHeight + 5, 0))

    plr.Character.Humanoid:UnequipTools()
    repeat task.wait(); plr.Character.Humanoid.Jump = true until not plr.Character:FindFirstChild("Sitting") or not plr.Character.Humanoid.Sit

    plr.Character:PivotTo(oldCF)
end)
