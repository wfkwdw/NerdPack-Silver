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
	print('|cffADFF2F --- |rPALADIN |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/3 - 4/1 - 5/2 - 6/2 - 7/3')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local target = {
	{ '/targetenemy [noexists]', '!target.exists'},
}

local legionEvents = {
	----------------
	---- 5 Mans ----
	----------------
	-- Tank Dummy
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Uber Strike) & !player.lastcast'},
	
	-- Neltharion's Lair --
	{ '53600', 'player.buff.duration <= 1 & target.casting(Sunder) & !player.lastcast'},
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Molten Crash) & !player.lastcast'},
	
	-- Black Rook Hold
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Vengeful Shear) & !player.lastcast'},
	
	-- Vault of the Wardens
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Darkstrikes) & !player.lastcast'},
	
	-- Assault on Violet hold
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Doom) & !player.lastcast'},
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Mandible Strike) & !player.lastcast'},
	
	-- Halls of Valor
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Savage Blade) & !player.lastcast'},
	
	-- Maw of Souls
	{ '53600', 'player.buff.duration <= 2.5 & target.casting(Dark Slash) & !player.lastcast'},
	
	-- Karazhan
	{ '53600', 'player.buff.duration <= 2.5 & player.debuff(Dent Armor) & !player.lastcast'},
	{ '53600', 'player.buff.duration <= 2.5 & target.channeling(Piercing Missiles) & !player.lastcast'},
	
	-----------------
	--- Nighthold ---
	-----------------
	-- Skorpyron
	{ '53600', 'target.threat == 100 & player.buff.duration <= 1.5 & target.casting(Arcanoslash) & !player.lastcast'},
	
	-- Trilliax
	{ '53600', 'player.buff.duration <= 1.5 & target.casting(Arcane Slash) & !player.lastcast'},

	-- Spellblade
	{ '53600', 'player.buff.duration <= 1.5 & target.channeling(Annihilate) & !player.lastcast'},
	
	-- Krosus
	{ '53600', 'player.buff.duration <= 1.5 & target.casting(Slam) & !player.lastcast'},
	{ '53600', 'player.buff.duration <= 1.5 & target.casting(Orb of Destruction) & !player.lastcast'},
}


local interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'spell(Rebuke).cooldown > gcd'},
	{'Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local activeMitigation = {
	-- Shield of the Righteous
	{ 'Shield of the Righteous', 'player.spell(Shield of the Righteous).charges = 3 & !player.buff & target.range <= 8 & target.threat == 100 & !talent(7,2)'},
	{ 'Shield of the Righteous', 'player.spell(Shield of the Righteous).charges = 3 & !player.buff & target.range <= 8 & target.threat == 100 & talent(7,2) & !player.spell(Seraphim).cooldown = 0'},
	{ 'Shield of the Righteous', '!player.buff & player.health <= UI(sotr) & player.spell.charges >= 2 & target.range <= 8 & target.threat == 100'},
	
	-- Light of the Protector
	{ 'Light of the Protector', 'player.health <= UI(lotp)'},
	{ 'Light of the Protector', 'lowest.health <= UI(lotp)', 'lowest'},
}

local cooldowns = {
	{ legionEvents},
	
	{ 'Bastion of Light', 'player.spell(Shield of the Righteous).charges < 1'},
	
	-- All health based. Uncheck in UI to use only manually
	{ 'Eye of Tyr', 'UI(eye_check) & player.health <= UI(eye_spin) & !player.buff(Ardent Defender) & target.range <= 8 & !player.buff(Guardian of Ancient Kings)'}, 
	{ 'Ardent Defender', 'UI(ad_check) & player.health <= UI(ad_spin) & !target.debuff(Eye of Tyr) & !player.buff(Guardian of Ancient Kings)'},
	{ 'Guardian of Ancient Kings', 'UI(ak_check) & player.health <= UI(ak_spin) & !target.debuff(Eye of Tyr) & !player.buff(Ardent Defender)'},

	{ 'Seraphim', 'player.spell(Shield of the Righteous).charges > 2'},
	
	{ 'Avenging Wrath', '!talent(7,2)'},
	{ 'Avenging Wrath', 'talent(7,2) & player.buff(Seraphim)'},

	-- Add UI toggle for LoH
	{ 'Lay on Hands', 'player.health < 15'},
	{ 'Lay on Hands', 'lowest.health < 15'},
	
	-- Add UI toggle for trinket
	{ '#trinket2', 'player.health <= 75'},
}

local rotation = {
	{ 'Avenger\'s Shield', 'talent(2,3) & player.spell(Judgment).charges < 1'},
	{ 'Avenger\'s Shield', 'target.area(10).enemies >= 2'},
	{ 'Judgment'},
	{ 'Blessed Hammer', 'talent(1,2) & player.area(12).enemies >= 1 & !player.lastcast' }, 
	{ 'Consecration', 'player.area(8).enemies >= 1'},
	{ 'Avenger\'s Shield'},
	{ 'Hammer of the Righteous', '!talent(1,2)'},
}

local inCombat = {
	{'/startattack', '!isattacking'},
	--{ target},
	{ interrupts, 'target.interruptAt(50)'},
	{ activeMitigation},
	{ cooldowns, 'toggle(cooldowns)'},
	{ rotation, 'target.infront'}
}

local outCombat = {

}

NeP.CR:Add(66, {
	name = '[Silver] Paladin - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
