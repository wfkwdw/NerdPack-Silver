NeP.DSL:Register('demons', function()
	local haveDemon1
	local haveDemon2
	local haveDemon3
	local haveDemon4
	local totalDemons = 1
	local _,_,_, castTime = GetSpellInfo(211714)
	local have1, name1, start1, duration1 = GetTotemInfo(1)
	local have2, name2, start2, duration2 = GetTotemInfo(2)
	local have3, name3, start3, duration3 = GetTotemInfo(3)
	local have4, name4, start4, duration4 = GetTotemInfo(4)
	
	-- Time until exprires
	local expires1 = start1 - GetTime() + duration1
	local expires2 = start2 - GetTime() + duration2
	local expires3 = start3 - GetTime() + duration3
	local expires4 = start4 - GetTime() + duration4
	
	-- Demon Values
	local wildImps = 3
	local dreadstalkers = 4
	local darkglare = 2
	local doomguard = 3
	
	-- Demon 1
	if have1 == true then
		haveDemon1 = 1
			if haveDemon1 == 1 then
			--print("Demon 1: "..name1)
			--print('Expires in: '..expires1..' seconds')
				if name1 == 'Wild Imps' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + wildImps
					end
				end
				if name1 == 'Dreadstalkers' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + dreadstalkers
					end
				end
				if name1 == 'Darkglare' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + darkglare
					end
				end
				if name1 == 'Doomguard' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + doomguard
					end
				end
			end
		else haveDemon1 = 0
	end
	-- Demon 2
	if have2 == true then
		haveDemon2 = 1
			if haveDemon2 == 1 then
			--print("Demon 2: "..name2)
			--print('Expires in: '..expires2..' seconds')
				if name2 == 'Wild Imps' then
					if expires2 > castTime / 1000 then
						totalDemons = totalDemons + wildImps
					end
				end
				if name2 == 'Dreadstalkers' then
					if expires2 > castTime / 1000 then
						totalDemons = totalDemons + dreadstalkers
					end
				end
				if name2 == 'Darkglare' then
					if expires2 > castTime / 1000 then
						totalDemons = totalDemons + darkglare
					end
				end
				if name2 == 'Doomguard' then
					if expires2 > castTime / 1000 then
						totalDemons = totalDemons + doomguard
					end
				end
			end
		else haveDemon2 = 0
	end
	-- Demon 3
	if have3 == true then
		haveDemon3 = 1
			if haveDemon3 == 1 then
			--print("Demon 3: "..name3)
			--print('Expires in: '..expires3..' seconds')
				if name3 == 'Wild Imps' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + wildImps
					end
				end
				if name3 == 'Dreadstalkers' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + dreadstalkers
					end
				end
				if name3 == 'Darkglare' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + darkglare
					end
				end
				if name3 == 'Doomguard' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + doomguard
					end
				end
			end
		else haveDemon3 = 0
	end
	-- Demon 4
	if have4 == true then
		haveDemon4 = 1
			if haveDemon4 == 1 then
			--print("Demon 4: "..name4)
			--print('Expires in: '..expires4..' seconds')
				if name4 == 'Wild Imps' then
					if expires4 > castTime / 1000 then
						totalDemons = totalDemons + wildImps
					end
				end
				if name4 == 'Dreadstalkers' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + dreadstalkers
					end
				end
				if name4 == 'Darkglare' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + darkglare
					end	
				end
				if name4 == 'Doomguard' then
					if expires1 > castTime / 1000 then
						totalDemons = totalDemons + doomguard
					end
				end
			end
		else haveDemon4 = 0
	end
	--print(castTime / 1000)
	--print(totalDemons)
    return totalDemons
end)

