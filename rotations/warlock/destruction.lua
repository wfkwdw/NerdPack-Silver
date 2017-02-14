local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local simCraftRotation = {
	--actions=havoc,target=2,if=active_enemies>1&active_enemies<6&!debuff.havoc.remains
	--actions+=/havoc,target=2,if=active_enemies>1&!talent.wreak_havoc.enabled&talent.roaring_blaze.enabled&!debuff.roaring_blaze.remains
	--actions+=/dimensional_rift,if=charges=3
	{ 'Dimensional Rift', 'player.spell.charges = 3'},
	--actions+=/immolate,if=remains<=tick_time
	{ 'Immolate', 'target.debuff.duration <= 5.4'},
	--actions+=/immolate,cycle_targets=1,if=active_enemies>1&remains<=tick_time&!debuff.roaring_blaze.remains&action.conflagrate.charges<2
	--actions+=/immolate,if=talent.roaring_blaze.enabled&remains<=duration&!debuff.roaring_blaze.remains&target.time_to_die>10&(action.conflagrate.charges=2|(action.conflagrate.charges>=1&action.conflagrate.recharge_time<cast_time+gcd)|target.time_to_die<24)
	--actions+=/berserking
	--actions+=/blood_fury
	--actions+=/arcane_torrent
	--actions+=/potion,name=deadly_grace,if=(buff.soul_harvest.remains|trinket.proc.any.react|target.time_to_die<=45)
	--actions+=/conflagrate,if=talent.roaring_blaze.enabled&(charges=2|(action.conflagrate.charges>=1&action.conflagrate.recharge_time<gcd)|target.time_to_die<24)
	{ 'Conflagrate', 'talent(1,1) & player.spell.charges = 2'}, 
	{ 'Conflagrate', '!talent(1,1) & player.spell.charges >= 1'},
	{ 'Conflagrate', 'target.deathin < 24'},
	--actions+=/conflagrate,if=talent.roaring_blaze.enabled&debuff.roaring_blaze.stack>0&dot.immolate.remains>dot.immolate.duration*0.3&(active_enemies=1|soul_shard<3)&soul_shard<5
	--actions+=/conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remains&buff.conflagration_of_chaos.remains<=action.chaos_bolt.cast_time
	--actions+=/conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remains&(charges=1&recharge_time<action.chaos_bolt.cast_time|charges=2)&soul_shard<5
	--actions+=/service_pet
	--actions+=/summon_infernal,if=artifact.lord_of_flames.rank>0&!buff.lord_of_flames.remains
	--actions+=/summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<3&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
	--actions+=/summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>=3
	--actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&artifact.lord_of_flames.rank>0&buff.lord_of_flames.remains&!pet.doomguard.active
	--actions+=/summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions+=/summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remains
	--actions+=/soul_harvest
	--actions+=/channel_demonfire,if=dot.immolate.remains>cast_time
	--actions+=/chaos_bolt,if=soul_shard>3|buff.backdraft.remains
	{ 'Chaos Bolt', 'player.soulshards > 3 & player.buff(Backdraft)'},
	--actions+=/chaos_bolt,if=buff.backdraft.remains&prev_gcd.incinerate
	{ 'Chaos Bolt', 'player.buff(Backdraft) & player.lastcast(Incinerate)'},
	--actions+=/incinerate,if=buff.backdraft.remains
	{ 'Incinerate', 'player.buff(Backdraft)'},
	--actions+=/havoc,if=active_enemies=1&talent.wreak_havoc.enabled&equipped.132375&!debuff.havoc.remains
	--actions+=/rain_of_fire,if=active_enemies>=4&cooldown.havoc.remains<=12&!talent.wreak_havoc.enabled
	--actions+=/rain_of_fire,if=active_enemies>=6&talent.wreak_havoc.enabled
	--actions+=/dimensional_rift
	{ 'Dimensional Rift'},
	--actions+=/mana_tap,if=buff.mana_tap.remains<=buff.mana_tap.duration*0.3&(mana.pct<20|buff.mana_tap.remains<=action.chaos_bolt.cast_time)&target.time_to_die>buff.mana_tap.duration*0.3
	--actions+=/chaos_bolt
	{ 'Chaos Bolt'},
	--actions+=/cataclysm
	--actions+=/conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remains
	--actions+=/immolate,if=!talent.roaring_blaze.enabled&remains<=duration*0.3
	--actions+=/life_tap,if=talent.mana_tap.enabled&mana.pct<=10
	{ 'Life Tap', 'player.mana <= 10'},
	--actions+=/incinerate
	{ 'Incinerate'},
	--actions+=/life_tap
	{ 'Life Tap'},
}

local inCombat = {
	{ simCraftRotation},

	--{ 'Havoc', '!focus.debuff', 'focus'},

	--{ 'Immolate', '!target.debuff'},
	--{ 'Chaos Bolt', 'player.soulshards >= 5'},
	--{ 'Conflagrate'},
	--{ 'Incinerate'},
}

local outCombat = {
	{Keybinds},
}

NeP.CR:Add(267, '[Silver] Warlock - Destruction', inCombat, outCombat)