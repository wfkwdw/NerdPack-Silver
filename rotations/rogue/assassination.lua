local GUI = {
	-- Sotr
	{type = 'header', text = 'Shield of the Righteous', align = 'center'},
	{type = 'spinner', text = 'Use 2nd Charge', key = 'sotr', default_spin = 75},
	{type = 'ruler'},{type = 'spacer'},
	
	-- Light of the Protector
	{type = 'header', text = 'Light of the Protector', align = 'center'},
	{type = 'spinner', text = 'Crimson Vial', key = 'cv', default_spin = 65},
	{type = 'ruler'},{type = 'spacer'},
	
	--Cooldowns
	{type = 'header', text = 'Cooldowns when toggled on', align = 'center'},
	{type = 'checkspin', text = 'Use Ardent Defender', key = 'ad', default_check = true, default_spin = 25},
	{type = 'checkspin', text = 'Use Eye of Tyr', key = 'eye', default_check = true, default_spin = 60},
	{type = 'checkspin', text = 'Use Guardian of Ancient Kings', key = 'ak', default_check = true, default_spin = 35},
	{type = 'ruler'},{type = 'spacer'},} 

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- ')
	print('|cffADFF2F --- ')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

end

local target = {
	{{ -- Targeting
		{ '/targetenemy [noexists]', { -- Target an enemy
			'!target.exists',
		}},
	}},
}

local Keybinds = {

}

local interrupts = {
	{ 'Kick'},
	{ 'Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local survival = {
	{ 'Crimson Vial', 'player.health <= UI(cv) & player.energy >= 35'},
}

local cooldowns = {
	{ 'Vendetta', 'player.energy <= 55'},
}

local singleTarget = {
	{ 'Tricks of the Trade', '!tank.buff', 'tank'},
	{ 'Rupture', '!mouseover.debuff & player.combopoints >= 1', 'mouseover'},

	{ 'Rupture', '!target.debuff & player.combopoints >= 1'},
	{ 'Rupture', 'target.debuff.duration <= 7.2 & player.combopoints >= 5'},
	{ 'Garrote', 'target.debuff.duration <= 5.4'},
	{ 'Kingsbane', 'player.lastcast(Envenom)'},
	{ 'Kingsbane', 'player.energy >= 135 & player.combopoints == 4'},
	{ 'Envenom', 'player.combopoints >= 4 & player.energy >= 150'},
	{ 'Envenom', 'player.combopoints >= 4 & target.debuff(Kingsbane)'},
	{ 'Mutilate', 'player.buff(Envenom)'},
	--{ 'Mutilate', 'player.spell(Vendetta).cooldown <= 5'},
	{ 'Mutilate', 'player.energy >= 135 & !player.buff(Envenom) & player.combopoints <= 3'},
}

local inCombat = {
	{'/startattack', '!isattacking'},
	{ target},
	{ Keybinds},
	{ survival},
	{ interrupts, 'target.interruptAt(50)'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ singleTarget, 'target.infront'}
}

local outCombat = {
	{ 'Deadly Poison', 'player.buff.duration <= 600 & !player.lastcast & !talent(6,1)'},
	{ 'Leeching Poison', 'player.buff.duration <= 600 & !player.lastcast'},
	{ 'Agonizing Poison', 'player.buff.duration <= 600 & !player.lastcast & talent(6,1)'},
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(259, {
	name = '[Silver] Rogue - Assassination',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
