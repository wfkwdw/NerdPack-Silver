local GUI = {
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'MultiDot (Bosses)',					key = 'MDb', 	default = true},
	{type = 'checkbox',	text = 'MultiDot (Mobs)',					key = 'MDm', 	default = true},}

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end


local dots = {
	{ '!Agony', 'debuff.duration <= 5.4 + gcd & range <= 40'},
	{ '!Agony', 'UI(MDb) & combat & enemy & debuff.duration <= 5.4 + gcd & range <= 40', {'boss1', 'boss2', 'boss3', 'boss4', 'boss5, focus'}},
	{ '!Agony', 'UI(MBm) & combat & debuff.duration <= 5.4 + gcd & range <= 40 & count.enemies.debuffs <= 4', 'enemies'},
	
	{ '!Corruption', 'debuff.duration <= 4.2 + gcd & range <= 40'},
	{ '!Corruption', 'UI(MDb) & combat & enemy & debuff.duration <= 4.2 + gcd & range <= 40', {'boss1', 'boss2', 'boss3', 'boss4', 'boss5, focus'}},
	{ '!Corruption', 'UI(MBm) & combat & debuff.duration <= 4.2 + gcd & range <= 40 & count.enemies.debuffs <= 3', 'enemies'},
	
	{ '!Siphon Life', 'debuff.duration <= 4.5 + gcd & range <= 40'},
	{ '!Siphon Life', 'UI(MDb) & combat & enemy &  debuff.duration <= 4.5 + gcd & range <= 40', {'boss1', 'boss2', 'boss3', 'boss4', 'boss5, focus'}},
	{ '!Siphon Life', 'UI(MBm) & combat & debuff.duration <= 4.5 + gcd & range <= 40 & count.enemies.debuffs <= 2', 'enemies'},
}

local agonyCycle = {
	{ '!Agony', 'combat & enemy & debuff.duration <= 5.4 + gcd & range <= 40', {'boss1', 'boss2', 'boss3', 'boss4', 'boss5'}},
	{ '!Agony', 'enemy & debuff.duration <= 5.4 + gcd & range <= 40', 'focus'},
	{ '!Agony', 'combat & debuff.duration <= 5.4+gcd & range <= 40 & count.enemies.debuffs <= 4', 'enemies'},
}

local corruptionCycle = {
	{ '!Corruption', 'combat & enemy & { talent(2,2) & !debuff  || !talent(2,2) & debuff.duration <= 4.2+gcd}  & range <= 40', {'boss1', 'boss2', 'boss3', 'boss4', 'boss5, focus'}},
	{ '!Corruption', 'enemy & debuff.duration <= 4.2 + gcd & range <= 40', 'focus'},
	{ '!Corruption', 'combat & { talent(2,2) & !debuff || !talent(2,2) & debuff.duration <= 4.2+gcd}  & range <= 40 & count.enemies.debuffs <= 3', 'enemies'},
}

local siphonLifeCycle = {
	{ '!Siphon Life', 'combat & enemy &  debuff.duration <= 4.5 + gcd & range <= 40', {'boss1', 'boss2', 'boss3', 'boss4', 'boss5, focus'}},
	{ '!Siphon Life', 'enemy & debuff.duration <= 4.5 + gcd & range <= 40', 'focus'},
	{ '!Siphon Life', 'combat & debuff.duration <= 4.5 + gcd & range <= 40 & count.enemies.debuffs <= 2', 'enemies'},
}

local aoe = {
	{ 'Agony', 'combat & debuff.duration <= 5.4 + gcd & range <= 40 & count.enemies.debuffs <= 4', 'enemies'},
	{ 'Seed of Corruption', '!debuff'},
	{ 'Seed of Corruption', 'combat & !debuff', 'enemies'},
}

