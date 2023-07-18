-- argumentsGiven[1] = manyPlayers, argumentsGiven[2] = string

return function(argumentsGiven)
	local players = argumentsGiven[1]
	for _, v in pairs(players) do
		v:Kick(argumentsGiven[2])
	end
end

