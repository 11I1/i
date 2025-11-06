getgenv().Signals = getgenv().Signals or {}
for i, v in getgenv().Signals do
    if typeof(v) ~= "RBXScriptConnection" then continue end
    v:Disconnect(); getgenv().Signals[i] = nil
    print(`￢ﾜﾅ Disconnected "{i}": <{typeof(v)}> | ￢ﾘﾑ￯ﾸﾏ Memory Cleared!`)
end

local AddSignal = loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/c.lua"))()

local Players, ReplicatedStorage, RunService, UserInputService = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("RunService"), game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid, PrimaryPart, Hitbox = Character.Humanoid, Character.PrimaryPart, Character.Hitbox

local FBParent = ReplicatedStorage.Football
local Football = FBParent.Value
local FBHitbox, Zero, Range, Diving, Dive, Effects, DC, SC, AC, KR, BC, HasBall = Football.Hitbox, Vector3.zero, Vector3.new(10, 10, 10), Character.Values.Diving, ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dive, {"Beam", "Highlight", "ParticleEmitter", "Trail", "BloomEffect", "BlurEffect", "ColorCorrectionEffect", "DepthOfFieldEffect", "RunRaysEffect"}, require(ReplicatedStorage.Controllers.GoalieController), require(ReplicatedStorage.Controllers.AbilityController.AbilitiesClient.Gagamaru.Scorpion), require(ReplicatedStorage.Controllers.AbilityController), Enum.KeyCode.R, require(ReplicatedStorage.Controllers.BallController), Character.Values.HasBall
local DF, Predict = DC.Dive, BC.Predict

AddSignal["NewCharacter"] = Player.CharacterAdded:Connect(function(Object)
    Character = Object; Humanoid, PrimaryPart, Hitbox, Diving, HasBall = Character:WaitForChild("Humanoid"), Character.PrimaryPart, Character:WaitForChild("Hitbox"), Character:WaitForChild("Values").Diving, Character:WaitForChild("Values").HasBall
    AddSignal["DiveHitbox"]:Disconnect(); rawset(AddSignal, "DiveHitbox", nil); print("￢ﾚﾠ￯ﾸﾏ Signal Disconnected: DiveHitbox | ￢ﾘﾑ￯ﾸﾏ Memory Cleared!")
    AddSignal["DiveHitbox"] = Character.ChildAdded:Connect(function(Object) if Object.Name ~= "DiveHitbox" then return end Object.Size = Range end)
    AddSignal["Diving"]:Disconnect(); rawset(AddSignal, "Diving", nil); print("￢ﾚﾠ￯ﾸﾏ Signal Disconnected: Diving | ￢ﾘﾑ￯ﾸﾏ Memory Cleared!")
    AddSignal["Diving"] = Diving:GetPropertyChangedSignal("Value"):Connect(function() Dive:FireServer() end)
    AddSignal["MHitbox"]:Disconnect(); rawset(AddSignal, "MHitbox", nil); print("Signal Disconnected: MHitbox | Memory Cleared!")
    AddSignal["MHitbox"] = Hitbox:GetPropertyChangedSignal("Size"):Connect(function() Hitbox.Size = Range end); Hitbox.Size = Range
    AddSignal["JH"]:Disconnect(); rawset(AddSignal, "JH", nil); print("Signal Disconnected: JH | Memory Cleared!")
    AddSignal["JH"] = Humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function() Dive:FireServer() end)
end)
AddSignal["NewFootball"] = FBParent:GetPropertyChangedSignal("Value"):Connect(function()
    Football = FBParent.Value; FBHitbox = Football:WaitForChild("Hitbox")
    AddSignal["Hitbox"]:Disconnect(); rawset(AddSignal, "Hitbox", nil); print("￢ﾚﾠ￯ﾸﾏ Signal Disconnected: Hitbox | ￢ﾘﾑ￯ﾸﾏ Memory Cleared!")
    AddSignal["Hitbox"] = FBHitbox:GetPropertyChangedSignal("Size"):Connect(function() FBHitbox.Size = Zero end); FBHitbox.Size = Zero
end)
AddSignal["Hitbox"] = FBHitbox:GetPropertyChangedSignal("Size"):Connect(function() FBHitbox.Size = Zero end); FBHitbox.Size = Zero
AddSignal["DiveHitbox"] = Character.ChildAdded:Connect(function(Object) if Object.Name ~= "DiveHitbox" then return end Object.Size = Range end)
AddSignal["Effects"] = game.DescendantAdded:Connect(function(Object) if not table.find(Effects, Object.ClassName) then return end Object:Destroy() end)
AddSignal["Diving"] = Diving:GetPropertyChangedSignal("Value"):Connect(function() Dive:FireServer() end)
AddSignal["FasterInput"] = UserInputService.InputBegan:Connect(function(i, p) if p then return end; if i.KeyCode == KR then SC(AC, nil, Character) end end)
AddSignal["MHitbox"] = Hitbox:GetPropertyChangedSignal("Size"):Connect(function() Hitbox.Size = Range end); Hitbox.Size = Range
AddSignal["JH"] = Humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function() Dive:FireServer() end)
AddSignal["Helper"] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	local t = input.UserInputType
	if t == Enum.UserInputType.Keyboard or t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.MouseButton2 then return end; t = nil
end)
AddSignal["Indicator"] = RunService.PreRender:Connect(function() Predict(BC, Football.AssemblyLinearVelocity, Football.Position) end)
AddSignal["Touch"] = RunService.PreRender:Connect(function() firetouchinterest(Hitbox, FBHitbox, 1, task.wait(), firetouchinterest(Hitbox, FBHitbox, 0)) end)

local Camera, Skip = workspace.Camera
for _, v in game:GetDescendants() do if not table.find(Effects, v.ClassName) or v:IsDescendantOf(Camera) then continue end v:Destroy() end; Camera = nil
for _, v in workspace.HalloweenLobby:GetChildren() do if v.Name ~= "Floor" then v:Destroy() end end
for _, v in workspace:GetDescendants() do
    if not v:IsA("BasePart") or v.Anchored or v == Football or v:IsDescendantOf(Football) then continue end; Skip = false
    for x, p in Players:GetPlayers() do
        if not p.Character then continue end
        if v:IsDescendantOf(p.Character) then Skip = true; break end
    end; if not Skip then v.Anchored = true end
end; Skip = nil
loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/d.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/11I1/i/refs/heads/main/%60"))()
