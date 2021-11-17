local cor = {}


cor.init_config = function(config)
	config.cor = {
		rolls = {}
	}
end

cor.get_config = function(config)
	return config.cor
end

cor.command = function(config, args)
	if (args[3] == 'setroll') then
        local index = args[4];
        local roll = args[5];
        config.cor.rolls[index] = roll;
	elseif (args[3] == 'roll') then
		print(config.cor.rolls[args[4]])
        if config.cor.rolls[args[4]] ~= nil then
		    AshitaCore:GetChatManager():QueueCommand(1, "/ja " .. config.cor.rolls[args[4]] .. " <me>")
        end
	end
end

cor.render = function(config)
end

cor.tic = function(config)
end

return cor