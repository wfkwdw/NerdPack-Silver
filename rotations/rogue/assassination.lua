local GUI = {
	-- Sotr
	{type = 'header', text = 'General', align = 'center'},
	{type = 'spinner', text = 'Pool Energy', key = 'pool', default_spin = 100},
	{type = 'ruler'},{type = 'spacer'},
	
	-- Survival
	{type = 'header', text = 'Survival', align = 'center'},
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
}

local cooldowns = {
	{ 'Vendetta', 'player.energy <= 100'},
	{ 'Vanish', 'player.combopoints >= 5 & target.debuff(Surge of Toxins).duration <= 0.5'},
}

local singleTarget = {
	{ 'Tricks of the Trade', '!focus.buff', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff', 'tank'},

	{ 'Rupture', 'player.lastcast(Vanish)'},
	{ 'Rupture', '!target.debuff & player.combopoints >= 1 & player.spell(Vanish).cooldown'},
	{ 'Rupture', 'target.debuff.duration <= 7.2 & player.combopoints >= 5 & target.debuff(Surge of Toxins).duration <= 0.5 & player.spell(Vanish).cooldown'},
	
	-- Multi DoT
	{ 'Rupture', 'boss1.enemy & boss1.inmelee & !boss1.debuff.duration <= 7.2 & player.combopoints >= 1', 'boss1'},
	{ 'Rupture', 'boss2.enemy & boss2.inmelee & !boss2.debuff.debuff.duration <= 7.2 & player.combopoints >= 1', 'boss2'},
	{ 'Rupture', 'boss3.enemy & boss3.inmelee & !boss3.debuff.debuff.duration <= 7.2 & player.combopoints >= 1', 'boss3'},
	{ 'Rupture', 'mouseover.enemy & mouseover.inmelee & !mouseover.debuff.duration <= 7.2 & player.combopoints >= 1', 'mouseover'},
	
	{ 'Garrote', 'target.debuff.duration <= 5.4 & player.combopoints <= 4'},
	
	-- Use Mutilate till 4/5 combopoints for rupture
	{ 'Mutilate', '!target.debuff(Rupture) & player.combopoints <= 4'},
	
	{ 'Kingsbane', 'player.lastcast(Envenom)'},
	{ 'Kingsbane', 'player.energy >= 135 & player.combopoints >= 4'},
	
	{ 'Envenom', 'player.combopoints >= 3 & target.debuff(Surge of Toxins).duration <= 0.5 & target.debuff(Vendetta)'},
	{ 'Envenom', 'player.combopoints >= 4 & player.energy >= 150 & target.debuff(Surge of Toxins).duration <= 0.5'},
	{ 'Envenom', 'player.combopoints >= 4 & target.debuff(Kingsbane) & target.debuff(Surge of Toxins).duration <= 0.5'},
	{ 'Envenom', 'player.combopoints >= 4 & player.energy >= 160'},
	
	{ 'Fan of Knives', 'toggle(aoe) & player.area(7).enemies >= 3 & player.combopoints <= 4'},
	
	{ 'Mutilate', 'player.buff(Envenom)'},
	{ 'Mutilate', 'player.spell(Vendetta).cooldown <= 5 & player.combopoints <= 3'},
	{ 'Mutilate', 'player.energy >= 130 & !player.buff(Envenom) & player.combopoints <= 3'},
}

local preCombat = {
	{ 'Tricks of the Trade', '!focus.buff & pull_timer <= 4', 'focus'},
	{ 'Tricks of the Trade', '!tank.buff & pull_timer <= 4', 'tank'},
	{ '#Potion of the Old War', 'pull_timer <= 1.5'},
}

local inCombat = {
	{ '/startattack', '!isattacking'},
	{ keybinds},
	{ survival},
	{ interrupts, 'target.interruptAt(20)'},
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
	
	{ 'Rupture', 'player.lastcast(Vanish) & player.combopoints >= 5'},
	
	{ 'Stealth', '!player.buff & !player.lastcast(Vanish)'},
	{ 'Garrote', 'player.buff(Stealth) & player.combopoints <= 4 & target.debuff.duration <= 5.4 & target.inmelee'},
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
