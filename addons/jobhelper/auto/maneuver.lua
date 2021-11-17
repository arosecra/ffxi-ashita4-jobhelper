require('common')

local maneuver = {}

maneuver.init_config = function(config)
	config.maneuver = {
	}
end

maneuver.get_config = function(config)
	return config.maneuver
end

maneuver.command = function(config, args)
end

maneuver.tic = function(config)
	
	
	return 10;
end

maneuver.render = function(config)
end

return maneuver