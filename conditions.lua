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
