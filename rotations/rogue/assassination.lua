local GUI = {
	-- General
	{type = 'header', 		text = 'General', align = 'center'},
	{type = 'checkbox',		text = 'Multi-Dot',						key = 'multi', 	default = true},
	{type = 'checkbox',		text = 'Sinister Circulation',			key = 'sin', 	default = true},
	{type = 'checkbox',		text = 'T19 4 Piece',					key = 't19', 	default = true},
	{type = 'checkbox',		text = 'Mantle of the Master Assassin',	key = 'mantle', 	default = true},
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
	{ 'Evasion', 'player.threat >= 100'},
		
	-- Health Pot
	{ '#Ancient Healing Potion', 'UI(hp_check) & player.health <= UI(hp_spin)'},
	
	-- Healthstones
	{ '#Healthstone', 'UI(hs_check) & player.health <= UI(hs_spin)'},
	
	-- Tich
	{ 'Feint', '!player.buff.duration & player.debuff(Carrion Plague).count >= 2'},
}

local cooldowns = {
	
	{ 'Vendetta', 'player.energy <= 50 & UI(ven)'},
	{ 'Vanish', '!player.buff(Stealth) & player.combopoints >= 4 & UI(van)'},
	-- Shouldnt use this if mob isnt a boss
	{ '#Potion of the Old War', 'UI(ow) & player.hashero'},
	{ '#Potion of the Old War', 'UI(ow) & target.ttd <= 25'},
	{ '#Potion of the Old War', 'UI(ow) & target.debuff(Vendetta) & player.spell(Vanish).cooldown <= 5 & player.debuff(Exhaustion)'},
	
	--if=buff.bloodlust.react|target.time_to_die<=25|debuff.vendetta.up&cooldown.vanish.remains<5
}


local rotation = {
	{ survival},	
	{ 'Tricks of the Trade', '!focus.buff & !focus.enemy', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff', 'tank'},
	
	-- Rupture
	{ 'Rupture', 'player.buff(Vanish) & toggle(cooldowns)'},
	{ 'Rupture', 'target.debuff.duration <= 7.2 & player.combopoints >= 4 & player.spell(Vanish).cooldown & target.ttd >= 6'},
	
	-- Multi DoT Rupture
	{ 'Rupture', 'boss1.enemy & boss1.inmelee & boss1.debuff.duration <= 7.2 & player.combopoints >= 4 & UI(multi)', 'boss1'},
	{ 'Rupture', 'boss2.enemy & boss2.inmelee & boss2.debuff.debuff.duration <= 7.2 & player.combopoints >= 4 & UI(multi)', 'boss2'},
	{ 'Rupture', 'boss3.enemy & boss3.inmelee & boss3.debuff.debuff.duration <= 7.2 & player.combopoints >= 4 & UI(multi)', 'boss3'},
	{ 'Rupture', 'focus.enemy & focus.inmelee & focus.debuff.duration <= 7.2 & player.combopoints >= 4 & focus.enemy & UI(multi)', 'focus'},
	{ 'Rupture', 'mouseover.enemy & mouseover.inmelee & mouseover.debuff.duration <= 7.2 & player.combopoints >= 4 & UI(multi)', 'mouseover'},
	
	{ 'Garrote', 'target.debuff.duration <= 5.4 & player.combopoints <= 4 & target.inmelee'},
	
	-- Use Mutilate till 4/5 combopoints for rupture
	{ 'Mutilate', '!target.debuff(Rupture) & player.combopoints <= 3 & target.inmelee'},
	
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & target.debuff(Vendetta) & target.debuff(Surge of Toxins) & target.ttd >= 10'},
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & player.spell(Vendetta).cooldown <= 5.8 & target.ttd >= 10'},
	{ 'Kingsbane', '!talent(6,3) & player.buff(Envenom) & player.spell(Vendetta).cooldown >= 10 & target.ttd >= 10'},
	
	{ 'Envenom', 'player.combopoints >= 3 & target.debuff(Surge of Toxins).duration <= 0.5 & target.debuff(Vendetta)'},
	{ 'Envenom', 'player.combopoints >= 4 & target.debuff(Vendetta)'},
	{ 'Envenom', 'player.combopoints >= 4 & target.debuff(Surge of Toxins).duration <= 0.5'},
	{ 'Envenom', 'player.combopoints >= 4 & player.energy >= 160'},
	
	{ 'Fan of Knives', 'toggle(aoe) & player.area(10).enemies >= 3 & player.combopoints <= 4'},
	
	{ 'Mutilate', 'player.combopoints <= 3 & player.buff(Envenom) & target.inmelee'},
	{ 'Mutilate', 'player.spell(Vendetta).cooldown <= 5 & player.combopoints <= 3 & target.inmelee'},
	{ 'Mutilate', 'player.combopoints <= 3 & target.inmelee'},
	
	{ 'Poisoned Knife', 'player.energy >= 160 & player.combopoints <= 4 & target.range >= 10'},
	{ 'Poisoned Knife', 'target.range >= 10 & target.debuff(Agonizing Poison).duration <= 2'},
}

local preCombat = {
	{ 'Tricks of the Trade', '!focus.buff & pull_timer <= 4', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff & pull_timer <= 4', 'tank'},
	{ '#Potion of the Old War', '!player.buff & pull_timer <= 2 & UI(ow)'},
}

local inCombat = {
	{ 'Rupture', 'player.lastcast(Vanish)'},
	{ '/startattack', '!isattacking'},
	{ keybinds},
	{ interrupts, 'target.interruptAt(35)'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ 'Rupture', 'player.lastcast(Vanish) & player.combopoints >= 5'},
	{ 'Garrote', 'player.buff(Stealth) & player.combopoints <= 4 & target.debuff.duration <= 5.4'},
	{ rotation, '!player.buff(Stealth)'}
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
