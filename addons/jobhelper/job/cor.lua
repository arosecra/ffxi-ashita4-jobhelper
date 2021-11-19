local cor = {}
local rolls = require('org_github_arosecra/statuses/corsair')


cor.init_config = function(config)
	config.cor = {
		rolls = {
			[1] = 'Companion\'s Roll',
			[2] = 'Drachen Roll'
		},
		current_roll = {
			roll = '',
			rolling = false,
			value = 0,
			state = 0
		}
	}
end

cor.get_config = function(config)
	return config.cor
end

cor.command = function(config, args)
	if (args[3] == 'setroll') then
        local index = tonumber(args[4]);
        local roll = args[4]:gsub("\"", "")
        config.cor.rolls[index] = roll;
	elseif (args[3] == 'roll') then
		local index = tonumber(args[4])
		print(config.cor.rolls[index])
        if config.cor.rolls[index] ~= nil then
		    AshitaCore:GetChatManager():QueueCommand(1, "/ja \"" .. config.cor.rolls[index] .. "\" <me>")
        end
	elseif args[3] == 'print' then
		print(config.cor.current_roll.value)
		
	end
end

cor.process_text = function(config, args)
	-- x uses Fighter's Roll. The total comes to 3!
	-- The total for Fighter's Roll comes to 5!
	local message1 = ' uses ' .. config.cor.current_roll.roll .. '. The total comes to ';
	local message2 = 'The total for ' .. config.cor.current_roll.roll .. ' increases to ';
	if config.cor.current_roll.rolling then
		local roll_message = false
		if string.find(args.message, message1) then
			roll_message = true
		elseif string.find(args.message, message2) then
			roll_message = true
		end
		
		if roll_message then
			local excl = string.sub(args.message, 1, string.find(args.message, '!') -1)
			local values = string.split(excl)
			local value = values[#values]
			config.cor.current_roll.value = value
			
			local roll_id = rolls.status_effects.by_name[config.cor.current_roll.roll]
			local lucky = rolls.status_effects.by_id[roll_id].lucky
			
			if lucky == value then
				config.cor.current_roll.state = 5
			elseif tonumber(value) > 6 then
				config.cor.current_roll.state = 5
			else
				config.cor.current_roll.state = 3
			end
		end
	end
	
end

cor.render = function(config)
end

cor.roll_not_applied = function(roll)
	local applied = false
	local status_list = AshitaCore:GetMemoryManager():GetPlayer():GetStatusIcons();
	print('checking for buffid ' .. rolls.status_effects.by_name[roll])
	for slot = 1, 32, 1 do
		--print(status_list[slot])
		if status_list[slot] ~= nil then
			local buffid = status_list[slot]
			if buffid == rolls.status_effects.by_name[roll] then
				applied = true
			end
		end
	end
	return not applied
end

cor.tic = function(config)
	local delay = 1
	--overall process is, per roll:
	--  check if the roll needs to be applied
	--  do the roll
	--  check the result of the roll
	--    if the roll was a lucky roll, stop
	--    if the roll was less than 6 and double up is available, continue
	--    if the roll is greater than 6 stop
	
	
	-- state 0 = not rolled
	-- state 1 = rolled, waiting for message
	-- state 2 = message received
	-- state 3 = apply double up
	-- state 4 = double up applied, waiting for message
	-- state 5 = done, clearing back to 0
	if config.cor.current_roll.state == 0 then
		local roll = ''
		local roll_required = false
		
		if cor.roll_not_applied(config.cor.rolls[1]) then 
			roll = config.cor.rolls[1]
			roll_required = true
		elseif cor.roll_not_applied(config.cor.rolls[2]) then
			roll = config.cor.rolls[2]
			roll_required = true
		end
		
		if roll_required then
			config.cor.current_roll.state = 1
			config.cor.current_roll.roll = roll
			config.cor.current_roll.rolling = true
			AshitaCore:GetChatManager():QueueCommand(1, "/ja \"" .. roll .. "\" <me>")
			delay = 5
		else
			print('not rolling')
			delay = 120
		end
	elseif config.cor.current_roll.state == 3 then
		AshitaCore:GetChatManager():QueueCommand(1, "/ja 'Double-Up' <me>")
		config.cor.current_roll.state = 4
		delay = 5
	elseif config.cor.current_roll.state == 5 then
		config.cor.current_roll = {
			roll = '',
			rolling = false,
			value = 0,
			state = 0
		}
		delay = 60
	end
	return delay
end

return cor