NeP.DSL:Register('impduration', function()
	local _,_,_, castTime = GetSpellInfo(211714)
	local have1, name1, start1, duration1 = GetTotemInfo(1)
	local have2, name2, start2, duration2 = GetTotemInfo(2)
	local have3, name3, start3, duration3 = GetTotemInfo(3)
	local have4, name4, start4, duration4 = GetTotemInfo(4)
	local impDuration = 0
	local castReady = 0
	
	if have1 == true and name1 == 'Wild Imps' then
		impDuration = start1 - GetTime() + duration1
		--print('Wild Imp Duration: '..impDuration)
		if impDuration > castTime / 1000 then
			castReady = castReady + 1
		end
	end
	if have2 == true and name2 == 'Wild Imps' then
		impDuration = start2 - GetTime() + duration2
		--print('Wild Imp Duration: '..impDuration)
		if impDuration > castTime / 1000 then
			castReady = castReady + 1
		end
	end
	if have3 == true and name3 == 'Wild Imps' then
		impDuration = start3 - GetTime() + duration3
		--print('Wild Imp Duration: '..impDuration)
		if impDuration > castTime / 1000 then
			castReady = castReady + 1
		end
	end
	if have4 == true and name4 == 'Wild Imps' then
		impDuration = start4 - GetTime() + duration4
		--print('Wild Imp Duration: '..impDuration)
		if impDuration > castTime / 1000 then
			castReady = castReady + 1
		end
	end
	
	--print('Casttime: '..castTime / 1000)
	
	if impDuration < 0 then
		impDuration = 0
	end
	
	--print('Cast Ready: '..castReady)
	
	return castReady
end)

NeP.DSL:Register('dreadduration', function()
	local _,_,_, castTime = GetSpellInfo(211714)
	local have1, name1, start1, duration1 = GetTotemInfo(1)
	local have2, name2, start2, duration2 = GetTotemInfo(2)
	local have3, name3, start3, duration3 = GetTotemInfo(3)
	local have4, name4, start4, duration4 = GetTotemInfo(4)
	local dreadDuration = 0
	local castReady = 0
	
	if have1 == true and name1 == 'Dreadstalkers' then
		dreadDuration = start1 - GetTime() + duration1
		--print('Dreadstalker Duration: '..dreadDuration)
	end
	if have2 == true and name2 == 'Dreadstalkers' then
		dreadDuration = start2 - GetTime() + duration2
		--print('Dreadstalker Duration: '..dreadDuration)
	end
	if have3 == true and name3 == 'Dreadstalkers' then
		dreadDuration = start3 - GetTime() + duration3
		--print('Dreadstalker Duration: '..dreadDuration)
	end
	if have4 == true and name4 == 'Dreadstalkers' then
		dreadDuration = start4 - GetTime() + duration4
		--print('Dreadstalker Duration: '..dreadDuration)
	end
	
	--print('Casttime: '..castTime / 1000)
	
	if dreadDuration < 0 then
		dreadDuration = 0
	end
	
	if dreadDuration > castTime / 1000 then
		castReady = 1
	end
	
	--print('Cast Ready: '..castReady)
	
	return castReady
end)

local test = {
	{ 'Summon Felguard', 'player.impduration > 0'},
}

local keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local pet = {
	{ 'Health Funnel', 'pet.health <= 20', 'pet'},
}

local open = {

}

local burningRush = {
	{ '/cancelaura Burning Rush', 'player.lastmoved > 1 & player.buff'},
	{ 'Burning Rush', 'player.movingfor > 1 & !player.buff'},

}

local trinkets = {
	--Top Trinket usage if UI enables it.
	{'#trinket1'},
	--Bottom Trinket usage if UI enables it.
	{'#trinket2'}
}

local pet = {
	{ 'Summon Felguard', { '!pet.exists', '!player.lastcast'}},
	{ 'Summon Felguard', { 'pet.dead', '!player.lastcast'}}
}

local moving = {
	
}

local aoe = {
	{ '!105174', { '!player.moving', 'player.soulshards >= 4'}}, -- Hand of Guldan
	{ 'Implosion', 'player.lastcast(105174)'},
	{ 'Life Tap', { 'player.mana <= 30'}},
	{ 'Demonwrath'}
}

