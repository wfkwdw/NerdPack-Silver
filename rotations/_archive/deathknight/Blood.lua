local GUI = {
	-- General
	{type = 'header', 		text = 'General', align = 'center'},

	{type = 'ruler'},{type = 'spacer'},
	
	-- Survival
	{type = 'header', 		text = 'Survival', align = 'center'},

	{type = 'ruler'},{type = 'spacer'},
	
	--Cooldowns
	{type = 'header', 		text = 'Cooldowns when toggled on', align = 'center'},
	{type = 'ruler'},{type = 'spacer'},} 

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- Supported Talents')
	print('|cffADFF2F --- WIP')
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local keybinds = {

}

local interrupts = {
	{ 'Mind Freeze'},
}

local preCombat = {

}

local legionEvents = {
	----------------
	---- 5 Mans ----
	----------------
	-- Tank Dummy
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Uber Strike) & !player.lastcast'},
	
	-- Neltharion's Lair --
	{ 'Rune Tap', 'player.buff.duration <= 1 & target.casting(Sunder) & !player.lastcast'},
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Molten Crash) & !player.lastcast'},
	
	-- Black Rook Hold
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Vengeful Shear) & !player.lastcast'},
	
	-- Vault of the Wardens
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Darkstrikes) & !player.lastcast'},
	
	-- Assault on Violet hold
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Doom) & !player.lastcast'},
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Mandible Strike) & !player.lastcast'},
	
	-- Halls of Valor
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Savage Blade) & !player.lastcast'},
	
	-- Maw of Souls
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.casting(Dark Slash) & !player.lastcast'},
	
	-- Karazhan
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & player.debuff(Dent Armor) & !player.lastcast'},
	{ 'Rune Tap', 'player.buff.duration <= 2.5 & target.channeling(Piercing Missiles) & !player.lastcast'},
	
	-----------------
	--- Nighthold ---
	-----------------
	-- Skorpyron
	{ 'Death Strike', 'target.threat == 100 & player.buff(Blood Shield).duration <= 1.5 & target.casting(Arcanoslash) & !player.lastcast'},
	
	-- Trilliax
	{ 'Death Strike', 'player.buff(Blood Shield).duration <= 1.5 & target.casting(Arcane Slash) & !player.lastcast'},

	-- Spellblade
	{ 'Death Strike', 'player.buff(Blood Shield).duration <= 1.5 & target.channeling(Annihilate) & !player.lastcast'},
	
	-- Krosus
	{ 'Death Strike', 'player.buff(Blood Shield).duration <= 1.5 & target.casting(Slam) & !player.lastcast'},
	{ 'Death Strike', 'player.buff(Blood Shield).duration <= 1.5 & target.casting(Orb of Destruction) & !player.lastcast'},
	{ 'Death Strike', 'player.buff(Blood Shield).duration <= 1.5 & player.debuff(Searing Brand).count >= 3 & !player.lastcast'},
}

local survival = {
	{ 'Death Strike', 'player.health <= 80', 'target'},
	{ 'Vampiric Blood', 'player.health <= 40'},
	{ 'Icebound Fortitude', 'player.health <= 20'},
}

local rotation = {
	{ 'Marrowrend', 'player.buff(Bone Shield).duration <= 3', 'target'},
	{ 'Blood Boil', '!debuff(Blood Plague)', 'target'},
	{ 'Death and Decay', 'area(10).enemies < 2 & player.buff(Crimson Scourge) & talent(2,1) || area(10).enemies >= 2 & player.buff(Crimson Scourge)', 'target.ground'},
	{ 'Death Strike', 'deficit < 10', 'target'},
	{ 'Marrowrend', 'player.buff(Bone Shield).count <= 6', 'target'},
	{ 'Death and Decay', 'area(10).enemies < 2 & runes >= 3 & talent(2,1) || area(10).enemies >= 3', 'target.ground'},
	{ 'Heart Strike', 'runes >= 3', 'target'},
	{ 'Death and Decay', 'player.buff(Crimson Scourge)', 'target.ground'},
	{ 'Consumption', nil, 'target'},
	{ 'Blood Boil', nil, 'target'},
}

local inCombat = {
	{ '/startattack', '!isattacking & target.enemy'},
	{ legionEvents},
	{ survival}, 
	{ interrupts, 'target.interruptAt(35)'},
	{ 'Death\'s Caress', '!inmelee & !debuff(Blood Plague)', 'target'},
	{ 'Blood Boil', 'inmelee & !debuff(Blood Plague)', 'enemies'},
	{ '#trinket1', 'target.inmelee'},
	{ '#trinket2', 'target.inmelee'},
	{ rotation, 'target.inmelee'}, 
}

local outCombat = {
	{ keybinds},
	{ preCombat}
}

NeP.CR:Add(250, {
	name = '[Silver] Death Knight - Blood',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})