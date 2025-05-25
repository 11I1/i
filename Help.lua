local Players = game:GetService("Players")

local characterData = {}

local function setupCharacter(player, character)
	local connections = {}

	local valuesFolder = character:WaitForChild("Values", 5)
	if not valuesFolder then return end

	local dribblingValue = valuesFolder:FindFirstChild("Dribbling")
	if not dribblingValue or not dribblingValue:IsA("BoolValue") then return end

	local forceField = Instance.new("ForceField")
	forceField.Name = "AutoDribbleForcefield"

	local function onDribblingChanged()
		if dribblingValue.Value then
			forceField.Parent = nil
		else
			forceField.Parent = character

			task.delay(3, function()
				if character and forceField and forceField.Parent == character and not dribblingValue.Value then
					forceField.Parent = nil
				end
			end)
		end
	end

	local signal = dribblingValue:GetPropertyChangedSignal("Value"):Connect(onDribblingChanged)
	table.insert(connections, signal)

	onDribblingChanged()

	characterData[character] = {
		Connections = connections,
		ForceField = forceField,
	}
end

local function cleanupCharacter(character)
	local data = characterData[character]
	if data then
		for _, conn in ipairs(data.Connections or {}) do
			if typeof(conn) == "RBXScriptConnection" then
				conn:Disconnect()
			end
		end

		if data.ForceField and data.ForceField:IsA("ForceField") then
			data.ForceField:Destroy()
		end

		characterData[character] = nil
	end
end

local function handlePlayer(player)
	local function onCharacterAdded(character)
		cleanupCharacter(character)
		setupCharacter(player, character)
	end

	player.CharacterAdded:Connect(onCharacterAdded)

	if player.Character then
		onCharacterAdded(player.Character)
	end

	player.AncestryChanged:Connect(function(_, parent)
		if not parent and player.Character then
			cleanupCharacter(player.Character)
		end
	end)
end

Players.PlayerAdded:Connect(handlePlayer)

for _, player in ipairs(Players:GetPlayers()) do
	handlePlayer(player)
end

local rep = game:GetService("ReplicatedStorage")
local football, Module = rep.Football, require(rep.Controllers.BallController)
Players.LocalPlayer:GetMouse().KeyDown:Connect(function(Key)
    if Key == 'r' then
        local chr = Players.LocalPlayer.Character
        chr:SetPrimaryPartCFrame(CFrame.lookAt(chr.PrimaryPart.Position, football.Value.Char.Value:GetModelCFrame().Position))
        Module:Slide()
        chr = nil
    end
end)

rep = nil
