require('common')
local cure = require('ma/cure')

local emergency_cure = {}

emergency_cure.init_config = function(config)
	config.emergency_cure = {
	}
end

emergency_cure.get_config = function(config)
	return config.emergency_cure
end

emergency_cure.command = function(config, args)
end

emergency_cure.tic = function(config)
	local lowestHpp = 100;
	local lowestHp = 0;
	local lowestName;
	local hpMissing = 0;
	local memoryManager = AshitaCore:GetMemoryManager();
	local party = memoryManager:GetParty();
	for i=0,5 do
		local name = party:GetMemberName(i)
		local hp = party:GetMemberHP(i)
		local hpp = party:GetMemberHPPercent(i)
		if (name ~= "") then
			if (hpp < lowestHpp and hpp > 0) then
				lowestHpp = hpp;
				lowsetHp = hp;
				lowestName = name;
				--local playerEntity = GetEntity(AshitaCore:GetDataManager():GetParty():GetMemberTargetIndex(i))
				hpMissing = (hp/(hpp / 100))-hp;
				--print(name .. " " .. hpp .. " " .. hp .. " " .. hpMissing)
			end
		end
	end	
	
	if lowestHpp < 10 then
		cure.run_cure(100, 250, 400, 800, 1000, 1300, {})
	end
	
	return 10;
end

emergency_cure.render = function(config)
end

return emergency_cure