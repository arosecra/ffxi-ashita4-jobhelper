local cor = {}


cor.init_config = function(config)
	config.cor = {
		rolls = {}
	}
end

cor.command = function(config, args)
	if (args[3] == 'setroll') then
        local index = args[4];
        local roll = args[5];
        config.cor.rolls[index] = roll;
	elseif (args[3] == 'roll') then
        if config.cor.rolls[args[4]] ~= nil then
		    AshitaCore:GetChatManager():QueueCommand("/ja \"" .. config.cor.rolls[args[4]] .. "\" <me>", 1)
        end
	end
end

cor.render = function(config)
end

return cor