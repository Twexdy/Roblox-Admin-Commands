-- argumentsGiven["Player/s"] = manyPlayers, argumentsGiven["Message"] = string (optional)

return function(argumentsGiven)
	local players = argumentsGiven["Player/s"]
	for _, v in pairs(players) do
		v:Kick(argumentsGiven["Message"])
	end
end

