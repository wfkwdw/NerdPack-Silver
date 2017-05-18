local _, Silver = ...

---------------------------------------
--------------- General ---------------
---------------------------------------
NeP.DSL:Register('sated', function()
    if NeP.DSL:Get('debuff')('player', 'Sated') or NeP.DSL:Get('debuff')('player', 'Exhaustion') or NeP.DSL:Get('debuff')('player', 'Fatigued') or NeP.DSL:Get('debuff')('player', 'Insanity') or NeP.DSL:Get('debuff')('player', 'Fatigued') or NeP.DSL:Get('debuff')('player', 'Temporal Displacement') then
        return true
    else
        return false
    end
end)

NeP.DSL:Register('xequipped', function(item)
    if IsEquippedItem(item) then
        return 1
    else
        return 0
    end
end)

NeP.DSL:Register('talent.enabled', function(_, x,y)
    if NeP.DSL:Get('talent')(_, x,y) then
        return 1
    else
        return 0
    end
end)

NeP.DSL:Register('deficit', function()
    local max = UnitPowerMax('player')
    local curr = UnitPower('player')
	--print(max - curr)
    return (max - curr)
end)

NeP.DSL:Register('gcd.remains', function()
    return NeP.DSL:Get('spell.cooldown')('player', '61304')
end)

NeP.DSL:Register('gcd.max', function()
    return NeP.DSL:Get('gcd')()
end)

---------------------------------------
---------------- Rogue ----------------
---------------------------------------

NeP.DSL:Register('rtb', function()
	local jollyRoger = UnitBuff('player', 'Jolly Roger')
	local grandMelee = UnitBuff('player', 'Grand Melee')
	local sharkinfestedWaters = UnitBuff('player', 'Shark Infested Waters')
	local trueBearing = UnitBuff('player', 'True Bearing')
	local burriedTreasure = UnitBuff('player', 'Buried Treasure')
	local broadsides = UnitBuff('player', 'Broadsides')
	local buffCount = 0
	
	if jollyRoger then
		buffCount = buffCount + 1
		--print('Have Jolly Roger')
			else
		buffCount = buffCount
	end
	if grandMelee then
		buffCount = buffCount + 1
		--print('Have Jolly Roger')
			else
		buffCount = buffCount
	end
	if sharkinfestedWaters then
		buffCount = buffCount + 1
		--print('Have Jolly Roger')
			else
		buffCount = buffCount
	end
	if trueBearing then
		buffCount = buffCount + 2
		--print('Have Jolly Roger')
			else
		buffCount = buffCount
	end
	if burriedTreasure then
		buffCount = buffCount + 1
		--print('Have Jolly Roger')
			else
		buffCount = buffCount
	end
	if broadsides then
		buffCount = buffCount + 1
		--print('Have Jolly Roger')
			else
		buffCount = buffCount
	end
	--print(buffCount)
	return buffCount
end)

NeP.DSL:Register('poisoned_bleeds', function()
	local rupture = UnitDebuff('target', 'Rupture')
	local garrote = UnitDebuff('target', 'Garrote')
	local mutilatedFlesh = UnitDebuff('target', 'Mutilated Flesh')
	local int = 0
	
	if rupture then
		int = int + 1
	end
	if garrote then
		int = int + 1
	end
	if mutilatedFlesh then
		int = int + 1
	end
	return int
end)

NeP.DSL:Register('sb.up', function()
    local shadowBlades = UnitBuff('player', 'Shadow Blades')
	if shadowBlades then
		return 1
	end
    return 0
end)

NeP.DSL:Register('prem.up', function()
	if NeP.DSL:Get('talent.enabled')(nil, '6,1') then
		return 1
	end
    return 0
end)

NeP.DSL:Register('vw.up', function()
	if NeP.DSL:Get('talent.enabled')(nil, '7,1') then
		return 1
	end
    return 0
end)

NeP.DSL:Register('energy.regen', function()
    local eregen = select(2, GetPowerRegen('player'))
    return eregen
end)

NeP.DSL:Register('energy.time_to_max', function()
    local deficit = NeP.DSL:Get('deficit')()
    local eregen = NeP.DSL:Get('energy.regen')()
    return deficit / eregen
end)

NeP.DSL:Register('combopoints.deficit', function(target)
    return (UnitPowerMax('player', SPELL_POWER_COMBO_POINTS)) - (UnitPower('player', SPELL_POWER_COMBO_POINTS))
end)

NeP.DSL:Register('variable.ssw_er', function()
    --actions=variable,name=ssw_er,value=equipped.shadow_satyrs_walk*(10+floor(target.distance*0.5))
    local range_check
    if NeP.DSL:Get('range')('target') then
        range_check = NeP.DSL:Get('range')('target')
    else
        range_check = 0
    end
    local x = (NeP.DSL:Get('xequipped')('137032') * (10 + (range_check * 0.5)))
	--print(variable.ssw_er)
    return x
end)

NeP.DSL:Register('variable.ed_threshold', function()
    --actions+=/variable,name=ed_threshold,value=energy.deficit<=(20+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+variable.ssw_er)
    local x = (NeP.DSL:Get('deficit')() <= ((20 + NeP.DSL:Get('talent.enabled')(nil, '3,3')) * (35 + NeP.DSL:Get('talent.enabled')(nil, '7,1')) * (25 + NeP.DSL:Get('variable.ssw_er')())))
    return x
end)

NeP.DSL:Register('variable.stealth_threshold', function()
	--actions.precombat+=/variable,name=stealth_threshold,value=(15+talent.vigor.enabled*35+talent.master_of_shadows.enabled*25+variable.ssw_refund)
	local x = ((15 + NeP.DSL:Get('talent.enabled')(nil, '3,3')) * (35 + NeP.DSL:Get('talent.enabled')(nil, '7,1')) * (25 + NeP.DSL:Get('variable.ssw_er')()))
	--print(x)
    return x
end)

NeP.DSL:Register('variable.energy_regen_combined', function()
	--actions=variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*(7+talent.venom_rush.enabled*3)%2 
    local x = (NeP.DSL:Get('energy.regen')() + NeP.DSL:Get('poisoned_bleeds')() * (7 + NeP.DSL:Get('vw.up')() * 3) / 2 )
	--print(x)
    return x
end)

NeP.DSL:Register('variable.energy_time_to_max_combined', function()
	--actions+=/variable,name=energy_time_to_max_combined,value=energy.deficit%variable.energy_regen_combined
    local x = NeP.DSL:Get('deficit')() / NeP.DSL:Get('variable.energy_regen_combined')()
	--print(x)
    return x
end)

NeP.DSL:Register('rogue.t19', function()
	local int = 0
	if IsEquippedItem('138326') then -- Chest
		int = int + 1
	end
	if IsEquippedItem('138329') then  -- Gloves
		int = int + 1
	end
	if IsEquippedItem('138332') then  -- Head
		int = int + 1
	end
	if IsEquippedItem('138335') then  -- Pants
		int = int + 1
	end
	if IsEquippedItem('138338') then  -- Shoulders
		int = int + 1
	end
	if IsEquippedItem('138371') then  -- Cloak
		int = int + 1
	end
	return int
end)

NeP.DSL:Register('stealthed', function()
    if NeP.DSL:Get('buff')('player', 'Shadow Dance') or NeP.DSL:Get('buff')('player', 'Stealth') or NeP.DSL:Get('buff')('player', 'Subterfuge') or NeP.DSL:Get('buff')('player', 'Shadowmeld') or NeP.DSL:Get('buff')('player', 'Prowl') then
        return true
    else
        return false
    end
end)