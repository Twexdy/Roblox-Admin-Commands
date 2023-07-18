local libraries = game:GetService("ServerStorage").Libraries
local replicatedStorage = game:GetService("ReplicatedStorage")
local serverStorage = game:GetService("ServerStorage")

local commandUtils = require(libraries.CommandUtils)
local parseFunctions = require(libraries.ParseFunctions)
local commandConfigs = require(replicatedStorage.CommandConfigs)
local configs = require(serverStorage.ServerConfigs)



game.Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		
		-- Check if the message is a command and strip the prefix if it is.
		local messageWithoutPrefix = commandUtils.removeCommandPrefix(message, configs.prefixes)
		if not messageWithoutPrefix.didSucceed then return end

		-- Split the message into individual arguments for more convenient parsing
		local tokens = commandUtils.biasedSplit(messageWithoutPrefix.resultValue, configs.argumentSeparator, configs.stringEncloser)
		if not tokens.didSucceed then print(tokens.resultValue) return end

		-- Check if the command exists and fetch it from commandConfigs
		local command = commandUtils.findCommand(tokens.resultValue[1], commandConfigs)
		if not command.didSucceed then print(command.resultValue) return end

		-- Turn the command's arguments into objects that our script can actually use, for example, turn a player's name into a Player instance
		local parsedArguments = commandUtils.parseCommandArguments(command.resultValue, tokens.resultValue, player, parseFunctions)
		if not parsedArguments.didSucceed then print(parsedArguments.resultValue) return end

		-- Run the command's function that's linked in commandConfigs
		local executeResult = commandUtils.executeCommand(command.resultValue, parsedArguments.resultValue, player)
		print(executeResult.resultValue)
		
		-- scuffed D:
		-- Might turn this into a for loop later

	end)
end)