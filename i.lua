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
    if ((tonumber(game["PlaceId"])) == (1662219031)) then
        for _, v in next, (plrs:GetPlayers()) do
            if v:IsA("Player") then
                if ((tostring(v["Name"]):lower():sub(1, tonumber(string.len(tostring(getPlayer)))) == tostring(getPlayer):lower()) or (tostring(v["DisplayName"]):lower():sub(1, tonumber(string.len(tostring(getPlayer)))) == tostring(getPlayer):lower())) then
                    getPlayer = (v)
                end
            end
        end

        if not plr.Character and not plr.Character.Humanoid and plr.Character.Humanoid.Health <= 0 and not getPlayer.Character and not getPlayer.Character.Humanoid and getPlayer.Character.Humanoid.Health <= 0 then
            return
        end

        if plr.Character:FindFirstChild("Sitting") or getPlayer.Character:FindFirstChild("Sitting") then return end

        plr.Character.Humanoid:UnequipTools()
        local tool, parts, part = plr.Backpack["Stroller"] or plr.Character["Stroller"], {}
        for i, v in next, tool:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then table.insert(parts, v) end end
        for i, v in next, workspace["Police Station"]:GetChildren() do if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") then part = v; break end end

        local function run()
            repeat
                if not getPlayer.Character and not getPlayer.Character.Humanoid and getPlayer.Character.Humanoid.Health <= 0 then
                    break
                else
                    plr.Character:SetPrimaryPartCFrame(part.CFrame * CFrame.new(0, 0, 2))
                    plr.Character.Humanoid:EquipTool(tool)
                    for i, v in next, parts do firetouchinterest(getPlayer.Character.PrimaryPart, v, 0, task.wait(), firetouchinterest(getPlayer.Character.PrimaryPart, part, 0)) end
                end
            until plr.Character.Humanoid.Health <= 0
        end task.spawn(function() pcall(run) end)

        repeat task.wait() until getPlayer.Character.Humanoid.Health <= 0

        wait(); plr.Character.Humanoid:ChangeState(15)
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
