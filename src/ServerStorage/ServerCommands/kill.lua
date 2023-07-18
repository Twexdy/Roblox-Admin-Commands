-- argumentsGiven[1] = manyPlayers

return function(argumentsGiven)
	local players = argumentsGiven[1]
	for _, v in pairs(players) do
		v.Character:WaitForChild("Humanoid").Health = 0
	end
end

