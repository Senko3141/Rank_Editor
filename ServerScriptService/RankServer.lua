-- Rank Server

local Storage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Remotes = Storage:WaitForChild("Remotes")
local Event = Remotes.rankupdater

local Tags = {
	--[[
	["plrInst"] = {
		Equipped = "Name",
		["Inventory"] = {
			"Destroyer",
			"Thing",
		};
	}	
	]]--
};

Players.PlayerAdded:Connect(function(plr)
	Tags[plr] = {
		Equipped = "Test",
		Inventory = {
			["Muffin"] = true,
			["Master"] = true,
			["Lord Fart"] = true,
			["Test"] = true,
		};
	};
	
	plr.CharacterAdded:Connect(function(char)
		if Tags[plr] then
			local clone = script.Over:Clone()
			clone.PlayerName.Text = plr.Name
			clone.Rank.Text = Tags[plr].Equipped
			
			clone.Parent = char:WaitForChild("Head")
		end
		
	end)
end)

Players.PlayerRemoving:Connect(function(plr)
	-- clearing
	if Tags[plr] then
		Tags[plr] = nil
	end
end)

game:BindToClose(function()
	-- clearing
	for _,v in next, Players:GetPlayers() do
		if Tags[v] then
			Tags[v] = nil
		end
	end
end)

Event.OnServerInvoke = function(plr, data)
	if not data or not data.Action then return end
	
	local action = data.Action
	if action == "getTags" then
		if not data.Player then
			return "None"
		end
		if plr.Character.Humanoid.Health == 0 then
			return "You're dead; you can't equip anything."
		end
		if Tags[data.Player] then
			return Tags[data.Player]
		else
			return "None"
		end
	end
	
	if action == "Set" then
		if not data.Player then
			return "No player argument."
		end
		if not data.Name then
			return "No name argument."
		end
		
		if plr.Character.Humanoid.Health == 0 then
			return "You're dead; you can't equip anything."
		end
		
		if Tags[data.Player] then
			
			local Inventory = Tags[data.Player].Inventory
			local Equipped = Tags[data.Player]
			
			if Inventory[data.Name] then
				Equipped.Equipped = data.Name
				
				plr.Character.Head:FindFirstChild("Over").Rank.Text = Equipped.Equipped
				
				return "Success"
			else
				return "Could not find".. data.Name.. " in Inventory."
			end
		end
		
	end
end
