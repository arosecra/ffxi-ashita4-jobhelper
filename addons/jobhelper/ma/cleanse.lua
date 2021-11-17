require('common')

local cleanse = {}
cleanse.statuses = {
	[1]  = { name="doom",         spell="Cursna"   , priority=1 },
	[2]  = { name="curse",        spell="Cursna"   , priority=2 },
	[3]  = { name="petrifaction", spell="Sonta"    , priority=3 },
	[4]  = { name="paralysis",    spell="Paralyna" , priority=4 },
	[5]  = { name="plague",       spell="Viruna"   , priority=5 },
	[6]  = { name="silence",      spell="Silena"   , priority=6 },
	[7]  = { name="blindness",    spell="Blindna"  , priority=7 },
	[8]  = { name="poison",       spell="Poisona"  , priority=8 },
	[9]  = { name="diseased",     spell="Viruna"   , priority=9 },
	[10] = { name="sleep",        spell="Cure"     , priority=10},
	[11] = { name="bio",          spell="Erase"    , priority=11},
	[12] = { name="dia",          spell="Erase"    , priority=12},
	[13] = { name="gravity",      spell="Erase"    , priority=13},
	[14] = { name="flash",        spell="Erase"    , priority=14},
	[15] = { name="addle",        spell="Erase"    , priority=15},
	[16] = { name="slow",         spell="Erase"    , priority=16},
	[17] = { name="elegy",        spell="Erase"    , priority=17},
	[18] = { name="requiem",      spell="Erase"    , priority=18},
	[19] = { name="shock",        spell="Erase"    , priority=19},
	[20] = { name="rasp",         spell="Erase"    , priority=20},
	[21] = { name="choke",        spell="Erase"    , priority=21},
	[22] = { name="frost",        spell="Erase"    , priority=22},
	[23] = { name="burn",         spell="Erase"    , priority=23},
	[24] = { name="drown",        spell="Erase"    , priority=24},
	[25] = { name="pyrohelix",    spell="Erase"    , priority=25},
	[26] = { name="cryohelix",    spell="Erase"    , priority=26},
	[27] = { name="anemohelix",   spell="Erase"    , priority=27},
	[28] = { name="geohelix",     spell="Erase"    , priority=28},
	[29] = { name="ionohelix",    spell="Erase"    , priority=29},
	[30] = { name="hydrohelix",   spell="Erase"    , priority=30},
	[31] = { name="luminohelix",  spell="Erase"    , priority=31},
	[32] = { name="noctohelix",   spell="Erase"    , priority=32}
}


cleanse.init_config = function(config)
	config.cleanse = {
	}
end

cleanse.get_config = function(config)
	return config.cleanse;
end

cleanse.command = function(config, args)
	cleanse.run_cleanse(config)
end

cleanse.render = function(config)

end

cleanse.tic = function(config)

end

cleanse.run_cleanse = function(config, spellType, target)
	for istatus,status in ipairs(whm.statuses) do
		
		for i=0,4 do
			if config.party_status_effects[i] ~= nil then
			
				for j=0,31 do
					if config.party_status_effects[i].Statuses[j] ~= nil and config.party_status_effects[i].Statuses[j].StatusName == status.name then
						--start_action()
						AshitaCore:GetChatManager():QueueCommand(1, "/ma \"" .. status.spell .. "\" " .. config.party_status_effects[i].Name);
						break;
					end
				end
			end
		end
	
	end
end



return cleanse