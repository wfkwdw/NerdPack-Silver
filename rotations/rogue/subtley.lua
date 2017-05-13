local GUI = {
	-- General
	{type = 'header', 		text = 'General', align = 'center'},
	{type = 'checkbox',		text = 'Multi-Dot',						key = 'multi', 	default = true},
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
	{ 'Crimson Vial', 'player.health <= UI(cv) & player.energy >= 35'},
	{ 'Evasion', 'player.threat >= 100'},
		
	-- Health Pot
	{ '#Ancient Healing Potion', 'UI(hp_check) & player.health <= UI(hp_spin)'},
	
	-- Healthstones
	{ '#Healthstone', 'UI(hs_check) & player.health <= UI(hs_spin)'},
	
	-- Tich
	{ 'Feint', '!player.buff.duration & player.debuff(Carrion Plague).count >= 2'},
}

local cooldowns = {
	--# Cooldowns
	--actions.cds=potion,name=old_war,if=buff.bloodlust.react|target.time_to_die<=25|buff.shadow_blades.up
	--actions.cds+=/blood_fury,if=stealthed.rogue
	--actions.cds+=/berserking,if=stealthed.rogue
	--actions.cds+=/arcane_torrent,if=stealthed.rogue&energy.deficit>70
	
	--actions.cds+=/shadow_blades,if=combo_points.deficit>=2+stealthed.all-equipped.mantle_of_the_master_assassin&(cooldown.sprint.remains>buff.shadow_blades.duration*0.5|mantle_duration>0|cooldown.shadow_dance.charges_fractional>variable.shd_fractionnal|cooldown.vanish.up|target.time_to_die<=buff.shadow_blades.duration*1.1)
	{ 'Shadow Blades', 'player.combopoints.deficit >= 2 & player.stealthed'},
	--actions.cds+=/goremaws_bite,if=combo_points.deficit>=2+stealthed.all-equipped.mantle_of_the_master_assassin&(cooldown.sprint.remains>buff.shadow_blades.duration*(0.4+equipped.denial_of_the_halfgiants*0.2)|mantle_duration>0|cooldown.shadow_dance.charges_fractional>variable.shd_fractionnal|cooldown.vanish.up|target.time_to_die<=buff.shadow_blades.duration*1.1)
	{ 'Goremaw\'s Bite', 'player.combopoints.deficit >= 2 & player.stealthed'},
	--actions.cds+=/marked_for_death,target_if=min:target.time_to_die,if=target.time_to_die<combo_points.deficit|(raid_event.adds.in>40&combo_points.deficit>=cp_max_spend)
}

local build = {
	--# Builders
	--actions.build=shuriken_storm,if=spell_targets.shuriken_storm>=2
	{ 'Shuriken Storm', 'player.area(10).enemies >= 2 & toggle(aoe)'},
	--actions.build+=/gloomblade
	{ 'Gloomblade'},
	--actions.build+=/backstab
	{ 'Backstab'},
}

local finish = {
	--# Finishers
	--actions.finish=enveloping_shadows,if=buff.enveloping_shadows.remains<target.time_to_die&buff.enveloping_shadows.remains<=combo_points*1.8
	--actions.finish+=/death_from_above,if=spell_targets.death_from_above>=5
	{ 'Death from Above', 'target.area(8).enemies >= 5'},
	--actions.finish+=/nightblade,if=target.time_to_die-remains>8&(mantle_duration=0|remains<=mantle_duration)&((refreshable&(!finality|buff.finality_nightblade.up))|remains<tick_time*2)
	{ 'Nightblade', 'target.deathin > 8 & target.debuff.duration <= 4.5'},
	--actions.finish+=/nightblade,cycle_targets=1,if=target.time_to_die-remains>8&mantle_duration=0&((refreshable&(!finality|buff.finality_nightblade.up))|remains<tick_time*2)
	{ 'Nightblade', 'focus.enemy & focus.deathin > 8 & focus.debuff.duration <= 4.5 ', 'focus'},
	--actions.finish+=/death_from_above
	{ 'Death from Above'},
	--actions.finish+=/eviscerate
	{ 'Eviscerate'},
}

local sprinted = { 
	--# Sprinted
	--actions.sprinted=cancel_autoattack
	{ '/stopattack', 'isattacking'},
	{ '%pause'},
	--actions.sprinted+=/use_item,name=draught_of_souls
}

