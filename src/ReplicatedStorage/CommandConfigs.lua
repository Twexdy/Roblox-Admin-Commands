--[[

* This module contains a collection of server commands that can be executed by players in the game.
* Commands are tables with specific properties that affect how the admin framework treats the command.

* These are the following properties every command should have:
   - aliases: An array of strings representing alternative names for the command. Players can use the prefix followed immediately by any of these names to execute the command.
   - arguments: An array of strings representing the expected types of arguments for the command.
   - info: A description of what the command does.
   - commandFunction: The function that contains the implementation of the command.

* Arguments are given to the commandFunction in the order they're listed in the arguments parameter. Currently, valid data types for commands are the following
   - manyPlayers: This type represents one or more players currently in the server. Players can use identifiers like "all", "others", "me", or individual player names to specify the target players for the command.
   - string: This type represents plain text.

* These data types are planned to be added in the future
   - integer: A number without any decimal points.
   - number: AKA a float, a number with decimal points.
   - boolean: A true or false value.

* Command emplate
	command_name = {
		aliases = {"command", "aliases"},
		arguments = {"arg1Type", "arg2Type", ...},
		info = "Description of the command.",
		commandFunction = require("path.to.command_script"),
	},

* Note: The commandFunction property in each command table points to a function. The paths may vary based on the structure of your project if you add your own commands.

--]]

local ServerCommands = game:GetService("ServerStorage").ServerCommands

local module = {
	gear = {
		aliases = {"gear", "tool"},
		arguments = {
			{type = "manyPlayers", name = "Player/s"},
			{type = "string", name = "Tool ID"} },
		info = "Equips players with a gear or tool specified by an assetID.",
		commandFunction = require(ServerCommands.gear),
	},
	
	kick = {
		aliases = {"kick"},
		arguments = {
			{type = "manyPlayers", name = "Player/s"},
			{type = "string", name = "Message", optional = true} },
		info = "Removes players from the server with an optional message.",
		commandFunction = require(ServerCommands.kick),
	},
	
	kill = {
		aliases = {"kill"},
		arguments = { 
			{type = "manyPlayers", name = "Player/s"} },
		info = "Kills players' characters.",
		commandFunction = require(ServerCommands.kill),
	},

}
return module
