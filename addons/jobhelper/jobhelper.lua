
addon.name      = 'jobhelper';
addon.author    = 'arosecra';
addon.version   = '1.0';
addon.desc      = 'TBD';
addon.link      = '';

require('common')
local status_effect_packet = require('org_github_arosecra/packets/status_effect')

local modules = T{}

local prefixes = T{
    --abilities
    ['ws'] = require('ability/ws'),
	--auto
	['emergency_cure'] = require('auto/emergency_cure'),
	['maneuver'] = require('auto/maneuver'),
	['pld_enmity'] = require('auto/pld_enmity'),
    --magic
	['cure'] = require('ma/cure'),
	['cleanse'] = require('ma/cleanse'),
    ['nuke'] = require('ma/nuke'),
    --job
    ['brd'] = require('job/brd'),
    ['cor'] = require('job/cor'),
    ['geo'] = require('job/geo'),
    ['pld'] = require('job/pld'),
    ['pup'] = require('job/pup'),
    ['sam'] = require('job/sam'),
    ['sch'] = require('job/sch'),
    ['whm'] = require('job/whm')
}

local runtime_config = {};

ashita.events.register('load', 'jobhelper_load_cb', function ()

	runtime_config.next_tic_time = 0
				
    prefixes:each(function(value)
        modules:append(value);
    end);

    modules:each(function(module)
        if module.init_config ~= nil then
            module.init_config(runtime_config);
			local config = module.get_config(runtime_config);
			if config ~= nil then
				config.next_exec_time = 0
				config.engaged = "false"
			end
        end
    end);
end);

ashita.events.register('command', 'jobhelper_command_cb', function (e)
    if (not e.command:startswith('/jobhelper') and not e.command:startswith('/jh')) then
		return;
    end
    e.blocked = true;

    local args = e.command:argsquoted();
    local module = prefixes[args[2]];
    if args[2] == 'printzone' then
		local party     = AshitaCore:GetMemoryManager():GetParty();
		local zone = AshitaCore:GetResourceManager():GetString('zones', party:GetMemberZone(0))
		print(zone)
	elseif module == nil then
        print('Module ' .. args[2] .. ' not found')
    else
		if #args > 2 and args[3] == 'setengaged' then
			module.get_config(runtime_config).engaged = args[4]
		else
			module.command(runtime_config, args);
		end
    end 

end);

ashita.events.register('packet_in', 'jobhelper_in_callback1', function (e)
    if (e.id == 0x76) then
		runtime_config.party_status_effects = status_effect_packet.parse(e.data)
		--print('parsed 0x76')
	elseif (e.id == 0x0D) then
	
	elseif (e.id == 0x28) then
		
    end
end);

ashita.events.register('d3d_present', 'jobhelper_present_cb', function ()

    local playerEntity = GetPlayerEntity();
    if (playerEntity == nil) then
        return 1;
    end
	
	local party     = AshitaCore:GetMemoryManager():GetParty();
	local zone = AshitaCore:GetResourceManager():GetString('zones', party:GetMemberZone(0))
		
	if zone == 'Eastern Adoulin' or
	   zone == 'Western Adoulin' or
	   zone == 'Southern San d\'Oria' or
	   zone == 'Northern San d\'Oria' or
	   zone == 'Port San d\Oria' or
	   zone == 'Chateau d\'Oraguille' or
	   zone == 'Bastok Mines' or
	   zone == 'Bastok Markets' or
	   zone == 'Port Bastok' or
	   zone == 'Metalworks' or
	   zone == 'Windurst Waters' or 
	   zone == 'Windurst Walls' or
	   zone == 'Port Windurst' or
	   zone == 'Windurst Woods' or
	   zone == 'Heavens Tower' or
	   zone == 'Port Jeuno' or
	   zone == 'Lower Jeuno' or
	   zone == 'Upper Jeuno' or
	   zone == 'Ru\'Lude Gardens' or
	   zone == 'Tavnazian Safehold' or
	   zone == 'Aht Urhgan Whitegate' or
	   zone == 'Al Zahbi' or 
	   zone == 'Selbina' or
	   zone == 'Mhaura' or
	   zone == 'Norg' or
	   zone == 'Rabao' or
	   zone == 'Nashmau' then
	   return;
	end
	

    modules:each(function(module)
        if module.render ~= nil then
            module.render(runtime_config);
        end
		
		local module_config = module.get_config(runtime_config);
		if module_config.engaged ~= nil and 
		   module_config.engaged == "true" then
			if runtime_config.next_tic_time < os.time() then
				if module_config.next_exec_time ~= nil and 
				   module_config.next_exec_time < os.time() and 
				   module.tic ~= nil then
					local delay = module.tic(runtime_config)
					module_config.next_exec_time = os.time() + delay
				end				
				
				runtime_config.next_tic_time = os.time() + 1
			end		
		end
    end);
end);