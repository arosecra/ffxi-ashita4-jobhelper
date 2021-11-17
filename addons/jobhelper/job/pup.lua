local jobs = require('org_github_arosecra/jobs');
local pup = {}
pup.maneuver_elements = {
	[300]='Fire', 
	[301]='Ice', 
	[302]='Wind', 
	[303]='Earth', 
	[304]='Thunder', 
	[305]='Water', 
	[306]='Light', 
	[307]='Dark'
}

pup.init_config = function(config)
	config.pup = {
		maneuvers = {}
	}
end

pup.get_config = function(config)
	return config.pup;
end

pup.command = function(config, args)
	if (args[3] == 'setmaneuver') then
        local index = args[4];
        local maneuver = args[5];
        config.pup.maneuvers[index] = maneuver;
	end
end

pup.render = function(config)
end

pup.tic = function(config)
	local player = AshitaCore:GetMemoryManager():GetPlayer();
    local playerEntity = GetPlayerEntity();
    if (player == nil or playerEntity == nil) then
        return 1;
    end
	
    local pet = GetEntity(playerEntity.PetTargetIndex);
    if (pet == nil) then
        return 1;
    end

	local mainjob = jobs[player:GetMainJob()]

	if mainjob == 'Puppetmaster' then
		pup.run_maneuver(config)
	end
	return 12;
end


pup.maneuver = function(config, maneuver_count, maneuver)
	local result = false
	if(maneuver ~= nil) then
		if(maneuver_count[maneuver] > 0) then
			maneuver_count[maneuver] = maneuver_count[maneuver] -1
		else
			config.pup.appliedmaneuvers = true
			AshitaCore:GetChatManager():QueueCommand(1, "/ja \"" .. maneuver .. " Maneuver\" <me>")
			result = true;
		end
	else
        print('Attempting to use a nil maneuver');
	end
	return result
end

pup.count_current_maneuvers = function()
	local maneuver_count = {
		['Fire']=0, 
		['Ice']=0, 
		['Wind']=0, 
		['Earth']=0, 
		['Thunder']=0, 
		['Water']=0, 
		['Light']=0, 
		['Dark']=0
	}
	local status_list = AshitaCore:GetMemoryManager():GetPlayer():GetStatusIcons();
	for slot = 0, 31, 1 do
		--print(status_list[slot])
		if status_list[slot] ~= nil and 
           status_list[slot] >= 300 and 
           status_list[slot] <=307 then
			local element = pup.maneuver_elements[status_list[slot]]
			maneuver_count[element] = maneuver_count[element] + 1
		end
	end
	return maneuver_count
end

pup.run_maneuver = function(config)
	local maneuver_count = pup.count_current_maneuvers()
	
	if pup.maneuver(config, maneuver_count, config.pup.maneuvers['1']) then
		return true;
	end
	if pup.maneuver(config, maneuver_count, config.pup.maneuvers['2']) then
		return true;
	end
	if pup.maneuver(config, maneuver_count, config.pup.maneuvers['3']) then
		return true;
	end
end


return pup