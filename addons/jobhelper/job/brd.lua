local brd = {}

brd.init_config = function(config)
	config.brd = {
		songs = {}
	}
end

brd.command = function(config, args)
	if (args[3] == 'setsong') then
        local index = args[4];
        local songname= args[5];
        config.brd.songs[index] = songname;
	elseif (args[3] == 'singsong') then
        local song = nil;

		if config.brd.songs[args[4]] == 'Carol 1' and config.brd.carolelement ~= nil then
			song = config.brd.carolelement .. " Carol";
		elseif config.brd.songs[args[4]] == 'Carol 2' and config.brd.carolelement ~= nil then
			song = config.brd.carolelement .. " Carol II";
		elseif config.brd.songs[args[4]] ~= nil then
			song = config.brd.songs[args[4]];
		end

        if song ~= nil then
            AshitaCore:GetChatManager():QueueCommand(1, "/ma \"" .. song .. "\" <me>")
        end
	elseif (args[3] == 'setcarolelement') then
		config.brd.carolelement = args[4]
	elseif (args[3] == 'setthrenodyelement') then
		config.brd.threnodyelement = args[4]
	elseif (args[3] == 'threnody1' and config.brd.threnodyelement ~= nil) then
        if config.brd.threnodyelement ~= nil then
		    AshitaCore:GetChatManager():QueueCommand(1, "/ma \"" .. config.brd.threnodyelement .. " Threnody\" <t>");
        end
	elseif (args[3] == 'threnody2' and config.brd.threnodyelement ~= nil) then
        if config.brd.threnodyelement ~= nil then
		    AshitaCore:GetChatManager():QueueCommand(1, "/ma \"" .. config.brd.threnodyelement .. " Threnody II\" <t>");
        end
	end
end

brd.render = function(config)
end

return brd