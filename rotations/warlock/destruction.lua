local GUI = {
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'MultiDot (Bosses)',					key = 'MDb', 	default = true},
	{type = 'checkbox',	text = 'MultiDot (Mobs)',					key = 'MDm', 	default = true},
	{type = 'checkbox',	text = 'Burning Rush',						key = 'BR', 	default = true},
}

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local keybinds = {
	-- Pause
	{ '%pause', 'keybind(alt)'},
}

local survival = {
	--{ '#Healthstone', 'health <= 40', 'player'},
	{ 'Unending Resolve', 'health <= 20', 'player'},
	{ 'Drain Life', 'player.health <= 40 & !player.moving', 'target'},
}

local petCare = {
	
	{ 'Health Funnel', 'health <= 30 & alive & !player.moving', 'pet'}, 
} 

local singleTarget = {
	{ 'Immolate', 'debuff.duration <= 5.4 & !player.moving & !player.lastcast', 'target'},
	{ 'Chaos Bolt', 'player.shards >= 5 & !player.moving & !player.lastcast', 'target'},
	{ 'Conflagrate', 'player.spell.charges >= 2', 'target'},
	{ 'Channel Demonfire', '!player.moving', 'target'},
	{ 'Chaos Bolt', 'debuff(Eradication).duration <= 2 & !player.moving & talent(1,2)', 'target'},
	{ 'Cataclysm', '!player.moving', 'target.ground'}, 
	{ 'Conflagrate', nil, 'target'},
	{ 'Incinerate', '!player.moving', 'target'},
}

local multiTarget = {
	{ 'Immolate', 'debuff.duration <= 5.4 & !player.moving & !player.lastcast', 'target'},
	{ 'Rain of Fire', 'area(10).enemies >= 6', 'target.ground'},
	{ 'Chaos Bolt', 'player.shards >= 5 & !player.moving', 'target'},
	{ 'Havoc', '!debuff(Immolate) & combat', { 'focus', 'enemies'}},
	{ 'Cataclysm', '!player.moving', 'target.ground'}, 
	{ 'Channel Demonfire', '!player.moving', 'target'},
	{ 'Chaos Bolt', 'player.spell(Havoc).cooldown >= 20 & player.shards >= 2', 'target'},
	{ 'Conflagrate', nil, 'target'},
	{ 'Incinerate', '!player.moving', 'target'},
}

local inCombat = {
	{ survival},
	{ petCare},
	{ interrupts, 'target.interruptAt(50)'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ multiTarget, 'player.area(40).enemies >= 2'},
	{ singleTarget, 'player.area(40).enemies < 2'},
}

local outCombat = {
	{ keybinds},
	{ petCare},
}

NeP.CR:Add(267, {
      name = '[Silver] Warlock - Destruction',
        ic = inCombat,
       ooc = outCombat,
       gui = GUI,
      load = exeOnLoad,
   wow_ver = '8.0.1',
   nep_ver = '1.11',
})