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

-- Need enemy last cast event

local castingEventSpellsAOE = { 
	-- Testing
	'Hearthstone',
---------------------------------------
--------- Tomb of Sargeras ------------
---------------------------------------
	-- Demonic Inquisition
	'Anguished Outburst',
	
	-- Harjatan
	'Unchecked Rage',
	
	-- The Desolate Host
	'Sundering Doom',
	
	-- Maiden of Vigilance
	'Hammer of Creation', 
	'Hammer of Obliteration',
	
	-- Fallen Avatar 
	'Sear',
	
	-- Kil'jaeden
	'Hopelessness',
}

NeP.DSL:Register('castingeventAOE', function()
    for i=1, #castingEventSpellsAOE do
        if NeP.DSL:Get("casting")("target", castingEventSpellsAOE[i]) then return true end
    end
end)

---------------------------------------
---------------- Raid -----------------
---------------------------------------

-- partycheck= 1 (SOLO), partycheck= 2 (PARTY), partycheck= 3 (RAID)
NeP.DSL:Register('partycheck', function()
        if IsInRaid() then
            return 3
        elseif IsInGroup() then
            return 2
        else
            return 1
        end
end)

---------------------------------------
---------------- Druid ----------------
---------------------------------------

NeP.DSL:Register('hots', function()
	local rejuv = NeP.DSL:Get('buff')('lowest','Rejuvenation')
	local germ = UnitBuff('target', 'Rejuvenation (Germination)')
	local springBlossems = UnitBuff('target', 'Spring Blossems')
	local regrowth = UnitBuff('target', 'Regrowth')
	local wildGrowth = UnitBuff('target', 'Wild Growth')
	local lifebloom = NeP.DSL:Get('buff')('lowest','Lifebloom')
	local hotCount = 0
	if rejuv then
		hotCount = hotCount + 1
			else
		hotCount = hotCount
	end
	if germ then
		hotCount = hotCount + 1
			else
		hotCount = hotCount
	end
	if springBlossems then
		hotCount = hotCount + 1
			else
		hotCount = hotCount
	end
	if regrowth then
		hotCount = hotCount + 1
			else
		hotCount = hotCount
	end
	if wildGrowth then
		hotCount = hotCount + 1
			else
		hotCount = hotCount
	end
	if lifebloom then
		hotCount = hotCount + 1
			else
		hotCount = hotCount
	end
	return hotCount
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

---------------------------------------
------------ Demon Hunter -------------
---------------------------------------

NeP.DSL:Register('variable.waiting_for_nemesis', function()
	--actions+=/variable,name=waiting_for_nemesis,value=!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60)
	if NeP.DSL:Get('talent.enabled')(nil, '5,3') then
		if NeP.DSL:Get('spell.cooldown')(nil, 'Nemesis') == 0 then
			return false
		end
		if NeP.DSL:Get('spell.cooldown')(nil, 'Nemesis') > NeP.DSL:Get('deathin')() then
			return false
		end	
		if NeP.DSL:Get('spell.cooldown')(nil, 'Nemesis') > 60 then
			return false
		end
		return true
	end
	return false
end)

NeP.DSL:Register('variable.waiting_for_chaos_blades', function()
	--actions+=/variable,name=waiting_for_chaos_blades,value=!(!talent.chaos_blades.enabled|cooldown.chaos_blades.ready|cooldown.chaos_blades.remains>target.time_to_die|cooldown.chaos_blades.remains>60)
	if NeP.DSL:Get('talent.enabled')(nil, '5,3') then
		if NeP.DSL:Get('spell.cooldown')(nil, 'Chaos Blades') == 0 then
			return false
		end
		if NeP.DSL:Get('spell.cooldown')(nil, 'Chaos Blades') > NeP.DSL:Get('deathin')() then
			return false
		end	
		if NeP.DSL:Get('spell.cooldown')(nil, 'Chaos Blades') > 60 then
			return false
		end
		return true
	end
	return false
end)

