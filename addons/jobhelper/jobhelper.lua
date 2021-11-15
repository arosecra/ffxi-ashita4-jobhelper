
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
    --magic
	['cure'] = require('ma/cure'),
	['cleanse'] = require('ma/cleanse'),
    ['nuke'] = require('ma/nuke'),
    --job
    ['brd'] = require('job/brd'),
    ['cor'] = require('job/cor'),
    ['geo'] = require('job/geo'),
    ['pup'] = require('job/pup'),
    ['sam'] = require('job/sam'),
    ['sch'] = require('job/sch'),
    ['whm'] = require('job/whm')
}

local runtime_config = {};

ashita.events.register('load', 'jobhelper_load_cb', function ()

    prefixes:each(function(value)
        modules:append(value);
    end);


    modules:each(function(module)
        if module.init_config ~= nil then
            module.init_config(runtime_config);
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
    if module == nil then
        print('Module ' .. args[2] .. ' not found')
    else
        module.command(runtime_config, args);
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
    modules:each(function(module)
        if module.render ~= nil then
            module.render(runtime_config);
        end
    end);
end);