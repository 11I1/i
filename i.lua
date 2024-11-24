local api = (loadstring(game:HttpGet("https://gist.githubusercontent.com/I1Il/b76a5bb315aefda7687ad6d5705c5946/raw/ac2e5c08aca5b80d22317a34d3bde5dfebe37457/api.lua"))())

local plrs = (game:GetService("Players"))
local plr = (plrs.LocalPlayer)

local rs
local loop = (false)
local loops = {}; table.clear(loops)
local utilities = {}; table.clear(utilities)

repeat task.wait() until (loop ~= true) and ((tonumber(#loops)) <= (0)) and ((tonumber(#utilities)) <= (0))

function property()
    if not plr.Character then return end
    for i, v in next, plr.Character:GetChildren() do
        if v:IsA("BasePart") then
            v.Velocity = Vector3.new(0, 0, 0)
            v.RotVelocity = Vector3.new(0, 0, 0)
        end
    end
end

insertCommand("skill", function(getPlayer)
    if game.PlaceId == 1662219031 then
        local name = tostring(getPlayer):lower()
        for i, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

        if not plr.Character or not plr.Character.Humanoid or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character.Humanoid or getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if plr.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Stroller") then return end

        plr.Character.Humanoid:UnequipTools()
        local tool, parts, part = plr.Backpack["Stroller"] or plr.Character["Stroller"], {}
        for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then table.insert(parts, v) end end
        for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then part = v; break end end

        local function run()
            tool.Parent = plr.Character

            repeat
                if not getPlayer.Character or not getPlayer.Character.Humanoid or getPlayer.Character.Humanoid.Health <= 0 then
                    break
                else
                    plr.Character:SetPrimaryPartCFrame(part.CFrame * CFrame.new(-1, 1, 2))
                    for i, v in next, parts do firetouchinterest(getPlayer.Character.PrimaryPart, v, 0, task.wait(), firetouchinterest(getPlayer.Character.PrimaryPart, part, 0)) end
                end
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 25 then return end until getPlayer.Character.Humanoid.Health <= 0
        plr.Character.Humanoid:ChangeState(15)
    end
end)

insertCommand("as", function(getPlayer)
    if game.PlaceId == 1662219031 then
        local name = tostring(getPlayer):lower()
        for i, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

        if not plr.Character or not plr.Character.Humanoid or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character.Humanoid or getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if plr.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Stroller") then return end

        plr.Character.Humanoid:UnequipTools()
        local tool, parts = plr.Backpack["Stroller"] or plr.Character["Stroller"], {}
        for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then table.insert(parts, v) end end

        local function run()
            tool.Parent = plr.Character

            repeat
                if not getPlayer.Character or not getPlayer.Character.Humanoid or getPlayer.Character.Humanoid.Health <= 0 then
                    break
                else
                    for i, v in next, parts do firetouchinterest(getPlayer.Character.PrimaryPart, v, 0) end
                    task.wait()
                end
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 25 then return end until getPlayer.Character:FindFirstChild("Sitting")
        plr.Character.Humanoid:ChangeState(15)
    end
end)

insertCommand("skill2", function(getPlayer)
    if game.PlaceId == 1662219031 then
        local name = tostring(getPlayer):lower()
        for i, v in next, plrs:GetPlayers() do if v:IsA("Player") and v.Name:lower():sub(1, #name) == name or v.DisplayName:lower():sub(1, #name) == name then getPlayer = v end end

        if not plr.Character or not plr.Character.Humanoid or plr.Character.Humanoid.Health <= 0 or not getPlayer.Character or not getPlayer.Character.Humanoid or getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if plr.Character:FindFirstChild("Sitting") then return end

        plr.Character.Humanoid:UnequipTools()
        local tool, parts, part = plr.Backpack["Stroller"] or plr.Character["Stroller"], {}
        for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then table.insert(parts, v) end end
        for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then part = v; break end end

        local function run()
            tool.Parent = plr.Character
            tool.Parent = workspace

            repeat
                if not getPlayer.Character or not getPlayer.Character.Humanoid or getPlayer.Character.Humanoid.Health <= 0 then
                    break
                else
                    plr.Character:SetPrimaryPartCFrame(part.CFrame * CFrame.new(-1, 1, 2))
                    for i, v in next, parts do firetouchinterest(getPlayer.Character.PrimaryPart, v, 0, task.wait(), firetouchinterest(getPlayer.Character.PrimaryPart, part, 0)) end
                end
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run) end)

        local clock = os.time()
        repeat task.wait(); if (os.time() - clock) >= 25 then return end until getPlayer.Character.Humanoid.Health <= 0
        plr.Character.Humanoid:ChangeState(15)
    end
end)

--[[
insertCommand("svoid", function(getPlayer)
    if ((tonumber(game["PlaceId"])) == (1662219031)) then
        for _, v in next, (plrs:GetPlayers()) do
            if v:IsA("Player") then
                if ((tostring(v["Name"]):lower():sub(1, tonumber(string.len(tostring(getPlayer)))) == tostring(getPlayer):lower()) or (tostring(v["DisplayName"]):lower():sub(1, tonumber(string.len(tostring(getPlayer)))) == tostring(getPlayer):lower())) then
                    getPlayer = (v)
                end
            end
        end
    end
end)

insertCommand("sbring", function(getPlayer)
    if ((tonumber(game["PlaceId"])) == (1662219031)) then
        for _, v in next, (plrs:GetPlayers()) do
            if v:IsA("Player") then
                if ((tostring(v["Name"]):lower():sub(1, tonumber(string.len(tostring(getPlayer)))) == tostring(getPlayer):lower()) or (tostring(v["DisplayName"]):lower():sub(1, tonumber(string.len(tostring(getPlayer)))) == tostring(getPlayer):lower())) then
                    getPlayer = (v)
                end
            end
        end
    end
end)
]]
