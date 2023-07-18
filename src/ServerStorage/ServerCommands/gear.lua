-- argumentsGiven[1] = manyPlayers, argumentsGiven[2] = string

return function(argumentsGiven)
	for _, plr in pairs(argumentsGiven[1]) do
		local tool = game:GetService("InsertService"):LoadAsset(argumentsGiven[2])
		if not tool:IsA("Tool") then
			tool = tool:FindFirstChildWhichIsA("Tool")
		end
		tool.Parent = plr.Backpack
	end
end

