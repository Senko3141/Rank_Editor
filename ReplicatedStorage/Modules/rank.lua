-- Rank Module

local Storage = game:GetService("ReplicatedStorage")

local Remotes = Storage:WaitForChild("Remotes")
local Event = Remotes.rankupdater

local module = {};

function module.getTags(plr)
	return Event:InvokeServer({Action = "getTags", Player = plr})
end

function module.setTag(plr, name)
	return Event:InvokeServer({
		Action = "Set", 
		Player = plr, 
		Name = name})
end

return module
