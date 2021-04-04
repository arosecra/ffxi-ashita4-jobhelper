require 'common'
local sch = {}

sch.skillchains = {
["liq_f"]   = { DisplayName = "Liquefaction",  MB = "Fire",           Spells = { [1] = "Stone",       Wait = 3,  [2] = "Fire"}},
["sci_s"]   = { DisplayName = "Scission",      MB = "Stone",          Spells = { [1] = "Fire",        Wait = 3,  [2] = "Stone"}},
["rev_w"]   = { DisplayName = "Reverberation", MB = "Water",          Spells = { [1] = "Stone",       Wait = 3,  [2] = "Water"}},
["det_a"]   = { DisplayName = "Detonation",    MB = "Aero",           Spells = { [1] = "Stone",       Wait = 3,  [2] = "Aero"}},
["ind_b"]   = { DisplayName = "Induration",    MB = "Blizzard",       Spells = { [1] = "Water",       Wait = 3,  [2] = "Blizzard"}},
["imp_t"]   = { DisplayName = "Impaction",     MB = "Thunder",        Spells = { [1] = "Blizzard",    Wait = 3,  [2] = "Thunder"}},
["trns_l"]  = { DisplayName = "Transfixion",   MB = "Light",          Spells = { [1] = "Noctohelix",  Wait = 5,  [2] = "Luminohelix"}},
["com_d"]   = { DisplayName = "Compression",   MB = "Dark",           Spells = { [1] = "Blizzard",    Wait = 3,  [2] = "Noctohelix"}},
["frag_at"] = { DisplayName = "Fragmentation", MB = "Aero/Thunder",   Spells = { [1] = "Blizzard",    Wait = 3,  [2] = "Water"}},
["fus_fl"]  = { DisplayName = "Fusion",        MB = "Fire/Light",     Spells = { [1] = "Fire",        Wait = 3,  [2] = "Thunder"}},
["grav_ds"] = { DisplayName = "Gravitation",   MB = "Earth/Dark",     Spells = { [1] = "Aero",        Wait = 3,  [2] = "Noctohelix"}},
["dist_wb"] = { DisplayName = "Distortion",    MB = "Water/Blizzard", Spells = { [1] = "Luminohelix", Wait = 5,  [2] = "Stone"}}
}

sch.init_config = function(config)
	config.sch = {
        slfsc = 'liq_f'
    }
end

sch.command = function(config, args)
	if (args[3] == 'setslfsc') then
		config.sch['slfsc'] = args[4]
	elseif (args[3] == 'slfsc') then
        sch.slfsc(config);
	end
end

sch.slfsc = function(config)
    local skillchain_info = sch.skillchains[config.sch.slfsc]
    coroutine.sleep(1)
    sch.slfsc_step1(skillchain_info);
    coroutine.sleep(2)
    sch.slfsc_step2(skillchain_info);
    coroutine.sleep(2)
    sch.slfsc_step3(skillchain_info);
    coroutine.sleep(skillchain_info.Spells.Wait)
    sch.slfsc_step4(skillchain_info);
    coroutine.sleep(1)
    sch.slfsc_step5(skillchain_info);
    coroutine.sleep(2)
    sch.slfsc_step6(skillchain_info);
    coroutine.sleep(2)
end

sch.slfsc_step1 = function(skillchain_info) 
	AshitaCore:GetChatManager():QueueCommand(1, "/p (Starting Gear) (Skillchain) (" .. skillchain_info.DisplayName .. ") MB: (" .. skillchain_info.MB .. ")", 1)
end

sch.slfsc_step2 = function(skillchain_info) 
	AshitaCore:GetChatManager():QueueCommand(1, "/ja Immanence <me>")
end

sch.slfsc_step3 = function(skillchain_info) 
	AshitaCore:GetChatManager():QueueCommand(1, "/ma " .. skillchain_info.Spells[1] .. " <t>")
end

sch.slfsc_step4 = function(skillchain_info) 
	AshitaCore:GetChatManager():QueueCommand(1, "/p (Closed Position) (Skillchain in 3)", 1)
end

sch.slfsc_step5 = function(skillchain_info) 
	AshitaCore:GetChatManager():QueueCommand(1, "/ja Immanence <me>")
end

sch.slfsc_step6 = function(skillchain_info) 
	AshitaCore:GetChatManager():QueueCommand(1, "/ma " .. skillchain_info.Spells[2] .. " <t>")
end



return sch