local GUI = {
	-- General
	{type = 'header', 		text = 'General', align = 'center'},
	{type = 'spinner', 		text = 'Pool Energy', key = 'pool', default_spin = 100},
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
		
	-- Health Pot
	
	
	-- Healthstones
	{ '#Healthstone', 'UI(hs_check) & player.health <= UI(hs_spin)'},
}

local cooldowns = {
	{ 'Vendetta', 'player.energy <= 50 & UI(ven)'},
	{ 'Vanish', 'player.combopoints >= 4 & UI(van)'},
}

local singleTarget = {
	{ 'Tricks of the Trade', '!focus.buff', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff', 'tank'},
	
	-- Rupture
	{ 'Rupture', 'player.buff(Vanish) & toggle(cooldowns)'},
	{ 'Rupture', 'target.debuff.duration <= 7.2 & player.combopoints >= 4 & target.debuff(Surge of Toxins).duration <= 0.5 & player.spell(Vanish).cooldown & target.ttd >= 6'},
	
	-- Multi DoT Rupture
	{ 'Rupture', 'boss1.enemy & boss1.inmelee & boss1.debuff.duration <= 7.2 & player.combopoints >= 4', 'boss1'},
	{ 'Rupture', 'boss2.enemy & boss2.inmelee & boss2.debuff.debuff.duration <= 7.2 & player.combopoints >= 4', 'boss2'},
	{ 'Rupture', 'boss3.enemy & boss3.inmelee & boss3.debuff.debuff.duration <= 7.2 & player.combopoints >= 4', 'boss3'},
	{ 'Rupture', 'focus.enemy & focus.inmelee & focus.debuff.duration <= 7.2 & player.combopoints >= 4', 'focus'},
	{ 'Rupture', 'mouseover.enemy & mouseover.inmelee & mouseover.debuff.duration <= 7.2 & player.combopoints >= 4', 'mouseover'},
	
	{ 'Garrote', 'target.debuff.duration <= 5.4 & player.combopoints <= 4 & target.inmelee'},
	
	-- Use Mutilate till 4/5 combopoints for rupture
	{ 'Mutilate', 'target.debuff(Rupture).duration <= 7.2 & player.combopoints <= 3 & target.inmelee'},
	
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & target.debuff(Vendetta) & target.debuff(Surge of Toxins) & target.ttd >= 10'},
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & player.spell(Vendetta).cooldown <= 5.8 & target.ttd >= 10'},
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & player.spell(Vendetta).cooldown >= 10 & target.ttd >= 10'},
	
	--[[
	actions.kb=kingsbane,if=
	artifact.sinister_circulation.enabled&!(equipped.duskwalkers_footpads&equipped.convergence_of_fates&artifact.master_assassin.rank>=6)&(time>25|!equipped.mantle_of_the_master_assassin|(debuff.vendetta.up&debuff.surge_of_toxins.up))&(talent.subterfuge.enabled|!stealthed.rogue|(talent.nightstalker.enabled&(!equipped.mantle_of_the_master_assassin|!set_bonus.tier19_4pc)))
	
	actions.kb+=/kingsbane,if=
	
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & target.debuff(Vendetta) & target.debuff(Surge of Toxins)'},
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & player.spell(Vendetta).cooldown <= 5.8'},
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & player.spell(Vendetta).cooldown >= 10'},
	
	
	--!talent.exsanguinate.enabled&buff.envenom.up&((debuff.vendetta.up&debuff.surge_of_toxins.up)
	|cooldown.vendetta.remains<=5.8|
	cooldown.vendetta.remains>=10)
	
	actions.kb+=/kingsbane,if=talent.exsanguinate.enabled&dot.rupture.exsanguinated
	]]--
	
	{ 'Envenom', 'player.combopoints >= 3 & target.debuff(Surge of Toxins).duration <= 0.5 & target.debuff(Vendetta)'},
	{ 'Envenom', 'player.combopoints >= 4 & target.debuff(Vendetta)'},
	{ 'Envenom', 'player.combopoints >= 4 & target.debuff(Surge of Toxins).duration <= 0.5'},
	{ 'Envenom', 'player.combopoints >= 4 & player.energy >= 160'},
		
	--[[
	(debuff.vendetta.up|
	mantle_duration>=gcd.remains+0.2|
	debuff.surge_of_toxins.remains<gcd.remains+0.2|
	energy.deficit<=25+variable.energy_regen_combined)
	]]--
	
	{ 'Fan of Knives', 'toggle(aoe) & player.area(7).enemies >= 3 & player.combopoints <= 4'},
	
	{ 'Mutilate', 'player.combopoints <= 3 & player.buff(Envenom) & target.inmelee'},
	{ 'Mutilate', 'player.spell(Vendetta).cooldown <= 5 & player.combopoints <= 3 & target.inmelee'},
	{ 'Mutilate', 'player.combopoints <= 3 & target.inmelee'},
	
	{ 'Poisoned Knife', 'player.energy >= 160 & player.combopoints <= 4 & target.range >= 10'},
	{ 'Poisoned Knife', 'target.range >= 10 & target.debuff(Agonizing Poison).duration <= 2'},
}

local preCombat = {
	{ 'Tricks of the Trade', '!focus.buff & pull_timer <= 4', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff & pull_timer <= 4', 'tank'},
	{ '#Potion of the Old War', 'pull_timer <= 1.5'},
}

local inCombat = {
	{ 'Rupture', 'player.lastcast(Vanish)'},
	{ '/startattack', '!isattacking'},
	{ keybinds},
	{ survival},
	{ interrupts, 'target.interruptAt(25)'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ 'Rupture', 'player.lastcast(Vanish) & player.combopoints >= 5'},
	{ 'Garrote', 'player.buff(Stealth) & player.combopoints <= 4 & target.debuff.duration <= 5.4'},
	{ singleTarget, '!player.buff(Stealth)'}
}

local outCombat = {
	-- Poisons
	{ 'Deadly Poison', 'player.buff.duration <= 600 & !player.lastcast & !talent(6,1)'},
	{ 'Agonizing Poison', 'player.buff.duration <= 600 & !player.lastcast & talent(6,1)'},
	{ 'Leeching Poison', 'player.buff.duration <= 600 & !player.lastcast & talent(4,1)'},
	{ 'Crippling Poison', 'player.buff.duration <= 600 & !player.lastcast & !talent(4,1)'},
	
	{ 'Rupture', 'player.buff(Vanish) & toggle(cooldowns)'},
	
	{ 'Stealth', '!player.buff & !player.buff(Vanish)'},
	{ 'Garrote', 'player.buff(Stealth) & player.combopoints <= 4 & target.debuff.duration <= 5.4 & target.inmelee & target.enemy'},
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