local simCraftRotation = {
	{ '#Potion of Prolonged Power', 'player.lastcast(Summon Doomguard)'},
	{ '!Shadow Bolt', '!player.moving & player.channeling(Demonwrath)'}, 
	--# Executed every time the actor is available.
	--actions=implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&buff.demonic_synergy.remains
	--{ 'Implosion', 'player.impduration < 1 & player.buff(Demonic Synergy)'},
	--actions+=/implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=3&buff.demonic_synergy.remains
	{ 'Implosion', 'player.lastcast(105174) & player.impduration < 1 & player.buff(Demonic Synergy)'},
	--actions+=/implosion,if=wild_imp_count<=4&wild_imp_remaining_duration<=action.shadow_bolt.execute_time&spell_targets.implosion>1
	--actions+=/implosion,if=prev_gcd.hand_of_guldan&wild_imp_remaining_duration<=4&spell_targets.implosion>2
	{ 'Implosion', 'player.lastcast(105174) & toggle(AOE)'},
	--actions+=/shadowflame,if=debuff.shadowflame.stack>0&remains<action.shadow_bolt.cast_time+travel_time
	
	{ trinkets, 'toggle(cooldowns)'},
	--actions+=/service_pet
	{ 'Grimoire: Felguard', 'toggle(cooldowns) & player.spell(211714).cooldown < 5'},
	--actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
	--actions+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
	{ 'Summon Doomguard', 'toggle(cooldowns) & player.spell(211714).cooldown < 5'},
	--actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions+=/call_dreadstalkers,if=!talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)
	{ 'Call Dreadstalkers', { '!player.moving', '!talent(7,1)'}},
	--actions+=/hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
	{ '105174', { '!player.moving', 'player.soulshards >= 4', '!talent(7,1)'}}, -- Hand of Guldan
	--actions+=/summon_darkglare,if=prev_gcd.hand_of_guldan
	{ 'Summon Darkglare', 'player.lastcast(105174)'},
	--actions+=/summon_darkglare,if=prev_gcd.call_dreadstalkers
	{ 'Summon Darkglare', 'player.lastcast(Call Dreadstalkers)'},
	--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains>5&soul_shard<3
	{ 'Summon Darkglare', { 'player.spell(Call Dreadstalkers).cooldown > 5', 'player.soulshards < 3'}},
	--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=3
	--actions+=/summon_darkglare,if=cooldown.call_dreadstalkers.remains<=action.summon_darkglare.cast_time&soul_shard>=1&buff.demonic_calling.react
	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains>2
	{ 'Call Dreadstalkers', { '!player.moving', 'talent(7,1)', 'player.spell(Summon Darkglare).cooldown > 2'}},
	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&prev_gcd.summon_darkglare
	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=3
	--actions+=/call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&cooldown.summon_darkglare.remains<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react
	--actions+=/hand_of_guldan,if=soul_shard>=3&prev_gcd.call_dreadstalkers
	{ '105174', { '!player.moving', 'player.soulshards >= 4', 'player.lastcast(Call Dreadstalkers)'}},
	--actions+=/hand_of_guldan,if=soul_shard>=5&cooldown.summon_darkglare.remains<=action.hand_of_guldan.cast_time
	--actions+=/hand_of_guldan,if=soul_shard>=4&cooldown.summon_darkglare.remains>2
	{ '105174', { '!player.moving', 'player.soulshards >= 4', 'player.spell(Summon Darkglare).cooldown > 2'}},
	--actions+=/demonic_empowerment,if=wild_imp_no_de>3|prev_gcd.hand_of_guldan
	{ 'Demonic Empowerment', 'player.lastcast(105174)'},
	--actions+=/demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
	{ 'Demonic Empowerment', 'player.lastcast(Call Dreadstalkers)'},
	{ 'Demonic Empowerment', 'player.lastcast(Doomguard)'},
	{ 'Demonic Empowerment', 'player.lastcast(Summon Darkglare)'},
	{ 'Demonic Empowerment', 'player.lastcast(Grimoire: Felguard)'},
	{ 'Demonic Empowerment', '!pet.buff & !player.moving'},
	--actions+=/felguard:felstorm
	{ 'Felstorm'},
	--actions+=/doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
	{ 'Doom', 'target.debuff!'},
	--actions+=/arcane_torrent
	--actions+=/berserking
	--actions+=/blood_fury
	--actions+=/soul_harvest
	{ 'Soul Harvest', 'toggle(cooldowns)'},
	--actions+=/shadowflame,if=charges=2
	--actions+=/thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
	{ '211714', { '!player.moving', 'player.impduration > 0', 'player.dreadduration > 0'}}, 
	--actions+=/life_tap,if=mana.pct<=30
	{ 'Life Tap', { 'player.mana <= 30'}},
	--actions+=/demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
	--actions+=/demonwrath,moving=1,chain=1,interrupt=1
	{ 'Demonwrath', 'player.movingfor >= 1'},
	{ 'Demonwrath', 'toggle(AOE)'},
	--actions+=/demonbolt
	{ 'Demonbolt', '!player.moving'},
	--actions+=/shadow_bolt
	{ 'Shadow Bolt', '!player.moving'},
	--actions+=/life_tap
	{ 'Life Tap'},
}

