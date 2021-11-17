require('common')

local ws = {}

ws.init_config = function(config)
	config.ws = {
	}
end

ws.get_config = function(config)
	return config.ws
end

ws.command = function(config, args)
	if (args[3] == 'set') then
		config.ws.name = args[4]
    elseif (args[3] == 'check') then
        print(config.ws.name)
	else
        if config.ws ~= nil then
            AshitaCore:GetChatManager():QueueCommand(1, '/ws ' .. config.ws.name);
        end
	end
end

ws.render = function(config)
end

ws.tic = function(config)
	return 10
end

return ws