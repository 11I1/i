local ChatEvents = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
local SayMessageRequest = ChatEvents:WaitForChild("SayMessageRequest")

-- Whispering a private message
local targetUsername = "5qea" -- Replace with the username of the recipient
local message = "This is a private message!"

-- Format the whisper message
local whisperMessage = string.format("%s", message)

-- Attempt to send the message using the "Whisper" channel
SayMessageRequest:FireServer(whisperMessage, "Whisper", targetUsername)
