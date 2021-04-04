local geo = {}

geo.spelltargets = {
	["Geo-Regen"] = "<me>",
	["Geo-Refresh"] = "<me>",
	["Geo-Haste"] = "<me>",
	["Geo-Str"] = "<me>",
	["Geo-Dex"] = "<me>",
	["Geo-Vit"] = "<me>",
	["Geo-Agi"] = "<me>",
	["Geo-Int"] = "<me>",
	["Geo-Mnd"] = "<me>",
	["Geo-Chr"] = "<me>",
	["Geo-Fury"] = "<me>",
	["Geo-Barrier"] = "<me>",
	["Geo-Acumen"] = "<me>",
	["Geo-Fend"] = "<me>",
	["Geo-Precision"] = "<me>",
	["Geo-Voidance"] = "<me>",
	["Geo-Focus"] = "<me>",
	["Geo-Attunement"] = "<me>",
	["Geo-Wilt"] = "<t>",
	["Geo-Frailty"] = "<t>",
	["Geo-Fade"] = "<t>",
	["Geo-Malaise"] = "<t>",
	["Geo-Slip"] = "<t>",
	["Geo-Torpor"] = "<t>",
	["Geo-Vex"] = "<t>",
	["Geo-Languor"] = "<t>"
}

geo.init_config = function(config)
	config.geo = {}
end

geo.command = function(config, args)
	if (args[3] == 'setbubble') then
		config.geo['bubble'] = args[4]
	elseif (args[3] == 'setluopan') then
		config.geo['luopan'] = args[4]
	elseif (args[3] == 'bubble' and config.geo['bubble'] ~= nil) then
        if config.geo['bubble'] ~= nil then
		    AshitaCore:GetChatManager():QueueCommand(1, "/ma \"" .. config.geo['bubble'] .. "\" <me>")
        end
	elseif (args[3] == 'luopan' and config.geo['luopan'] ~= nil) then
        if config.geo['luopan'] ~= nil and 
           config.geo['luopan'] ~= nil and 
           geo.spelltargets[config.geo['luopan']] ~= nil then
		    AshitaCore:GetChatManager():QueueCommand(1, "/ma \"" .. config.geo['luopan'] .. "\" " .. geo.spelltargets[config.geo['luopan']])
        end
	end
end

return geo;