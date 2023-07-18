-- argumentsGiven[1] = manyPlayers

return function(argumentsGiven)
	local players = argumentsGiven[1]
	for _, v in pairs(players) do
		v.Character:WaitForChild("Humanoid").MaxHealth = math.huge
		v.Character:WaitForChild("Humanoid").Health = math.huge
	end
end
