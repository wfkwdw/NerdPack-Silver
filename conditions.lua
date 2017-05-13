local _, Silver = ...

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

NeP.DSL:Register('stealthed', function()
	local stealth = UnitBuff('player', 'Stealth')
	local vanish = UnitBuff('player', 'Vanish')
	local subterfuge = UnitBuff('player', 'Subterfuge')
	local shadowDance = UnitBuff('player', 'Shadow Dance')
	
	if stealth then
		print('Stealth')
		return true
	end
	if vanish then
		print('Vanish')
		return true
	end
	if subterfuge then
		print('Subterfuge')
		return true
	end
	if shadowDance then
		print('Shadow Dance')
		return true
	end
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

NeP.DSL:Get('talent.enabled')(nil, '3,3')

NeP.DSL:Register('energy.regen', function()
    local eregen = select(2, GetPowerRegen('player'))
    return eregen
end)

NeP.DSL:Register('energy.time_to_max', function()
    local deficit = NeP.DSL:Get('deficit')()
    local eregen = NeP.DSL:Get('energy.regen')()
    return deficit / eregen
end)

NeP.DSL:Register('deficit', function()
    local max = UnitPowerMax('player')
    local curr = UnitPower('player')
    return (max - curr)
end)

NeP.DSL:Register('combopoints.deficit', function(target)
    return (UnitPowerMax('player', SPELL_POWER_COMBO_POINTS)) - (UnitPower('player', SPELL_POWER_COMBO_POINTS))
end)

NeP.DSL:Register('dot.ticking', function(target, spell)
    if NeP.DSL:Get('debuff')(target, spell) then
        return true
    else
        return false
    end
end)
