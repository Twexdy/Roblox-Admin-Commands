-- argumentsGiven["Player/s"] = manyPlayers, argumentsGiven["Tool ID"] = string

return function(argumentsGiven)
	for _, player in pairs(argumentsGiven["Player/s"]) do
		local tool
		local success, errorMessage = pcall(function()
			tool = game:GetService("InsertService"):LoadAsset(argumentsGiven["Tool ID"])
		end)
		if not success then
			error(`Failed to load tool. {errorMessage}.`, 0)
		end

		if not tool:IsA("Tool") then
			tool = tool:FindFirstChildWhichIsA("Tool")
		end
		tool.Parent = player.Backpack
	end
end