local maleficGrasp = {
	--actions.mg=reap_souls,if=!buff.deadwind_harvester.remains&time>5&(buff.tormented_souls.react>=5|target.time_to_die<=buff.tormented_souls.react*(5+1.5*equipped.144364)+(buff.tormented_souls.react*(5+1.5*equipped.144364)%12*(5+1.5*equipped.144364)))
	{ 'Reap Souls', '!player.buff(Deadwind Harvester) & combat.time > 5 & player.buff(Tormented Souls).count >= 5'},
	--actions.mg+=/reap_souls,if=active_enemies>1&!buff.deadwind_harvester.remains&time>5&soul_shard>0&((talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3)|spell_targets.seed_of_corruption>=5)
	
	--actions.mg+=/agony,cycle_targets=1,if=remains<=tick_time+gcd
	{ '!Agony', '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & debuff.duration <= 5.4+gcd & !{ player.lastcast(Unstable Affliction) & debuff(Unstable Affliction).many < 3 }'},
	{ agonyCycle, '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & !player.lastcast(Unstable Affliction)'},
	--actions.mg+=/service_pet,if=dot.corruption.remains&dot.agony.remains
	--actions.mg+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
	{ 'Summon Doomguard', '!talent(6,1) & area(10).enemies > 2 & { ttd > 180 || health <= 20 || ttd < 30}', 'target'},  
	--actions.mg+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
	--actions.mg+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions.mg+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions.mg+=/berserking,if=prev_gcd.1.unstable_affliction|buff.soul_harvest.remains>=10
	--actions.mg+=/blood_fury
	{ 'Blood Fury'},
	--actions.mg+=/soul_harvest,if=buff.soul_harvest.remains<=8&buff.active_uas.stack>=2
	{ 'Soul Harvest', 'player.buff.duration <= 8 & target.debuff(Unstable Affliction).many >= 2'}, 
	--actions.mg+=/use_item,slot=trinket1
	{ '#trinket1'},
	--actions.mg+=/use_item,slot=trinket2
	{ '#trinket2'},
	--actions.mg+=/potion,name=prolonged_power,if=!talent.soul_harvest.enabled&(trinket.proc.any.react|trinket.stack_proc.any.react|target.time_to_die<=70|buff.active_uas.stack>2)
	--actions.mg+=/potion,name=prolonged_power,if=talent.soul_harvest.enabled&buff.soul_harvest.remains&(trinket.proc.any.react|trinket.stack_proc.any.react|target.time_to_die<=70|buff.active_uas.stack>2)
	--actions.mg+=/siphon_life,if=remains<=tick_time+gcd
	{ '!Siphon Life', '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) }  & debuff.duration <= 4.5+gcd & !{ player.lastcast(Unstable Affliction) & debuff(Unstable Affliction).many < 3 }'},
	--actions.mg+=/siphon_life,cycle_targets=1,if=active_enemies>1&remains<=tick_time+gcd&buff.active_uas.stack=0
	{ siphonLifeCycle, '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & target.debuff(Unstable Affliction).many = 0'},
	--actions.mg+=/corruption,if=remains<=tick_time+gcd&((spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled)|spell_targets.seed_of_corruption<5)
	{ '!Corruption', '!player.casting(Unstable Affliction) & { talent(2,2) & !debuff || !talent(2,2) & debuff.duration <= 4.2+gcd} & { target.area(10).enemies < 3 & talent(4,2) || target.area(10).enemies < 5 || !toggle(aoe) } & !{ player.lastcast(Unstable Affliction) & debuff(Unstable Affliction).many < 3 }'},
	--actions.mg+=/corruption,cycle_targets=1,if=active_enemies>1&remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<5)&(buff.active_uas.stack=0|equipped.132457)
	{ corruptionCycle, '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & { toggle(aoe) & { target.area(10).enemies < 3 & talent(4,2) || target.area(10).enemies < 5 } & { target.debuff(Unstable Affliction).many = 0 || equipped(132457)}}'},
	--actions.mg+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
	--actions.mg+=/reap_souls,if=(buff.deadwind_harvester.remains+buff.tormented_souls.react*(5+equipped.144364))>=(12*(5+1.5*equipped.144364))&buff.active_uas.stack<1
	--actions.mg+=/phantom_singularity
	{ 'Phantom Singularity'},
	--actions.mg+=/agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&buff.active_uas.stack=0
	{ agonyCycle, '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & target.debuff(Unstable Affliction).many = 0 & !{ player.lastcast(Unstable Affliction) & target.debuff(Unstable Affliction).many = 0 }'},
	--actions.mg+=/life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
	--actions.mg+=/siphon_life,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&buff.active_uas.stack=0
	--actions.mg+=/seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=5|spell_targets.seed_of_corruption>=3&dot.corruption.remains<=cast_time+travel_time
	{ 'Seed of Corruption', 'toggle(aoe) & { talent(4,2) & target.area(10).enemies >= 3 || target.area(10).enemies >= 5}'},
	--actions.mg+=/corruption,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&buff.active_uas.stack=0
	--actions.mg+=/unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&(target.time_to_die<30|prev_gcd.1.unstable_affliction&soul_shard>=4&(equipped.132457|buff.active_uas.stack<2))
	{ '!Unstable Affliction', '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & !player.moving & { !talent(4,2) || area(10).enemies < 3 } & area(10).enemies < 5 & { player.lastcast & player.soulshards >= 4 & { equipped(132457) || debuff.many < 2 }}', "target"},
	--actions.mg+=/unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&(soul_shard>=4|(equipped.132457&soul_shard=5))
	{ '!Unstable Affliction', '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & !player.moving & { !talent(4,2) || target.area(10).enemies < 3 } & target.area(10).enemies < 5 & { player.soulshards >= 4 || { equipped(132457 & player.soulshards = 5}}'},
	--actions.mg+=/unstable_affliction,if=!equipped.132457&!prev_gcd.3.unstable_affliction&dot.agony.remains>cast_time*2+6.5&(dot.corruption.remains>cast_time+6.5|talent.absolute_corruption.enabled)&(!talent.siphon_life.enabled|dot.siphon_life.remains>cast_time+6.5)
	{ '!Unstable Affliction', '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & !player.moving & !equipped(132457) & { player.lastcast & debuff.many < 3 } & debuff.many < 3 & debuff(Agony).duration > player.spell.casttime+6.5 & { debuff(Corruption).duration+6.5 || talent(2,2)} & { !talent(7,2) || debuff(Siphon Life).duration > player.spell.casttime+6.5}'}, 
	--actions.mg+=/unstable_affliction,if=(!talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<3)&spell_targets.seed_of_corruption<5&equipped.132457&(buff.active_uas.stack=0|!prev_gcd.3.unstable_affliction&prev_gcd.1.unstable_affliction)&dot.agony.remains>cast_time+6.5
	{ '!Unstable Affliction', '{ !player.casting(Unstable Affliction) & !player.casting(Seed of Corruption) } & !player.moving & { !talent(4,2) ||target.area(10).enemies < 3 } & target.area(10).enemies < 5 & equipped(132457) & { debuff.many = 0 || { player.lastcast & debuff.many != 3} & debuff.many = 1 } & debuff(Agony).duration > player.spell.casttime+6.5'},
	--actions.mg+=/reap_souls,if=!buff.deadwind_harvester.remains&(buff.active_uas.stack>1|(prev_gcd.1.unstable_affliction&buff.tormented_souls.react>1))
	{ 'Reap Souls', '!player.buff(Deadwind Harvester) & { target.debuff(Unstable Affliction).many > 1 || { player.lastcast(Unstable Affliction) & player.buff(Tormented Souls).count > 1}}'},
	--actions.mg+=/life_tap,if=mana.pct<=10
	{ 'Life Tap', 'player.mana <= 35'},
	--actions.mg+=/drain_soul,chain=1,interrupt=1
	{ 'Drain Soul', '!player.moving'},
	--actions.mg+=/life_tap
	{ 'Life Tap'},
}

local burningRush = {
	{ '/cancelaura Burning Rush', 'player.lastmoved >= .02 & player.buff(Burning Rush)'},
	{ 'Burning Rush', 'player.movingfor >= 2 & !player.buff'},
}

local testing = {
	{ 'Life Tap', 'player.mana <= 10'},
	{ '!Drain Soul', nil, 'target'},
}

local inCombat = {
	--{ testing},
	{ burningRush},
	{ maleficGrasp, 'talent(1,3)'}, 	
}

local outCombat = {
	{ burningRush},
}

NeP.CR:Add(265, {
  name = '[Silver] Warlock - Affliction',
  ic = inCombat,
  ooc = outCombat,
  gui = GUI,
  load = exeOnLoad
})