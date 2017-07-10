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
	print('|cffADFF2F --- |rSilver Warrior |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rMost Talents Supported')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local legionEvents = {

}

local interrupts = {
	{ 'Pummel'},
	{ 'Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown > gcd & !prev_gcd(Rebuke)'},
}

local activeMitigation = {
	{ 'Victory Rush', 'player.health <= 70'},
	{ 'Ignore Pain', 'player.buff(Vengeance: Ignore Pain)'},
	{ 'Ignore Pain', 'ignorepain <= { player.health.max * 0.2 }'},
}

local cooldowns = {

}

local rotation = {
	{ 'Shield Slam'},
	{ 'Revenge', 'player.buff(Vengeance: Revenge)'},
	{ 'Thunder Clap', 'range <= 8'},
	{ 'Revenge', 'player.buff(Revenge)'},
	{ 'Devastate'},
}

local inCombat = {
	{ '/targetenemy [dead][noharm]', '{target.dead || !target.exists} & !player.area(40).enemies=0'},
	{ '/startattack', '!isattacking & target.exists'},
	{ target},
	{ interrupts, 'target.interruptAt(50)'},
	{ activeMitigation},
	{ cooldowns, 'toggle(cooldowns) & target.range <= 10'},
	{ rotation, 'target.infront'}
}

local outCombat = {
	{ '#Potion of Prolonged Power', '!player.buff & pull_timer <= 2'},
}

NeP.CR:Add(73, {
	name = '[Silver] Warrior - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
