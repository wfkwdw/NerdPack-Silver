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
--[[
	NeP.Interface.CreateToggle(
		'AutoTaunt',
		'Interface\\Icons\\spell_nature_shamanrage.png',
		'Auto Taunt',
		'Automatically taunt nearby enemies.')
--]]
end

local target = {
	{{ -- Targeting
		{ '/targetenemy [noexists]', { -- Target an enemy
			'!target.exists',
		}},
	}},
}

local legionEvents = {
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
	{ '53600', 'player.buff.duration & player.debuff(Dent Armor) & !player.lastcast'},
	{ '53600', 'player.buff.duration <= 2.5 & target.channeling(Piercing Missiles) & !player.lastcast'},
	
	
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'}
}

local Interrupts = {
	{'Rebuke'},
	{'Hammer of Justice', 'spell(Rebuke).cooldown>gcd'},
	{'Arcane Torrent', 'target.range<=8&spell(Rebuke).cooldown>gcd&!prev_gcd(Rebuke)'},
}

local activeMitigation = {
	-- Shield of the Righteous
	{ "53600", { -- SotR
		'player.spell(Shield of the Righteous).charges = 3',
		'!player.buff',
		"target.range <= 8",
		'target.threat == 100',
		'!talent(7,2)'
	}},
	{ "53600", { -- SotR
		'player.spell(Shield of the Righteous).charges = 3',
		'!player.buff',
		"target.range <= 8",
		'target.threat == 100',
		'talent(7,2)',
		'!player.spell(Seraphim).cooldown = 0',
	}},
	{ '53600', { 
		'!player.buff', 
		'player.health <= UI(sotr)', 
		'player.spell.charges >= 2',
		"target.range <= 8",
		'target.threat == 100'
	}},
	
	-- Light of the Protector
	{ 'Light of the Protector', 'player.health <= UI(lotp)'},
}

local cooldowns = {
	{ legionEvents},
	
	{ 'Eye of Tyr', 'UI(eye_check) & lowest.health <= UI(eye_spin) & !player.buff(Ardent Defender) & target.range <= 8 & !player.buff(Guardian of Ancient Kings)'}, 
	{ 'Ardent Defender', 'UI(ad_check) & lowest.health <= UI(ad_spin) & !target.debuff(Eye of Tyr) & !player.buff(Guardian of Ancient Kings)'},
	{ 'Guardian of Ancient Kings', 'UI(ak_check) & lowest.health <= UI(ak_spin) & !target.debuff(Eye of Tyr) & !player.buff(Ardent Defender)'},

	{ 'Seraphim', 'player.spell(Shield of the Righteous).charges > 2'},
	--actions.prot+=/avenging_wrath,if=!talent.seraphim.enabled
	{'Avenging Wrath', '!talent(7,2)'},
	--actions.prot+=/avenging_wrath,if=talent.seraphim.enabled&buff.seraphim.up
	{'Avenging Wrath', 'talent(7,2)&player.buff(Seraphim)'},

	--actions.prot+=/lay_on_hands,if=health.pct<15
	{'Lay on Hands', 'player.health<15'},
}

local singleTarget = {
	{ '31925', 'talent(2,3)'},
	{ "20271", { -- Judgement
		'target.range <= 30'
	}},
	{ '204019', { -- Blessed Hammer
		'target.range <= 8',
		'target.enemy',
		'!player.lastcast(204019)',
		'target.debuff(204301)'
	}},
	{ "26573", { -- Consecration
		"target.range <= 8",
		"target.enemy",
		'!player.buff',
		'!player.moving'
	}},
	{ '31935'}, -- Avengers Shield
	{ '204019', { -- Blessed Hammer
		'target.range <= 8',
		'target.enemy'
	}},
	{ '/startattack'},
}

local inCombat = {
	{'/startattack', '!isattacking'},
	{ target},
	{ Keybinds},
	--{Survival, 'player.health < 100'},
	{ Interrupts, 'target.interruptAt(50)'},
	{ activeMitigation},
	{ cooldowns, 'toggle(cooldowns)'},
	{ singleTarget, 'target.infront'}
}

local outCombat = {
	{Keybinds},
	{PreCombat}
}

NeP.CR:Add(66, {
	name = '[Silver] Paladin - Protection',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
