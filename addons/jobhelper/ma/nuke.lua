require('common')

local nuke = {}
nuke.spell_metadata = {
	["stormI"] = { Index = 1, Target = "<me>" },
	["stormII"]= { Index= 2, Target = "<me>" },
	["helixI"]= { Index= 3, Target = "<t>" },
	["helixII"]= { Index= 4, Target = "<t>" },
	["nukeI"]= { Index= 5, Target = "<t>" },
	["nukeII"]= { Index= 6, Target = "<t>" },
	["nukeIII"]= { Index= 7, Target = "<t>" },
	["nukeIV"]= { Index= 8, Target = "<t>" },
	["nukeV"]= { Index= 9, Target = "<t>" }
};

nuke.spells = {
	["fire"]= {
		"Firestorm", "Firestorm II",
		"Pyrohelix", "Pyrohelix II",
		"Fire", "Fire II", "Fire III", "Fire IV", "Fire V"
	},
	["stone"]= {
		"Sandstorm", "Sandstorm II",
		"Geohelix", "Geohelix II",
		"Stone", "Stone II", "Stone III", "Stone IV", "Stone V"
	},
	["water"]= {
		"Rainstorm", "Rainstorm II",
		"Hydrohelix", "Hydrohelix II",
		"Water", "Water II", "Water III", "Water IV", "Water V"
	},
	["wind"]= {
		"Windstorm", "Windstorm II",
		"Anemohelix", "Anemohelix II",
		"Aero", "Aero II", "Aero III", "Aero IV", "Aero V"
	},
	["ice"]= {
		"Hailstorm", "Hailstorm II",
		"Cryohelix", "Cryohelix II",
		"Blizzard", "Blizzard II", "Blizzard III", "Blizzard IV", "Blizzard V"
	},
	["thunder"]= {
		"Thunderstorm", "Thunderstorm II",
		"Ionohelix", "Ionohelix II",
		"Thunder", "Thunder II", "Thunder III", "Thunder IV", "Thunder V"
	},
	["light"]= {
		"Aurorastorm", "Aurorastorm II",
		"Luminohelix", "Luminohelix II"
	},
	["dark"]= {
		"Voidstorm", "Voidstorm II",
		"Noctohelix", "Noctohelix II"
	}
};

nuke.init_config = function(config)
	config.nuke = {
		element = "fire"
	}
end

nuke.get_config = function(config)
	return config.nuke;
end

nuke.command = function(config, args)
	if (args[3] == 'setelement') then
		config.nuke.element = args[4]
	else
		nuke.run_nuke(config, args[3])
	end
end

nuke.render = function(config)

end

nuke.tic = function(config)

end

nuke.run_nuke = function(config, spellType, target)
    print(spellType)
	if nuke.spell_metadata[spellType] ~= nil then
		local spellIndex = nuke.spell_metadata[spellType].Index
		local spell = nuke.spells[config.nuke.element][spellIndex]
		local spellTarget = nuke.spell_metadata[spellType].Target
		local command = "/ma \"" .. spell .. "\" " .. spellTarget 
		--print(command)
		AshitaCore:GetChatManager():QueueCommand(1, command);
	end
end



return nuke