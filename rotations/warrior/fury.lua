local GUI = {
	-- Sotr
	{type = 'header', text = 'Shield of the Righteous', align = 'center'},
	{type = 'spinner', text = 'Use 2nd Charge', key = 'sotr', default_spin = 75},
	{type = 'ruler'},{type = 'spacer'},
	
	-- Light of the Protector
	{type = 'header', text = 'Light of the Protector', align = 'center'},
	{type = 'spinner', text = 'Light of the Protector', key = 'lotp', default_spin = 65},
	{type = 'ruler'},{type = 'spacer'},
	
	--Cooldowns
	{type = 'header', text = 'Cooldowns when toggled on', align = 'center'},
	{type = 'checkspin', text = 'Use Ardent Defender', key = 'ad', default_check = true, default_spin = 25},
	{type = 'checkspin', text = 'Use Eye of Tyr', key = 'eye', default_check = true, default_spin = 60},
	{type = 'checkspin', text = 'Use Guardian of Ancient Kings', key = 'ak', default_check = true, default_spin = 35},
	{type = 'ruler'},{type = 'spacer'},} 

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSilver Warrior |cffADFF2FFury |r')
	print('|cffADFF2F --- |rMost Talents Supported')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local keybinds = {
	{ 'Heroic Leap', 'keybind(lcontrol)', 'mouseover.ground'}
}

local interrupts = {
	{ 'Pummel'},
}

local utility = {
	{ 'Battle Shout', 'player.buff.duration <= 600'},
}

local cooldowns = {
	{ 'Blood Fury'}, 
	{ 'Recklessness'},
}

local survival = {
	{ 'Victory Rush', 'player.health <= 80', 'target'}, 
	{ 'Enraged Regeneration', 'player.health <= 40'}, 
}

local rotation = {
	{ 'Whirlwind', 'player.area(8).enemies >= 2 & !player.buff(Whirlwind) & toggle(aoe)'},
	{ 'Rampage', 'player.buff(Siegebreaker) || player.rage >= 85 & !talent(5,1) & player.enrage = 0 || player.rage >= 75 & talent(5,1) & player.enrage = 0 || player.enrage > 0 & player.rage >= 95'},
	{ cooldowns, 'toggle(cooldowns) & target.bosscheck >= 1'}, 
	{ 'Siegebreaker', 'player.rage >= 65 & { player.buff(Recklessness) || player.spell(Recklessness).cooldown > 30 & bosscheck >= 1 || bosscheck = 0}', 'target'}, 
	{ 'Execute', 'player.buff(Enrage)'},
	{ 'Bloodthirst', '!player.buff(Enrage)'},
	{ 'Raging Blow', 'player.spell.charges >= 2'},
	{ 'Bloodthirst'}, 
	{ 'Dragon Roar', 'player.buff(Enrage)'}, 
	{ 'Bladestorm', 'player.buff(Enrage)'}, 
	{ 'Raging Blow'}, 
	{ 'Whirlwind'},
}

local inCombat = {
	{ keybinds},
	{ '/startattack', '!isattacking & target.exists'},
	{ interrupts, 'target.interruptAt(75)'},
	{ utility}, 
	{ survival}, 
	{ 'Heroic Throw', 'range > 8', 'target'}, 
	{ rotation},
}

local outCombat = {
	{ keybinds},	
	{ utility}, 
}

NeP.CR:Add(72, {
	name = '[Silver] Warrior - Fury',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad,
 wow_ver = '8.0.1',
 nep_ver = '1.11',
})
