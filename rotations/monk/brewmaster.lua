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
	print('|cffADFF2F --- |rSilver Paladin |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rMost Talents Supported')
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
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Uber Strike) & !player.lastcast'},
	
	-- Neltharion's Lair --
	{ 'Ironskin Brew', 'player.buff.duration <= 1 & target.casting(Sunder) & !player.lastcast'},
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Molten Crash) & !player.lastcast'},
	
	-- Black Rook Hold
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Vengeful Shear) & !player.lastcast'},
	
	-- Vault of the Wardens
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Darkstrikes) & !player.lastcast'},
	
	-- Assault on Violet hold
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Doom) & !player.lastcast'},
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Mandible Strike) & !player.lastcast'},
	
	-- Halls of Valor
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Savage Blade) & !player.lastcast'},
	
	-- Maw of Souls
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.casting(Dark Slash) & !player.lastcast'},
	
	-- Karazhan
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & player.debuff(Dent Armor) & !player.lastcast'},
	{ 'Ironskin Brew', 'player.buff.duration <= 2.5 & target.channeling(Piercing Missiles) & !player.lastcast'},
	
	-----------------
	--- Nighthold ---
	-----------------
	-- Skorpyron
	{ 'Ironskin Brew', 'target.threat == 100 & player.buff.duration <= 1.5 & target.casting(Arcanoslash) & !player.lastcast'},
	
	-- Trilliax
	{ 'Ironskin Brew', 'player.buff.duration <= 1.5 & target.casting(Arcane Slash) & !player.lastcast'},

	-- Spellblade
	{ 'Ironskin Brew', 'player.buff.duration <= 1.5 & target.channeling(Annihilate) & !player.lastcast'},
	
	-- Krosus
	{ 'Ironskin Brew', 'player.buff.duration <= 1.5 & target.casting(Slam) & !player.lastcast'},
	{ 'Ironskin Brew', 'player.buff.duration <= 1.5 & target.casting(Orb of Destruction) & !player.lastcast'},
}


local interrupts = {
	{ 'Rebuke'},
	{ 'Hammer of Justice', 'spell(Rebuke).cooldown > gcd'},
	{ 'Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local activeMitigation = {
	-- Ironskin Brew
	{ 'Ironskin Brew', 'player.spell(Ironskin Brew).charges = 3 & !player.buff & target.range <= 8 & target.threat == 100'},
	
	-- Purifying Brew
	{ 'Purifying Brew', 'player.buff(Heavy Stagger) & player.spell(Purifying Brew).charges >= 2 & !player.buff & target.range <= 8 & target.threat == 100'},
	
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
	{ 'Keg Smash', 'player.lastcast(Blackout Strike) & talent(7,2)'},
	{ 'Breath of Fire', 'player.lastcast(Blackout Strike) & talent(7,2) & target.debuff(Keg Smash)'},
	{ 'Tiger Palm', 'player.lastcast(Blackout Strike) & talent(7,2)'},

	{ 'Keg Smash'},
	{ 'Tiger Palm', 'player.energy >= 65'},
	{ 'Blackout Strike'},
	{ 'Rushing Jade Wind'},
	{ 'Breath of Fire', 'target.debuff(Keg Smash)'},
}

local inCombat = {
	{'/startattack', '!isattacking'},
	--{ target},
	{ interrupts, 'target.interruptAt(50)'},
	{ activeMitigation},
	--{ cooldowns, 'toggle(cooldowns)'},
	{ rotation, 'target.infront'}
}

local outCombat = {

}

NeP.CR:Add(268, {
	name = '[Silver] Monk - Brewmaster',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
