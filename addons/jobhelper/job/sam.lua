local jobs = require('org_github_arosecra/jobs');
local sam = {}

sam.init_config = function(config)
	config.sam = {
		engaged = 'false'
	}
end

sam.get_config = function(config)
	return config.sam
end

sam.command = function(config, args)
	if (args[3] == 'engage') then
        config.sam.engaged = true

		local status_list = AshitaCore:GetMemoryManager():GetPlayer():GetStatusIcons();
	
		for slot = 0, 31, 1 do
			--print(status_list[slot])
			if status_list[slot] ~= nil and status_list[slot] ~= 255 then
				print(status_list[slot]);
			end
		end
	end
end



sam.render = function(config)
	local player = AshitaCore:GetMemoryManager():GetPlayer();
    local playerEntity = GetPlayerEntity();
    if (player == nil or playerEntity == nil) then
        return;
    end

	local mainjob = jobs[player:GetMainJob()]

	if mainjob == 'Samurai' then
		-- do sam stuff here
		if config.sam.engaged == "true" then
			--check if hasso is up
			-- if not, put it up
		end
	end
end

sam.tic = function(config)

end

return sam