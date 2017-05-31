local GUI = {
	-- General
	{type = 'header', 		text = 'General', align = 'center'},
	{type = 'checkbox',		text = 'Multi-Dot',						key = 'multi', 	default = true},
	{type = 'checkbox',		text = 'Sinister Circulation',			key = 'sin', 	default = true},
	{type = 'checkbox',		text = 'Mantle of the Master Assassin',	key = 'mantle', default = true},
	{type = 'ruler'},{type = 'spacer'},
	
	-- Survival
	{type = 'header', 		text = 'Survival', align = 'center'},
	{type = 'spinner', 		text = 'Crimson Vial', 					key = 'cv', 	default_spin = 65},
	{type = 'checkspin', 	text = 'Health Potion', 				key = 'hp', 	default_check = true, default_spin = 25},
	{type = 'checkspin',	text = 'Healthstone', 					key = 'hs', 	default_check = true, default_spin = 25},
	{type = 'ruler'},{type = 'spacer'},
	
	--Cooldowns
	{type = 'header', 		text = 'Cooldowns when toggled on', align = 'center'},
	{type = 'checkbox',		text = 'Vanish',						key = 'van', 	default = true},
	{type = 'checkbox',		text = 'Vendetta',						key = 'ven', 	default = true},
	{type = 'checkbox',		text = 'Potion of the Old War',			key = 'ow', 	default = true},
	{type = 'ruler'},{type = 'spacer'},} 

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- Supported Talents')
	print('|cffADFF2F --- 1,1 / 2,1 / 3,3 / any / any / 6,1 or 6,2 / 7,1')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local keybinds = {

}

local interrupts = {
	{ 'Kick'},
	{ 'Arcane Torrent', 'target.range <= 8 & spell(Kick).cooldown > gcd & !prev_gcd(Rebuke)'},
}

local survival = {
	{ 'Feint', 'boss1.buff(Blood of the Father) & !player.buff'},

	{ 'Crimson Vial', 'player.health <= UI(cv) & player.energy >= 35'},
	{ 'Feint', 'player.health <= 75 & !player.buff & talent(4,2)'},
	{ 'Feint', '!player.buff & player.health <= UI(cv) & player.xequipped(137069)'},
	
	-- Health Pot
	{ '#Ancient Healing Potion', 'UI(hp_check) & player.health <= UI(hp_spin)'},
	
	-- Healthstones
	{ '#Healthstone', 'UI(hs_check) & player.health <= UI(hs_spin)'},
	
	-- Tich
	{ 'Feint', '!player.buff & player.debuff(Carrion Plague)'},
	
	-- Krosus
	{ 'Feint', '!player.buff & target.casting(Slam).percent >= 75 & !player.lastcast'},
	{ 'Feint', '!player.buff & target.casting(Orb of Destruction).percent >= 75 & !player.lastcast'},
	{ 'Feint', '!player.buff & target.casting(Burning Pitch).percent >= 75 & !player.lastcast'},
	{ 'Feint', '!player.buff & boss1.casting(Slam).percent >= 75 & !player.lastcast'},
	{ 'Feint', '!player.buff & boss1.casting(Orb of Destruction).percent >= 75 & !player.lastcast'},
	{ 'Feint', '!player.buff & boss1.casting(Burning Pitch).percent >= 75 & !player.lastcast'},
}

