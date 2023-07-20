-- argumentsGiven["Player/s"] = manyPlayers

return function(argumentsGiven)
	local players = argumentsGiven["Player/s"]
	for _, v in pairs(players) do
		v.Character:WaitForChild("Humanoid").Health = 0
	end
end

