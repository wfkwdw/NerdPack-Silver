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

}

local singleTarget = {
	{ survival},
	--Maintain the Symbols of Death Icon Symbols of Death buff.
	{ 'Symbols of Death', 'target.debuff.duration <= 10.5'},
	--Maintain Nightblade Icon Nightblade.
	{ 'Nightblade', 'target.debuff.duration <= 4.8 & player.combopoints >= 4'},
	--Activate Shadow Blades Icon Shadow Blades if available.
	
	--Enter Shadow Dance Icon Shadow Dance if you have 3 charges, or there is less than 30 seconds remaining before you get your third charge.
	{ 'Shadow Dance', 'player.spell.charges = 3 & !player.buff(Subterfuge)'},
	{ 'Shadow Dance', 'player.spell.charges = 2 & player.spell.cooldown <= 30 & !player.buff(Subterfuge)'},
	--Shadow Dance Icon Shadow Dance should be activated as close to Energy cap as possible (70 with Master of Shadows Icon Master of Shadows).
	--If talented into Premeditation Icon Premeditation you should aim to enter Shadow Dance Icon Shadow Dance with 1 Combo Point (3 Combo Points without Premeditation Icon Premeditation, and 6-7 Combo Points with Anticipation Icon Anticipation).
	--Use Shadowstrike Icon Shadowstrike as long you are Stealthed and have less than 5 combo points (7 with Anticipation Icon Anticipation).
	--Activate Vanish Icon Vanish when available (see Shadow Blades Icon Shadow Blades rules directly above).
	--Cast Goremaw's Bite Icon Goremaw's Bite on cooldown.
	{ 'Goremaw\'s Bite', 'player.combopoints <= 3'},
	--Use Eviscerate Icon Eviscerate to spend Combo Points.
	{ 'Eviscerate', 'player.combopoints >= 5'},
	{ 'Shadowstrike', 'player.combopoints <= 5'},
	--Cast Backstab Icon Backstab to generate Combo Points.
	{ 'Backstab', 'player.combopoints <= 5 & !player.buff(Shadow Dance) & !player.buff(Vanish) & !player.buff(Stealth)'},


}

local preCombat = {
	{ 'Tricks of the Trade', '!focus.buff & pull_timer <= 4', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff & pull_timer <= 4', 'tank'},
	{ '#Potion of the Old War', '!player.buff & pull_timer <= 2 & UI(ow)'},
	{ 'Shadowstep', 'pull_timer <= 0'},
}

local inCombat = {
	{ '/startattack', '!isattacking'},
	{ keybinds},
	{ interrupts, 'target.interruptAt(35)'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ singleTarget, '!player.buff(Stealth)'}
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
