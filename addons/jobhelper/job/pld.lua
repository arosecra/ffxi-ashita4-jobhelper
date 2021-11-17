local jobs = require('org_github_arosecra/jobs');
local pld = {}

pld.init_config = function(config)
	config.pld = {
		auto = {
		}
	}
end

pld.get_config = function(config)
	return config.pld;
end

pld.command = function(config, args)
end

pld.render = function(config)

end

pld.tick = function(config)
end

return pld