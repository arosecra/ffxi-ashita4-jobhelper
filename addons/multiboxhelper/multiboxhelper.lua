
addon.name      = 'multiboxhelper';
addon.author    = 'arosecra';
addon.version   = '1.0';
addon.desc      = 'TBD';
addon.link      = '';


ashita.events.register('load', 'multiboxhelper_load_cb', function ()
    print("[multiboxhelper] 'load' event was called.");
end);

ashita.events.register('command', 'multiboxhelper_command_cb', function (e)
    if (not e.command:startswith('/multiboxhelper') and not e.command:startswith('/mbh')) then
		return;
    end
    print("[multiboxhelper] Blocking '/mbh' command!");
    e.blocked = true;
end);

ashita.events.register('packet_in', 'packetpump_inc_action_0x28_packet_in_callback1', function (e)
    if (e.id == 0x76) then
	
	elseif (e.id == 0x0D) then
	
	elseif (e.id == 0x28) then
		local action = parser.parse_action(e.data);
		
    end
end);

ashita.events.register('d3d_present', 'multiboxhelper_present_cb', function ()

end);