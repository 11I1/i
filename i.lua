local api = loadstring(game:HttpGet("https://gist.githubusercontent.com/I1Il/b76a5bb315aefda7687ad6d5705c5946/raw/ac2e5c08aca5b80d22317a34d3bde5dfebe37457/api.lua"))()

local workspace, plrs, rstorage, startergui, rservice = workspace, game.Players, game.ReplicatedStorage, game.StarterGui, game:GetService("RunService")
local id, plr, dcsce = game.PlaceId, plrs.LocalPlayer, rstorage.DefaultChatSystemChatEvents or nil

local utilities, signals, loops, ranking, ids = {"DevConsoleVisible" = false}, {}, {}, {plr = 1}, {1662219031 = "Life In Paradise"}
local findID, Commands = ids.id, {}

task.defer(function()
    for i, v in next, api.cmds do Commands[#Commands + 1] = string.sub(i, 2, #i) end
    Commands = table.concat(Commands, " | ")
end)

if findID then
    for i, v in next, plrs:GetPlayers() do if v ~= plr then ranking.v = ranking.plr + 1 end end
    workspace.ChildAdded:Connect(function(obj)
        obj = obj.Name; obj = plrs[obj] if not obj then return end
        ranking.obj = 1 for i, v in next, ranking do if i ~= obj then ranking.i = v + 1 end end
    end)
end

local function getRank(player)
    if not findID or not player then return end
    return ranking.plr < ranking.player
end

local function getPlayer(player)
    if not player or player == "" then return nil end

    warn("Hello, World!")

    player = player:lower()
    local length, name = #player

    warn("Hello, Universe!")

    for i, v in next, plrs:GetPlayers() do name, i = v.Name:lower(), v.DisplayName:lower() if name:sub(1, length) == player or i:sub(1, length) == player then return v end end return nil
end

local function getIndexes(array)
    if not array or type(array) ~= "table" then return end

    utilities.indexes = 0
    for i, v in next, array do utilities.indexes += 1 end return utilities.indexes
end

local function timer(sec, run)
    if not tonumber(sec) or type(run) ~= "function" then return end

    utilities.osTime = os.time()
    repeat task.wait() until (os.time() - utilities.osTime) >= sec
    run()
end

local function status(player)
    if not player or not player:IsA("Player") then return false end

    local chr = player.Character
    if chr and chr:FindFirstChildOfClass("Humanoid") then return true end return false
end

local function property()
    if not status(plr) then return end

    local children, v = plr.Character:GetChildren()
    for i = 1, #children do v = children[i] if i:IsA("BasePart") then i.Velocity, i.RotVelocity = Vector3.zero, Vector3.zero end end
end

local function radius(obj)
    if not obj or not status(plr) then return false end

    obj = typeof(obj) == "Vector3" and obj or typeof(obj) == "CFrame" and obj.Position or obj:IsA("BasePart") and (obj.CFrame).Position

    return (obj - plr.Character:GetModelCFrame().Position).Magnitude <= 5
end

local function privateMsg(name, msg)
    if not name or not msg then return end
    dcsce.SayMessageRequest:FireServer(string.format("/w %s %s", tostring(name), tostring(msg)), "All")
end

insertCommand("stop", function()
    for i, v in next, signals do if v then v:Disconnect() end end
    for i, v in next, loops do if v then v = false loops[i] = v end end
end)

insertCommand("csl", function()
    utilities.DevConsoleVisible = not utilities.DevConsoleVisible
    startergui:SetCore("DevConsoleVisible", utilities.DevConsoleVisible)
end)

insertCommand("goto", function(player)
    if not status(plr) then return end

    player = getPlayer(player)
    if not player or not status(player) then return end

    api.cmds[`{api.prefix.new}stop `]()

    local obj = plr.Character
    obj.Humanoid:ChangeState(1) property() obj:PivotTo(player.Character:GetModelCFrame())
end)

insertCommand("cmds", function()
    if not Commands or #Commands <= 0 then return end privateMsg(api.fplr.Name, `{"Commands"} [{getIndexes(api.cmds)}]: {Commands}`)
end)

insertCommand("wl", function(player)
    player = getPlayer(player)
    if not player or table.find(api.wl, player.Name) then return end

    api.wl[#api.wl + 1] = player.Name
end)

insertCommand("bl", function(player)
    player = getPlayer(player)
    if not player or not table.find(api.wl, player.Name) then return end

    for i, v in next, api.wl do if player.Name == v then api.wl[i] = nil; break end end
end)

insertCommand("kill", function(player)
    if not findID then return end

    player = getPlayer(player)
    if not player or not status(player) or not status(plr) then return elseif not getRank(player) then return plr.Character.Humanoid:ChangeState(15) end

    api.cmds[`{api.prefix.new}stop`]()

    local obj, objt = plr.Character, player.Character

    task.defer(function() timer(5, function() if status(plr) then obj.Humanoid:ChangeState(15) end end) end)

    local tool, toolParts, killPart = plr.Backpack.Stroller or obj.Stroller, {}
    for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then toolParts[#toolParts + 1] = v end end
    for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then killPart = v; break end end

    obj.Humanoid:UnequipTools()
    for i = 1, 3 do obj.Humanoid.Jump = true task.wait(1/8) end
    tool.Parent = obj

    for i, v in next, toolParts do firetouchinterest(v, objt.PrimaryPart, 0, task.wait(), firetouchinterest(v, objt.PrimaryPart, 1)) end
    repeat task.wait() until radius(objt:GetModelCFrame()) and objt:FindFirstChild("Sitting")
    firetouchinterest(objt.PrimaryPart, killPart, 0, firetouchinterest(objt.PrimaryPart, killPart, 1))
end)

insertCommand("lkill", function(player)
    local Success, Error

    loops.lkill = true
    while loops.lkill do Success, Error = pcall(function() api.cmds[`{api.prefix.new}kill`](player) end) if not Success then loops.lkill = false end plr.CharacterAdded:Wait(1/2):WaitForChild("Humanoid") end
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
