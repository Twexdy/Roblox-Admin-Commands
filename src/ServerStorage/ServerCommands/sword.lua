-- argumentsGiven[1] = manyPlayers

return function(argumentsGiven)
	for _, plr in pairs(argumentsGiven[1]) do
		local sword = game:GetService("InsertService"):LoadAsset("125013769")
		if not sword:IsA("Tool") then
			sword = sword:FindFirstChildWhichIsA("Tool")
		end

		if not sword then
			error("Sword tool not found.", 0)
		end
		sword.Parent = plr.Backpack
	end
end
