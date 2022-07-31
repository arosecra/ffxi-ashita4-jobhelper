local jobs = require('org_github_arosecra/jobs');
local pld = {}


pld.add_ability = function(config, ability)
	config.pld.numberofabilities = config.pld.numberofabilities + 1
	config.pld.abilities[config.pld.numberofabilities] = ability
end

pld.init_config = function(config)
	config.pld = {
		abilities = {
		}
	}
	
	pld.add_ability(config, {id=547, ability=false, command="/ma Cocoon <me>" , time=2, status= 93, mp=10})
	pld.add_ability(config, {id=106, ability=false, command="/ma Phalanx <me>" , time=5, status=116, mp=21})
	--pld:add_ability(config, {id= 97, ability=false, command="/ma Reprisal <me>", time=2, status=nil, mp=24})
	pld.add_ability(config, {id=73,  ability=true , command="/ja Shield Bash '<t>'", time=2, status=255, mp=0})
	pld.add_ability(config, {id=75,  ability=true , command="/ja Sentinel <me>"  , time=2, status=62, mp=0})
	pld.add_ability(config, {id=77,  ability=true , command="/ja Rampart <me>"   , time=2, status=255, mp=0})
	pld.add_ability(config, {id=112, ability=false, command="/ma Flash <t>"          , time=1, status=255, mp=25})
	pld.add_ability(config, {id=575, ability=false, command="/ma Jettatura <t>"      , time=1, status=255, mp=37})
	pld.add_ability(config, {id=592, ability=false, command="/ma \"Blank Gaze\" <t>" , time=5, status=255, mp=25})

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