local cooldowns = {
	--# Cooldowns
	--actions.cds=potion,name=old_war,if=buff.bloodlust.react|target.time_to_die<=25|debuff.vendetta.up&cooldown.vanish.remains<5
	{ '#Potion of the Old War', 'UI(ow) & player.hashero'},
	--{ '#Potion of the Old War', 'UI(ow) & target.ttd <= 25 & player.sated'},
	{ '#Potion of the Old War', 'UI(ow) & target.debuff(Vendetta) & player.spell(Vanish).cooldown <= 5 & player.sated'},
	--actions.cds+=/use_item,name=draught_of_souls,if=energy.deficit>=35+variable.energy_regen_combined*2&(!equipped.mantle_of_the_master_assassin|cooldown.vanish.remains>8)&(!talent.agonizing_poison.enabled|debuff.agonizing_poison.stack>=5&debuff.surge_of_toxins.remains>=3)
	--actions.cds+=/use_item,name=draught_of_souls,if=mantle_duration>0&mantle_duration<3.5&dot.kingsbane.ticking
	--actions.cds+=/blood_fury,if=debuff.vendetta.up
	{ 'Blood Fury', 'target.debuff(Vendetta)'},
	--actions.cds+=/berserking,if=debuff.vendetta.up
	{ 'Berserking', 'target.debuff(Vendetta)'},
	--actions.cds+=/arcane_torrent,if=dot.kingsbane.ticking&!buff.envenom.up&energy.deficit>=15+variable.energy_regen_combined*gcd.remains*1.1
	--actions.cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit*1.5|(raid_event.adds.in>40&combo_points.deficit>=cp_max_spend)
	--actions.cds+=/vendetta,if=!artifact.urge_to_kill.enabled|energy.deficit>=60+variable.energy_regen_combined
	{ 'Vendetta', 'player.deficit >= 60 + variable.energy_regen_combined & UI(ven)'},
	--# Nightstalker w/o Exsanguinate: Vanish Envenom if Mantle & T19_4PC, else Vanish Rupture
	--actions.cds+=/vanish,if=talent.nightstalker.enabled&combo_points>=cp_max_spend&!talent.exsanguinate.enabled&((equipped.mantle_of_the_master_assassin&set_bonus.tier19_4pc&mantle_duration=0)|((!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)&(dot.rupture.refreshable|debuff.vendetta.up)))
	{ 'Vanish', 'talent(2,1) & player.combopoints.deficit < 1 & !talent(6,3) & UI(van) & {{ player.xequipped(144236) & player.rogue.t19 >= 4 & !player.buff(Master Assassin\'s Initiative)} || {{ !player.xequipped(144236) || player.rogue.t19 < 4 } & { target.debuff(Rupture).duration <= 7.2 || target.debuff(Vendetta)}}}'},
	--actions.cds+=/vanish,if=talent.nightstalker.enabled&combo_points>=cp_max_spend&talent.exsanguinate.enabled&cooldown.exsanguinate.remains<1&(dot.rupture.ticking|time>10)
	{ 'Vanish', 'talent(2,1) & player.combopoints.deficit < 1 & talent(6,1) & player.spell(Exsanguinate).cooldown < 1 & UI(van) & { target.debuff(Rupture) || time > 10}'},
	--actions.cds+=/vanish,if=talent.subterfuge.enabled&equipped.mantle_of_the_master_assassin&(debuff.vendetta.up|target.time_to_die<10)&mantle_duration=0
	
	--actions.cds+=/vanish,if=talent.subterfuge.enabled&!equipped.mantle_of_the_master_assassin&!stealthed.rogue&dot.garrote.refreshable&((spell_targets.fan_of_knives<=3&combo_points.deficit>=1+spell_targets.fan_of_knives)|(spell_targets.fan_of_knives>=4&combo_points.deficit>=4))
	
	--actions.cds+=/vanish,if=talent.shadow_focus.enabled&variable.energy_time_to_max_combined>=2&combo_points.deficit>=4
	
	--actions.cds+=/exsanguinate,if=prev_gcd.1.rupture&dot.rupture.remains>4+4*cp_max_spend
	
}

local build = {
	--# Builders
	--actions.build=hemorrhage,if=refreshable
	--actions.build+=/hemorrhage,cycle_targets=1,if=refreshable&dot.rupture.ticking&spell_targets.fan_of_knives<2+talent.agonizing_poison.enabled+equipped.insignia_of_ravenholdt
	--actions.build+=/fan_of_knives,if=spell_targets>=2+talent.agonizing_poison.enabled+equipped.insignia_of_ravenholdt|buff.the_dreadlords_deceit.stack>=29
	{ 'Fan of Knives', 'player.area(10).enemies >= 2 + talent.enabled(7,1) + xequipped(137049) & toggle(aoe)'},
	--actions.build+=/mutilate,cycle_targets=1,if=(!talent.agonizing_poison.enabled&dot.deadly_poison_dot.refreshable)|(talent.agonizing_poison.enabled&debuff.agonizing_poison.remains<debuff.agonizing_poison.duration*0.3)
	{ 'Mutilate', '{ !talent(7,1) & target.debuff(Deadly Poison).duration <= 4.5} || { talent(7,1) & debuff(Agonizing Poison).duration < 3.6}'},
	--actions.build+=/mutilate
	{ 'Mutilate'},
	--actions.build+=/poisoned_knife,cycle_targets=1,if=talent.agonizing_poison.enabled&debuff.agonizing_poison.remains<debuff.agonizing_poison.duration*0.3&debuff.agonizing_poison.stack>=5
	{ 'Poisoned Knife', 'talent(7,1) & target.debuff(Agonizing Poison).duration <= 3.6'},
}
	
