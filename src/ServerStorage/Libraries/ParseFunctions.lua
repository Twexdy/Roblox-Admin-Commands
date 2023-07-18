local classes = require(game:GetService("ServerStorage").Libraries.Classes)

local module = {}

--[[
Argument parsing function - manyPlayers

Description:
This function takes an argument string provided by the player and returns a Result object containing a table of player instances based on the argument. The function can identify specific players based on the argument, such as "me", "all", "others", or a player's username.

Parameters:
    argumentGiven: (string) The argument provided by the player, which specifies the target players. It can be "me", "all", "others", or a player's username.
    player: (Player) The player instance of the player executing the command. This is used for the "me" identifier.

Possible Identifiers:

    "me": The player executing the command.
    "all": All players currently in the server.
    "others": All players currently in the server except the player executing the command.
    Player Username: A specific player based on their username.

Note: The function is case-insensitive when comparing the argument with the identifiers.
]]--
function module.manyPlayers(argumentGiven:string, player:Player): classes.Result<{Player} | string>
	if not argumentGiven then
		return classes.newResult(false, "Provide a player.")
	end	

	local argumentPlayer = game:GetService("Players"):FindFirstChild(argumentGiven)
	local playerList = game:GetService("Players"):GetChildren()
	local argumentLowercase = string.lower(argumentGiven)

	if argumentLowercase == "me" then
		return classes.newResult(true, {player})

	elseif argumentLowercase == "all" then
		return classes.newResult(true, playerList)

	elseif argumentLowercase == "others" then
		local playerBuffer = {}
		for _, plr in pairs(playerList) do
			if plr == plr then
				continue
			end
			table.insert(playerBuffer, plr)
		end
		return classes.newResult(true, playerBuffer)
	else
		if not argumentPlayer then
			return classes.newResult(false, `Player '{argumentGiven}' not found.`)
		end
		return classes.newResult(true, {argumentPlayer})

	end
end

function module.string(argumentGiven:string): classes.Result<{Player} | string>
	return classes.newResult(true, argumentGiven)
end

--[[
These arguments types are not done yet! :(

function module.number(argumentGiven:string): classes.Result<number | string>
	return classes.Result.new(true, argumentGiven)
end

function module.integer(argumentGiven:string): classes.Result<number | string>
	return classes.Result.new(true, argumentGiven)
end

function module.boolean(): classes.Result<boolean | string>
	return classes.Result.new(true, argumentGiven)
end
]]--

return module