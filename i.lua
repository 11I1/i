local ChatEvents = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents")
local SayMessageRequest = ChatEvents:WaitForChild("SayMessageRequest")

-- Format the message for whispering
local targetUsername = "5qea" -- Replace with the username of the recipient
local message = "Hello, this is a private message!"
local privateMessage = string.format("/w %s %s", targetUsername, message)

-- Fire the message to the chat system
SayMessageRequest:FireServer(privateMessage, "All")
