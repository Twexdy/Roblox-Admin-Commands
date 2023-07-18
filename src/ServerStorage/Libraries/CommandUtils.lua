local ServerStorage = game:GetService("ServerStorage")
local classes = require(ServerStorage.Libraries.Classes)
local module = {}

function module.removeCommandPrefix(message:string, validPrefixes:{string}): classes.Result<string>
    for _, prefix in pairs(validPrefixes) do
		
        if message:sub(1, #prefix) ~= prefix then
			continue
		end
		local messageWithoutPrefix = message:sub(#prefix + 1)
		if messageWithoutPrefix == '' then
			return classes.newResult(false, "Empty command.")
		end
        return classes.newResult(true, messageWithoutPrefix)
    end
	return classes.newResult(false, "Message is not command.")
end

--[[
* biasedSplit - Parses a string to extract tokens, using a separator and an encloser.

baseStr (string) - The input string to be parsed.
separatorChar (string) - The character used as the primary separator to split tokens. Must be only a single character!
enclosingChar (string) - The character used as the enclosing separator. Must be only a single character!

return (array) - An array of strings containing the extracted tokens in order.

This function is useful for parsing single arguments that may have spaces in them, like a text message.
It allows you to extract tokens based on the primary separator while ignoring separators within the encloser.

Example:
baseStr = 'this is a "command with arguments"'
separatorChar = ' '
enclosingChar = '"'

tokens = biasedSplit(baseStr, separatorChar, enclosingChar)
tokens' value is { "this", "is", "a", "command with arguments" }
]]--
function module.biasedSplit(baseStr:string, separatorChar:string, enclosingChar:string): classes.Result<{string} | string>
	local tokenTable = {}
	local currentToken = ""
	local inEncloser = false

	-- Check if the arguments are valid strings
	for _, parameter in ipairs({baseStr, separatorChar, enclosingChar}) do
		if typeof(parameter) ~= "string" then return classes.newResult(false, "Invalid inputs for the biased split.") end
	end

	for i = 1, #baseStr do
		local char = baseStr:sub(i, i)
		if char == enclosingChar then
			inEncloser = not inEncloser
		elseif char == separatorChar and not inEncloser then
			table.insert(tokenTable, currentToken)
			currentToken = ""
		else
			currentToken = currentToken..char
		end
	end

	table.insert(tokenTable, currentToken)
	return classes.newResult(true, tokenTable)
end

function module.findCommand(commandName:string, commandList:{any}): classes.Result<{any} | string>
	for _, command in pairs(commandList) do
		for _, alias in pairs(command.aliases) do
			if alias ~= commandName then
				continue
			end
			return classes.newResult(true, command)
		end
	end
	return classes.newResult(false, `Command '{commandName}' not found.`)
end

function module.parseCommandArguments(command:{any}, tokens:{string}, player:Player, parseFunctions:{any}): classes.Result<{any} | string>
	local arguments = table.move(tokens, 2, #tokens, 1, {})
	local parsedArguments = {}
	for argCount, argType in ipairs(command.arguments) do
		local parseFunction = parseFunctions[argType]
		local parseResult = parseFunction(arguments[argCount], player)
		if not parseResult.didSucceed then
			return parseResult -- return error result
		end
		table.insert(parsedArguments, parseResult.resultValue)
	end
	return classes.newResult(true, parsedArguments)
end

function module.executeCommand(command:{any}, parsedArguments:{string}, player:Player): classes.Result<string>
	local didSucceed = true
	local message = ""

	xpcall(
	function()
		command.commandFunction(parsedArguments, player)
		message = `{player.Name} ran the command {command.aliases[1]}`
	end,

	function(err) -- error function
		didSucceed = false
		message = tostring(err)
	end)

	return classes.newResult(didSucceed, message) 
end

return module