local stealthCooldowns = {
	--# Stealth Cooldowns
	--actions.stealth_cds=vanish,if=mantle_duration=0&cooldown.shadow_dance.charges_fractional<variable.shd_fractionnal+(equipped.mantle_of_the_master_assassin&time<30)*0.3
	--actions.stealth_cds+=/shadow_dance,if=charges_fractional>=variable.shd_fractionnal
	{ 'Shadow Dance', 'player.spell.charges >= 2.45'},
	--actions.stealth_cds+=/pool_resource,for_next=1,extra_amount=40
	--actions.stealth_cds+=/shadowmeld,if=energy>=40&energy.deficit>=10+variable.ssw_refund
	--actions.stealth_cds+=/shadow_dance,if=combo_points.deficit>=5-talent.vigor.enabled
	{ 'Shadow Dance', 'player.combopoints.deficit >= 5'},
}

local stealth_als = {
	--# Stealth Action List Starter
	--actions.stealth_als=call_action_list,name=stealth_cds,if=energy.deficit<=variable.stealth_threshold&(!equipped.shadow_satyrs_walk|cooldown.shadow_dance.charges_fractional>=variable.shd_fractionnal|energy.deficit>=10)
	{ stealthCooldowns, 'player.energy.time_to_max <= gcd'},
	--actions.stealth_als+=/call_action_list,name=stealth_cds,if=mantle_duration>2.3
	{ stealthCooldowns, 'player.buff(Master Assassin\'s Initiative).duration > 2.3'},
	--actions.stealth_als+=/call_action_list,name=stealth_cds,if=spell_targets.shuriken_storm>=5
	{ stealthCooldowns, 'player.area(10).enemies >= 5'},
	--actions.stealth_als+=/call_action_list,name=stealth_cds,if=(cooldown.shadowmeld.up&!cooldown.vanish.up&cooldown.shadow_dance.charges<=1)
	
	--actions.stealth_als+=/call_action_list,name=stealth_cds,if=target.time_to_die<12*cooldown.shadow_dance.charges_fractional*(1+equipped.shadow_satyrs_walk*0.5)
	{ stealthCooldowns, 'target.deathin < 12'},
}

local stealthed = {
	--# Stealthed Rotation
	--actions.stealthed=symbols_of_death,if=buff.symbols_of_death.remains<target.time_to_die&buff.symbols_of_death.remains<=buff.symbols_of_death.duration*0.3&(mantle_duration=0|buff.symbols_of_death.remains<=mantle_duration)
	{ 'Symbols of Death', 'player.buff.duration <= 10.5'},
	--actions.stealthed+=/call_action_list,name=finish,if=combo_points>=5&(spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk|(mantle_duration<=1.3&mantle_duration-gcd.remains>=0.3))
	{ finish, 'player.combopoints >= 5 & player.area(10).enemies >= 2 + prem.up'},
	--actions.stealthed+=/shuriken_storm,if=buff.shadowmeld.down&((combo_points.deficit>=3&spell_targets.shuriken_storm>=2+talent.premeditation.enabled+equipped.shadow_satyrs_walk)|(combo_points.deficit>=1+buff.shadow_blades.up&buff.the_dreadlords_deceit.stack>=29))
	{ 'Shuriken Storm', 'player.combopoints.deficit >= 3 & player.area(10) >= 2 + prem.up'},
	--actions.stealthed+=/call_action_list,name=finish,if=combo_points>=5&combo_points.deficit<2+talent.premeditation.enabled+buff.shadow_blades.up-equipped.mantle_of_the_master_assassin
	{ finish, 'player.combopoints >= 5 & player.combopoints.deficit < 2 + sb.up + prem.up'},
	--actions.stealthed+=/shadowstrike
	{ 'Shadowstrike'},
}