--actions+=/variable,name=pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10)&(!variable.waiting_for_chaos_blades|cooldown.chaos_blades.remains<6)
NeP.DSL:Register('variable.pooling_for_meta', function()
	if not NeP.DSL:Get('talent.enabled')(nil, '7,3') and NeP.DSL:Get('spell.cooldown')(nil, 'Metamorphosis') < 6 and NeP.DSL:Get('deficit')() > 30 and ( NeP.DSL:Get('variable.waiting_for_nemesis')() == false or NeP.DSL:Get('spell.cooldown')(nil, 'Nemesis') < 10) and ( NeP.DSL:Get('variable.waiting_for_chaos_blades')() == false or NeP.DSL:Get('spell.cooldown')(nil, 'Nemesis') < 6) then
		return true
	end	
	return false
end)

--actions+=/variable,name=blade_dance,value=talent.first_blood.enabled|set_bonus.tier20_2pc|spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*2)
--actions+=/variable,name=pooling_for_blade_dance,value=variable.blade_dance&fury-40<35-talent.first_blood.enabled*20&(spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*2))


NeP.DSL:Register('variable.pooling_for_chaos_strike', function()
--actions+=/variable,name=pooling_for_chaos_strike,value=talent.chaos_cleave.enabled&fury.deficit>40&!raid_event.adds.up&raid_event.adds.in<2*gcd
	if NeP.DSL:Get('talent.enabled')(nil, '3,1') and NeP.DSL:Get('deficit')() > 40 then
		return true
	end
	return false
end)

---------------------------------------
-------------- Warrior ----------------
---------------------------------------

NeP.DSL:Register('ignorepain', function ()
    local name,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,value = UnitBuff("player", "Ignore Pain")
    if name then
		print(value)
        return value
    end
	return 0
end)

---------------------------------------
-------------- Warlock ----------------
---------------------------------------

NeP.DSL:Register('unstableaffliction', function ()
    local count = 0
    
    for i = 1, 40, 1 do
        
        if (UnitAura("target", i, "PLAYER|HARMFUL") == "Unstable Affliction") then
            count = count + 1
        end
        
    end
	
	print('Unstable Afflictions: '..count)
	return count
end)

---------------------------------------
-------------- Hunter -----------------
---------------------------------------
NeP.DSL:Register('aimedshotwindow', function ()
	if NeP.DSL:Get('debuff.duration')('target', 'Vulnerable') > NeP.DSL:Get('spell.casttime')('player', 'Aimed Shot') then
		print('True Mother Fucker')
		return true
		else return false
	end
end)

--actions+=/variable,name=pooling_for_piercing,value=talent.piercing_shot.enabled&cooldown.piercing_shot.remains<5&lowest_vuln_within.5>0&lowest_vuln_within.5>cooldown.piercing_shot.remains&(buff.trueshot.down|spell_targets=1)
--waiting_for_sentinel,value=talent.sentinel.enabled&(buff.marking_targets.up|buff.trueshot.up)&!cooldown.sentinel.up&((cooldown.sentinel.remains>54&cooldown.sentinel.remains<(54+gcd.max))|(cooldown.sentinel.remains>48&cooldown.sentinel.remains<(48+gcd.max))|(cooldown.sentinel.remains>42&cooldown.sentinel.remains<(42+gcd.max)))

--actions.patient_sniper=variable,name=vuln_window,op=setif,value=cooldown.sidewinders.full_recharge_time,value_else=debuff.vulnerability.remains,condition=talent.sidewinders.enabled&cooldown.sidewinders.full_recharge_time<variable.vuln_window
--# Determine the number of Aimed Shot casts that are possible according to available focus and remaining Vulnerable duration.
--actions.patient_sniper+=/variable,name=vuln_aim_casts,op=set,value=floor(variable.vuln_window%action.aimed_shot.execute_time)
NeP.DSL:Register('vuln_aim-casts', function ()
	
end)
--actions.patient_sniper+=/variable,name=vuln_aim_casts,op1=set,value=floor((focus+action.aimed_shot.cast_regen*(variable.vuln_aim_casts-1))%action.aimed_shot.cost),if=variable.vuln_aim_casts>0&variable.vuln_aim_casts>floor((focus+action.aimed_shot.cast_regen*(variable.vuln_aim_casts-1))%action.aimed_shot.cost)
--actions.patient_sniper+=/variable,name=can_gcd,value=variable.vuln_window<action.aimed_shot.cast_time|variable.vuln_window>variable.vuln_aim_casts*action.aimed_shot.execute_time+gcd.max+0.1

