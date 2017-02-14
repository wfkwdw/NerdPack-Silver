local GUI = {
}

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local soulEffigy = {
	{ 'macro(SoulEffigy)'},

}

local rotation = {
	--actions=reap_souls,if=!buff.deadwind_harvester.remains&(buff.soul_harvest.remains|buff.tormented_souls.react>=8|target.time_to_die<=buff.tormented_souls.react*5|trinket.proc.any.react|trinket.stacking_proc.any.react)
	--actions+=/reap_souls,if=!buff.deadwind_harvester.remains&!trinket.has_stacking_stat.any&!trinket.has_stat.any&prev_gcd.unstable_affliction
	--actions+=/soul_effigy,if=!pet.soul_effigy.active
	--actions+=/agony,cycle_targets=1,if=remains<=tick_time+gcd
	--actions+=/service_pet,if=dot.corruption.remains&dot.agony.remains
	--actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
	--actions+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3
	--actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions+=/berserking
	--actions+=/blood_fury
	--actions+=/arcane_torrent
	--actions+=/soul_harvest
	--actions+=/potion,name=deadly_grace,if=buff.soul_harvest.remains|trinket.proc.any.react|target.time_to_die<=45
	--actions+=/corruption,cycle_targets=1,if=remains<=tick_time+gcd
	--actions+=/siphon_life,cycle_targets=1,if=remains<=tick_time+gcd
	--actions+=/mana_tap,if=ptr=0&buff.mana_tap.remains<=buff.mana_tap.duration*0.3&(mana.pct<20|buff.mana_tap.remains<=gcd)&target.time_to_die>buff.mana_tap.duration*0.3
	--actions+=/life_tap,if=ptr=1&talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<=gcd
	--actions+=/phantom_singularity
	--actions+=/haunt,if=ptr=1
	--actions+=/unstable_affliction,if=ptr=1&talent.writhe_in_agony.enabled&talent.contagion.enabled
	{ 'Unstable Affliction', 'talent(1,2) & talent(2,1)'},
	--actions+=/unstable_affliction,if=ptr=1&talent.writhe_in_agony.enabled&(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
	--actions+=/unstable_affliction,if=ptr=1&talent.malefic_grasp.enabled&(target.time_to_die<30|dot.agony.remains>cast_time+8*spell_haste&(dot.corruption.remains>cast_time+8*spell_haste|talent.absolute_corruption.enabled)&(dot.siphon_life.remains>cast_time+8*spell_haste|!talent.siphon_life.enabled)|soul_shard>=4)
	--actions+=/unstable_affliction,if=ptr=1&talent.haunt.enabled&(soul_shard>=4|debuff.haunt.remains|target.time_to_die<30)
	--actions+=/unstable_affliction,if=ptr=0&talent.contagion.enabled|(soul_shard>=4|trinket.proc.intellect.react|trinket.stacking_proc.mastery.react|trinket.proc.mastery.react|trinket.proc.crit.react|trinket.proc.versatility.react|buff.soul_harvest.remains|buff.deadwind_harvester.remains|buff.compounding_horror.react=5|target.time_to_die<=20)
	--actions+=/life_tap,if=ptr=1&talent.empowered_life_tap.enabled&buff.empowered_life_tap.remains<duration*0.3
	--actions+=/agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/corruption,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/haunt
	--actions+=/siphon_life,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains
	--actions+=/life_tap,if=mana.pct<=10
	--actions+=/drain_soul,chain=1,interrupt=1
	--actions+=/drain_life,chain=1,interrupt=1,if=ptr=0
	--actions+=/life_tap
}

local inCombat = {
	{ '!Unstable Affliction', { 'player.soulshards > 0', 'target.debuff', '!player.casting(Unstable Affliction)'}},
	--{ '/targetlasttarget', 'player.lastcast(Soul Effigy)'},
	{ soulEffigy, 'player.lastcast(Soul Effigy)'},
	{ '!Agony', { 'target.debuff.duration <= 5.4', '!player.casting(Unstable Affliction)'}},
	{ 'Seed of Corruption', 'toggle(AOE)'},
	{ '!Unstable Affliction', { 'player.soulshards >= 4', '!player.casting(Unstable Affliction)'}},
	{ '!Corruption', { '!talent(2,2)', 'target.debuff.duration <= 4.2', '!player.casting(Unstable Affliction)'}},
	{ '!Corruption', { 'talent(2,2)', '!target.debuff', '!player.casting(Unstable Affliction)'}},
	{ 'Soul Effigy', '!target.debuff'},
	{ '63106', 'target.debuff.duration <= 4.5'}, -- Siphon Life
	{{
		{ '!Agony', { 'focus.debuff.duration <= 5.4', '!player.casting(Unstable Affliction)'}, 'focus'},
		{ '!Corruption', { '!talent(2,2)', 'focus.debuff.duration <= 4.2', '!player.casting(Unstable Affliction)'}, 'focus'},
		{ '!Corruption', { 'talent(2,2)', '!focus.debuff', '!player.casting(Unstable Affliction)'}, 'focus'},
		{ '63106', 'focus.debuff.duration <= 4.5', 'focus'}, -- Siphon Life
	}, 'focus.exists'},
	{ 'Reap Souls', { 'player.soulshards >= 3', 'player.buff(Tormented Souls).count >= 3'}},
	{ 'Life Tap', { 'player.mana <= 30'}},
	{ 'Drain Soul', '!player.channeling(Drain Soul)'},

}

local outCombat = {

	--{PreCombat},
}

NeP.CR:Add(265, {
  name = '[Silver] Warlock - Affliction',
  ic = inCombat,
  ooc = outCombat,
  gui = GUI,
  load = exeOnLoad
})