local finish = {
	--# Finishers
	--actions.finish=death_from_above,if=combo_points>=5
	{ 'Death from Above', 'player.combopoints >= 5'},
	--actions.finish+=/envenom,if=combo_points>=4&(debuff.vendetta.up|mantle_duration>=gcd.remains+0.2|debuff.surge_of_toxins.remains<gcd.remains+0.2|energy.deficit<=25+variable.energy_regen_combined)
	{ 'Envenom', 'player.combopoints >= 4 & { target.debuff(Vendetta) || player.buff(Master Assassin\'s Initiative).duration >= gcd.remains + 0.2 || target.debuff(Surge of Toxins).duration < gcd.remains + 0.4 ||  player.deficit <= 25 + variable.energy_regen_combined}'},
	--actions.finish+=/envenom,if=talent.elaborate_planning.enabled&combo_points>=3+!talent.exsanguinate.enabled&buff.elaborate_planning.remains<gcd.remains+0.2
	{ 'Envenom', 'talent(1,2) & player.combopoints >= 3 & player.buff(Elaborate Planning).duration < gcd.remains + 0.2'},
}
	
local kingsbane = {
	--# Kingsbane
	--# Sinister Circulation makes it worth to cast Kingsbane on CD exceot if you're [stealthed w/ Nighstalker and have Mantle & T19_4PC to Envenom] or before vendetta if you have mantle during the opener.
	--actions.kb=kingsbane,if=artifact.sinister_circulation.enabled&!(equipped.duskwalkers_footpads&equipped.convergence_of_fates&artifact.master_assassin.rank>=6)&(time>25|!equipped.mantle_of_the_master_assassin|(debuff.vendetta.up&debuff.surge_of_toxins.up))&(talent.subterfuge.enabled|!stealthed.rogue|(talent.nightstalker.enabled&(!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)))
	--{ 'Kingsbane', 'UI(sin) 
	--actions.kb+=/kingsbane,if=!talent.exsanguinate.enabled&buff.envenom.up&((debuff.vendetta.up&debuff.surge_of_toxins.up)|cooldown.vendetta.remains<=5.8|cooldown.vendetta.remains>=10)
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & {{ target.debuff(Vendetta) & target.debuff(Surge of Toxins)} || player.spell(Vendetta).cooldown <= 5.8 || player.spell(Vendetta).cooldown >= 10}'},
	--actions.kb+=/kingsbane,if=talent.exsanguinate.enabled&dot.rupture.exsanguinated
	{ 'Kingsbane', 'talent(6,3) & target.debuff(Exsanguinate)'},
}

local maintain = {
	--actions.maintain=rupture,if=talent.nightstalker.enabled&stealthed.rogue&(!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)&(talent.exsanguinate.enabled|target.time_to_die-remains>4)
	{ 'Rupture', 'talent(2,1) & player.stealthed & { !player.xequipped(144236) || player.rogue.t19 < 4} & { talent(6,3) || target.deathin > 4}'},
	--actions.maintain+=/garrote,cycle_targets=1,if=talent.subterfuge.enabled&stealthed.rogue&combo_points.deficit>=1&refreshable&(!exsanguinated|remains<=tick_time*2)&target.time_to_die-remains>2
	{ 'Garrote', 'talent(2,2) & player.stealthed & player.combopoints.deficit >= 1 & target.debuff.duration <= 5.4 & { !target.debuff(Exsanguinate) || target.debuff.duration <= 5.4} & target.deathin > 2'},
	--actions.maintain+=/garrote,cycle_targets=1,if=talent.subterfuge.enabled&stealthed.rogue&combo_points.deficit>=1&remains<=10&pmultiplier<=1&!exsanguinated&target.time_to_die-remains>2

	--actions.maintain+=/rupture,if=!talent.exsanguinate.enabled&combo_points>=3&!ticking&mantle_duration<=gcd.remains+0.2&target.time_to_die>6
	{ 'Rupture', '!talent(6,3) & player.combopoints >= 3 & !target.debuff & player.buff(Master Assassin\'s Initiative).duration <= gcd.remains + 0.2 & target.deathin > 6'},
	--actions.maintain+=/rupture,if=talent.exsanguinate.enabled&((combo_points>=cp_max_spend&cooldown.exsanguinate.remains<1)|(!ticking&(time>10|combo_points>=2+artifact.urge_to_kill.enabled)))
	{ 'Rupture', 'talent(6,3) & {{player.combopoints.deficit = 0 & player.spell(Exsanguinate).cooldown < 1} || { !target.debuff || { time > 10 || player.combopoints >= 2}}}'},
	--actions.maintain+=/rupture,cycle_targets=1,if=combo_points>=4&refreshable&(pmultiplier<=1|remains<=tick_time)&(!exsanguinated|remains<=tick_time*2)&target.time_to_die-remains>6
	{ 'Rupture', 'player.combopoints >= 4 & target.debuff.duration <= 7.2 & !target.debuff(Exsanguinate) & target.deathin > 6'},
	{ 'Rupture', 'mouseover.inmelee & mouseover.enemy & UI(multi) & player.combopoints >= 4 & mouseover.debuff.duration <= 7.2 & !mouseover.debuff(Exsanguinate) & mouseover.deathin > 6', 'mouseover'},
	{ 'Rupture', 'boss1.inmelee & boss1.enemy & UI(multi) &player.combopoints >= 4 & boss1.debuff.duration <= 7.2 & !boss1.debuff(Exsanguinate) & boss1.deathin > 6', 'boss1'},
	{ 'Rupture', 'boss2.inmelee & boss2.enemy & UI(multi) &player.combopoints >= 4 & boss2.debuff.duration <= 7.2 & !boss2.debuff(Exsanguinate) & boss2.deathin > 6', 'boss2'},
	{ 'Rupture', 'boss3.inmelee & boss3.enemy & UI(multi) &player.combopoints >= 4 & boss3.debuff.duration <= 7.2 & !boss3.debuff(Exsanguinate) & boss3.deathin > 6', 'boss3'},
	--actions.maintain+=/call_action_list,name=kb,if=combo_points.deficit>=1+(mantle_duration>=gcd.remains+0.2)
	{ kingsbane, 'player.combopoints.deficit >= 1'},
	--actions.maintain+=/pool_resource,for_next=1
	--actions.maintain+=/garrote,cycle_targets=1,if=(!talent.subterfuge.enabled|!(cooldown.vanish.up&cooldown.vendetta.remains<=4))&combo_points.deficit>=1&refreshable&(pmultiplier<=1|remains<=tick_time)&(!exsanguinated|remains<=tick_time*2)&target.time_to_die-remains>4
	{ 'Garrote', '{ !talent(2,2) || { !player.spell(Vanish).cooldown & player.spell(Vendetta).cooldown <= 4}} & player.combopoints.deficit >= 1 & target.debuff.duration <= 5.4 & !target.debuff(Exsanguinate) & target.deathin > 4'},
}

local simCraft = {
	{ survival},
	--# Executed every time the actor is available.
	--actions=variable,name=energy_regen_combined,value=energy.regen+poisoned_bleeds*(7+talent.venom_rush.enabled*3)%2 
	--actions+=/variable,name=energy_time_to_max_combined,value=energy.deficit%variable.energy_regen_combined
	--actions+=/call_action_list,name=cds
	{ cooldowns, 'toggle(cooldowns)'},
	--actions+=/call_action_list,name=maintain
	{ maintain},
	--# The 'active_dot.rupture>=spell_targets.rupture' means that we don't want to envenom as long as we can multi-rupture (i.e. units that don't have rupture yet).
	--actions+=/call_action_list,name=finish,if=(!talent.exsanguinate.enabled|cooldown.exsanguinate.remains>2)&(!dot.rupture.refreshable|(dot.rupture.exsanguinated&dot.rupture.remains>=3.5)|target.time_to_die-dot.rupture.remains<=6)&active_dot.rupture>=spell_targets.rupture
	{ finish}, -- Doesnt support Exsanguinate
	--actions+=/call_action_list,name=build,if=combo_points.deficit>1|energy.deficit<=25+variable.energy_regen_combined
	{ build, 'player.combopoints.deficit > 1 || player.deficit <= 25 + variable.energy_regen_combined'},
}

local utility = {
	{ 'Tricks of the Trade', '!focus.buff & !focus.enemy', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff', 'tank'},
}

local preCombat = {
	{ 'Tricks of the Trade', '!focus.buff & pull_timer <= 4', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff & pull_timer <= 4', 'tank'},
	{ '#Potion of the Old War', '!player.buff & pull_timer <= 2 & UI(ow)'},
	{ 'Garrote', 'pull_timer < 0.1'},
}

local inCombat = {
	{ '/targetenemy [dead][noharm]', '{target.dead || !target.exists} & !player.area(40).enemies=0'},
	{ '/startattack', '!isattacking & target.enemy'},
	{ utility},
	{ keybinds},
	{ interrupts, 'target.interruptAt(35)'},
	{ 'Feint', '!player.buff & player.debuff(Carrion Plague)'},
	{ survival},
	{ '/startattack', '!isattacking & target.enemy'},
	{ simCraft, 'target.enemy'},
}

local outCombat = {
	-- Poisons
	{ 'Deadly Poison', 'player.buff.duration <= 600 & !player.lastcast & !talent(6,1) & !moving'},
	{ 'Agonizing Poison', 'player.buff.duration <= 600 & !player.lastcast & talent(6,1) & !moving'},
	{ 'Leeching Poison', 'player.buff.duration <= 600 & !player.lastcast & talent(4,1) & !moving'},
	{ 'Crippling Poison', 'player.buff.duration <= 600 & !player.lastcast & !talent(4,1) & !moving'},
		
	{ 'Stealth', '!player.buff & !player.buff(Vanish)'},
	{ keybinds},
	{ preCombat}
}

NeP.CR:Add(259, {
	name = '[Silver] Rogue - Assassination',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