local opener = {
	{ simCraftRotation, 'player.spell(211714).cooldown > 1'},
	{ 'Doom', '!target.debuff'},
	{ 'Felstorm'},
	{ 'Summon Doomguard', 'toggle(cooldowns)'},
	{ 'Grimoire: Felguard', 'toggle(cooldowns)'},
	{ 'Demonic Empowerment', 'player.lastcast(Call Dreadstalkers)'},
	{ 'Demonic Empowerment', 'player.lastcast(Doomguard)'},
	{ 'Demonic Empowerment', 'player.lastcast(Summon Darkglare)'},
	{ 'Demonic Empowerment', 'player.lastcast(Grimoire: Felguard)'},
	{ 'Demonic Empowerment', 'player.lastcast(105174)'},
	{ '105174', { '!player.moving', 'player.soulshards >= 5'}},
	{ 'Call Dreadstalkers', { '!player.moving', 'player.buff(Demonic Calling)'}},
	{ 'Call Dreadstalkers', { 'player.impduration > 0 & player.soulshards >= 4'}},
	{ '105174', { '!player.moving', 'player.soulshards >= 3', 'player.dreadduration > 0'}},
	{ '211714', { '!player.moving', 'player.impduration > 0', 'player.dreadduration > 0'}}, 
	{ 'Shadow Bolt', '!player.moving'},
}

local preCombat = {
	{ 'Demonic Empowerment', '!pet.buff & pull_timer <= 4'},
	{ '#Potion of Prolonged Power', '!player.buff & pull_timer <= 2'},
	{ 'Shadow Bolt', 'pull_timer <= 1.5'},
}

local survival = { 
	--Health Stone below 20% health. Active when NOT channeling Divine Hymn.
	{ '#Healthstone', 'player.health <= 30'},
	--Ancient Healing Potion below 20% health. Active when NOT channeling Divine Hymn.
	{ '#Ancient Healing Potion', 'player.health <= 30'},
	-- Drain Life
	{ 'Drain Life', 'player.health <= 30'},
}

local inCombat = {
	{ pet},
    { "/targetenemy [noexists]", "!target.exists" },
    { "/targetenemy [dead][noharm]", "target.dead" },
	{ survival},
	{ aoe, 'toggle(AOE)'},
	{ opener, 'combat.time <= 20 & !toggle(AOE)'},
	{ simCraftRotation, '!toggle(AOE)'},
}

local outCombat = {
	{ keybinds},
	--{ burningRush},
	{ pet},
	{ preCombat},
}

NeP.CR:Add(266, '[Silver] Warlock - Demonology', inCombat, outCombat)