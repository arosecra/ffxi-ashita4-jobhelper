require('common')

local pld_enmity = {}

pld_enmity.init_config = function(config)
	config.pld_enmity = {
	}
end

pld_enmity.get_config = function(config)
	return config.pld_enmity
end

pld_enmity.command = function(config, args)
end

pld_enmity.tic = function(config)
	
	
	return 10;
end

pld_enmity.render = function(config)
end

return pld_enmity