local simCraft = {
	--# Executed every time the actor is available.
	--actions=run_action_list,name=sprinted,if=buff.faster_than_light_trigger.up
	{ sprinted, 'player.buff(Sprint).duration >= 5'},
	{ '/startattack', '!isattacking'},
	--actions+=/call_action_list,name=cds
	{ cooldowns},
	--# Fully switch to the Stealthed Rotation (by doing so, it forces pooling if nothing is available)
	--actions+=/run_action_list,name=stealthed,if=stealthed.all
	{ stealthed, 'player.stealthed'},
	--actions+=/nightblade,if=target.time_to_die>8&remains<gcd.max&combo_points>=4
	{ 'Nightblade', 'target.deathin > 8 & target.debuff.duration < gcd & player.combopoints >= 4'},
	--actions+=/sprint,if=!equipped.draught_of_souls&mantle_duration=0&energy.time_to_max>=1.5&cooldown.shadow_dance.charges_fractional<variable.shd_fractionnal&!cooldown.vanish.up&target.time_to_die>=8&(dot.nightblade.remains>=14|target.time_to_die<=45)
	--actions+=/sprint,if=equipped.draught_of_souls&trinket.cooldown.up&mantle_duration=0
	--actions+=/call_action_list,name=stealth_als,if=(combo_points.deficit>=2+talent.premeditation.enabled|cooldown.shadow_dance.charges_fractional>=2.9)
	{ stealth_als, 'player.combopoints.deficit >= 2 & !talent(6,1) || player.combopoints.deficit >= 3 & talent(6,1) || player.spell(Shadow Dance).charges >= 2.9'},
	--actions+=/call_action_list,name=finish,if=combo_points>=5|(combo_points>=4&combo_points.deficit<=2&spell_targets.shuriken_storm>=3&spell_targets.shuriken_storm<=4)
	{ finish, 'player.combopoints >= 5 || player.combopoints >= 4 & player.combopoints deficit <= 2 & player.area(10).enemies >= 3 & player.area(10).enemies <= 4'},
	--actions+=/call_action_list,name=build,if=energy.deficit<=variable.stealth_threshold
	{ build, 'player.energy.time_to_max <= gcd'},
}


local singleTarget = {
	{ survival},
	{ '/startattack', '!isattacking'},
	--Maintain the Symbols of Death Icon Symbols of Death buff.
	{ 'Symbols of Death', 'player.buff.duration <= 10.5'},
	--Maintain Nightblade Icon Nightblade.
	{ 'Nightblade', 'target.debuff.duration <= 4.5 & player.combopoints >= 4'},
	--Activate Shadow Blades Icon Shadow Blades if available.
	{ 'Shadow Blades', '!player.buff(Shadow Dance) & player.energy >= 100'}, 
	--Enter Shadow Dance Icon Shadow Dance if you have 3 charges, or there is less than 30 seconds remaining before you get your third charge.
	{ 'Shadow Dance', 'player.spell.charges = 3 & & talent(6,1) & player.combopoints = 1 & player.deficit <= 25  & !player.buff(Subterfuge)'},
	{ 'Shadow Dance', 'player.spell.charges = 3 & & !talent(6,1) & player.combopoints = 3 & player.deficit <= 25  & !player.buff(Subterfuge)'},
	{ 'Shadow Dance', 'player.spell.charges = 2 & player.spell.cooldown <= 30 & !player.buff(Subterfuge)'},
	--Shadow Dance Icon Shadow Dance should be activated as close to Energy cap as possible (70 with Master of Shadows Icon Master of Shadows).
	--If talented into Premeditation Icon Premeditation you should aim to enter Shadow Dance Icon Shadow Dance with 1 Combo Point (3 Combo Points without Premeditation Icon Premeditation, and 6-7 Combo Points with Anticipation Icon Anticipation).
	--Use Shadowstrike Icon Shadowstrike as long you are Stealthed and have less than 5 combo points (7 with Anticipation Icon Anticipation).
	{ 'Shadowstrike', 'player.combopoints <= 5 & player.stealthed'},
	--Activate Vanish Icon Vanish when available (see Shadow Blades Icon Shadow Blades rules directly above).
	--Cast Goremaw's Bite Icon Goremaw's Bite on cooldown.
	{ 'Goremaw\'s Bite', 'player.combopoints.deficit >= 3 & player.time >= 20'},
	--Use Eviscerate Icon Eviscerate to spend Combo Points.
	{ 'Eviscerate', 'player.combopoints.deficit <= 1'},
	--Cast Backstab Icon Backstab to generate Combo Points.
	{ 'Backstab', 'player.combopoints.deficit >= 1 & player.deficit <= 10 & !player.stealthed & player.spell(Shadow Blades).cooldown'},
}

local preCombat = {
	{ 'Tricks of the Trade', '!focus.buff & pull_timer <= 4', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff & pull_timer <= 4', 'tank'},
	{ '#Potion of the Old War', '!player.buff & pull_timer <= 2 & UI(ow)'},
	{ 'Shadowstep', 'pull_timer <= 0'},
}

local inCombat = {
	{ keybinds},
	{ interrupts, 'target.interruptAt(35)'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ simCraft}
}

local outCombat = {
	{ 'Stealth', '!player.buff & !player.buff(Vanish)'},
	{ keybinds},
	{ preCombat}
}

NeP.CR:Add(261, {
	name = '[Silver] Rogue - Subtley',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
