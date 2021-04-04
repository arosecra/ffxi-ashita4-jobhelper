require('common')

local ws = {}

ws.init_config = function(config)
end

ws.command = function(config, args)
	if (args[3] == 'set') then
		config.ws = args[4]
    elseif (args[3] == 'check') then
        print(config.ws)
	else
        if config.ws ~= nil then
            AshitaCore:GetChatManager():QueueCommand(1, '/ws ' .. config.ws);
        end
	end
end

ws.render = function(config)
end

return ws