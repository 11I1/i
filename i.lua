local ChatService = game:GetService("ChatService")
local targetPlayer = game.Players:FindFirstChild("5qea") -- replace with the desired username

local message = ChatService.CreateChatMessage()
message.Message = "Hello, this is a private message!"
message.Channel = "Private"
message.Recipient = targetPlayer

ChatService:SendChatMessage(message)
