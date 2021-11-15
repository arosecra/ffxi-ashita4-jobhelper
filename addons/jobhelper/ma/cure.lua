require('common')

local cure = {}

cure.init_config = function(config)
	config.cure = {
	}
end

cure.command = function(config, args)
	if (args[3] == 'cure') then
		cure.run_cure(100, 250, 400, 800, 1000, 1300, args)
	elseif (args[3] == 'curega') then
		cure.run_curega(100, 250, 500, 600, args)
	elseif (args[3] == 'cura') then
		cure.run_cure(config, args[3])
	end
end

cure.render = function(config)

end
cure.run_cure = function(cure1, cure2, cure3, cure4, cure5, cure6, args)
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
				print(name .. " " .. hpp .. " " .. hp .. " " .. hpMissing)
			end
		end
	end
	
	if lowestHpp < 100 then
		--start_action()
		local command = ""
		if hpMissing > cure6 then
			command = "/ma \"Cure VI\" " .. lowestName
		elseif hpMissing > cure5 then
			command = "/ma \"Cure V\" " .. lowestName
		elseif hpMissing > cure4 then
			command = "/ma \"Cure IV\" " .. lowestName
		elseif hpMissing > cure3 then
			command = "/ma \"Cure III\" " .. lowestName
		elseif hpMissing > cure2 then
			command = "/ma \"Cure II\" " .. lowestName
		elseif hpMissing > cure1 then
			command = "/ma \"Cure\" " .. lowestName
		end
		
		AshitaCore:GetChatManager():QueueCommand(1, command);
	end

end

cure.run_curega = function(cure1, cure2, cure3, cure4, args)
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
				print(name .. " " .. hpp .. " " .. hp .. " " .. hpMissing)
			end
		end
	end
	
	if lowestHpp < 100 then
		--start_action()
		local command = ""
		if hpMissing > cure4 then
			command = "/ma \"Curaga IV\" " .. lowestName
		elseif hpMissing > cure3 then
			command = "/ma \"Curaga III\" " .. lowestName
		elseif hpMissing > cure2 then
			command = "/ma \"Curaga II\" " .. lowestName
		elseif hpMissing > cure1 then
			command = "/ma \"Curaga\" " .. lowestName
		end
		
		AshitaCore:GetChatManager():QueueCommand(1, command);
	end

end



return cure