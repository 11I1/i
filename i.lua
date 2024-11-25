local api = loadstring(game:HttpGet("https://gist.githubusercontent.com/I1Il/b76a5bb315aefda7687ad6d5705c5946/raw/ac2e5c08aca5b80d22317a34d3bde5dfebe37457/api.lua"))()

local rs, plrs = game:FindFirstChildOfClass("RunService"), game.Players
local plr = plrs.LocalPlayer

local utilities, signals, loops, ranking = {}, {}, {}, {[plr] = 1}

for i, v in next, plrs:GetPlayers() do if v ~= plr then ranking[v] = ranking[plr] + 1 end end
workspace.ChildAdded:Connect(function(object)
    if not plrs:FindFirstChild(object.Name) then
        return
    else
        object = plrs:FindFirstChild(object.Name)
    end

    ranking[object] = 1
    for i, v in next, ranking do if i ~= object then ranking[i] = v + 1 end end
end)

local function getRank(getPlayer)
    if not getPlayer then return end
    if ranking[plr] < ranking[getPlayer] then return true elseif ranking[plr] > ranking[getPlayer] then return false end
end

local function property()
    if not plr.Character then return end
    for i, v in next, plr.Character:GetChildren() do if v:IsA("BasePart") then v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0) end end
end

insertCommand("skill", function(getPlayer)
    if game.PlaceId == 1662219031 then
        local name = tostring(getPlayer):lower()
        for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

        if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if not getRank(getPlayer) then plr.Character.Humanoid:ChangeState(15); return end

        if getPlayer.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Stroller") then api.cmds[api.prefix.new.."skill2"](getPlayer); return elseif plr.Character.Humanoid.Sit or plr.Character:FindFirstChild("Sitting") then plr.Character.Humanoid:ChangeState(1) end

        plr.Character.Humanoid:UnequipTools()
        local tool, parts, part = plr.Backpack["Stroller"] or plr.Character["Stroller"], {}
        for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then table.insert(parts, v) end end
        for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then part = v; break end end

        local function run(clock)
            tool.Parent = plr.Character

            repeat
                if not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 or (os.time() - clock) >= 5 then break end
                plr.Character:PivotTo(part.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(-1.5, 0, 0))
                for i, v in next, parts do getPlayer.Character:PivotTo(v.CFrame); firetouchinterest(getPlayer.Character.PrimaryPart, v, 0, task.wait(), firetouchinterest(getPlayer.Character.PrimaryPart, part, 0)) end
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run, os.time()) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 5 then plr.Character.Humanoid:ChangeState(15); return end until getPlayer.Character.Humanoid.Health <= 0
        plr.Character.Humanoid:ChangeState(15)
    end
end)

insertCommand("as", function(getPlayer)
    if game.PlaceId == 1662219031 then
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

            repeat
                if not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 or (os.time() - clock) >= 5 then break end
                for i, v in next, parts do getPlayer.Character:PivotTo(v.CFrame); firetouchinterest(getPlayer.Character.PrimaryPart, v, 0) end
                task.wait()
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run, os.time()) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 5 then plr.Character.Humanoid:ChangeState(15); return end until getPlayer.Character:FindFirstChild("Sitting")
        plr.Character.Humanoid:ChangeState(15)
    end
end)

insertCommand("skill2", function(getPlayer)
    if game.PlaceId == 1662219031 then
        local name = tostring(getPlayer):lower()
        for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

        if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if not getRank(getPlayer) then plr.Character.Humanoid:ChangeState(15); return end

        if plr.Character.Humanoid.Sit or plr.Character:FindFirstChild("Sitting") then plr.Character.Humanoid:ChangeState(1) end

        plr.Character.Humanoid:UnequipTools()
        local tool, part = plr.Backpack["Stroller"] or plr.Character["Stroller"]
        for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then part = v; break end end

        local function run(clock)
            tool.Parent = plr.Character

            repeat
                if not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 or (os.time() - clock) >= 5 then break end
                plr.Character:PivotTo(part.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(-1.5, 0, 0)); getPlayer.Character:PivotTo(tool.Handle.CFrame)
                firetouchinterest(getPlayer.Character.PrimaryPart, tool.Handle, 0, task.wait(), firetouchinterest(getPlayer.Character.PrimaryPart, part, 0))
                if tool.Parent ~= workspace then tool.Parent = workspace end
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run, os.time()) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 5 then plr.Character.Humanoid:ChangeState(15); return end until getPlayer.Character.Humanoid.Health <= 0
        plr.Character.Humanoid:ChangeState(15)
    end
end)

insertCommand("svoid", function(getPlayer)
    if game.PlaceId == 1662219031 then
        local name = tostring(getPlayer):lower()
        for _, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

        if not plr.Character or not plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if plr.Character.Humanoid.Sit or plr.Character:FindFirstChild("Sitting") then plr.Character.Humanoid:ChangeState(1) end

        plr.Character.Humanoid:UnequipTools()
        local tool = plr.Backpack["Stroller"] or plr.Character["Stroller"]

        local function run(clock)
            workspace.Events.Morph.Player:FireServer("Sheep")
            tool.Parent = plr.Character

            repeat task.wait()
                if not getPlayer.Character or not getPlayer.Character:FindFirstChildOfClass("Humanoid") or getPlayer.Character.Humanoid.Health <= 0 or (os.time() - clock) >= 5 then break end
                getPlayer.Character:PivotTo(tool.Handle.CFrame)
                firetouchinterest(getPlayer.Character.PrimaryPart, tool.Handle, 0)
                if tool.Parent ~= workspace then tool.Parent = workspace end
            until getPlayer.Character:FindFirstChild("Sitting")

            plr.Character:PivotTo(CFrame.new(0, workspace.FallenPartsDestroyHeight + 10, 0))
        end task.spawn(function() pcall(run, os.time()) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 5 then plr.Character.Humanoid:ChangeState(15); return end until getPlayer.Character.Humanoid.Health <= 0
        plr.Character.Humanoid:ChangeState(15)
    end
end)

insertCommand("lskill", function(getPlayer)
    api.cmds[api.prefix.new.."stop"]()
    signals.lskill = rs.RenderStepped:Connect(function()
        api.cmds[api.prefix.new.."skill"](getPlayer); plr.CharacterAdded:Wait(); task.wait(plrs.RespawnTime)
    end)
end)

insertCommand("lskill2", function(getPlayer)
    api.cmds[api.prefix.new.."stop"]()
    signals.lskill2 = rs.RenderStepped:Connect(function()
        api.cmds[api.prefix.new.."skill2"](getPlayer); plr.CharacterAdded:Wait(); task.wait(plrs.RespawnTime)
    end)
end)

insertCommand("stop", function()
    for i, v in next, signals do if v then v:Disconnect() end end
    for i, v in next, loops do if v then v = false end end
end)
