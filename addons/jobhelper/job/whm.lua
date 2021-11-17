local whm = {}

whm.init_config = function(config)
	config.whm = {
		barelement = "Barfira",
		boost = "Boost-STR",
		barstatus = "Baramnesra"
	}
end

whm.get_config = function(config)
	return config.whm;
end

whm.command = function(config, args)
	if (args[3] == 'setbarelement') then
		config.whm.barelement = args[4]
	elseif (args[3] == 'setbarstatus') then
		config.whm.barstatus = args[4]
	elseif (args[3] == 'setboost') then
		config.whm.boost = args[4]
	elseif (args[3] == 'barelement') then
        AshitaCore:GetChatManager():QueueCommand(1, "/ma " .. config.whm.barelement .. " <me>");
	elseif (args[3] == 'barstatus' and config.whm.barstatus ~= nil) then
        AshitaCore:GetChatManager():QueueCommand(1, "/ma " .. config.whm.barstatus .. " <me>");
	elseif (args[3] == 'boost' and config.whm.boost ~= nil) then
        AshitaCore:GetChatManager():QueueCommand(1, "/ma " .. config.whm.boost .. " <me>");
	end
end

whm.render = function(config)
end

whm.tic = function(config)
end

return whm