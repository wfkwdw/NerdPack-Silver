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
	{ '53600', 'player.buff.duration <= 1.5 & player.debuff(Searing Brand).count >= 3 & !player.lastcast'},
}


local interrupts = {

}

local activeMitigation = {
	{ 'Ironskin Brew', 'charges >= 3'},
}

local cooldowns = {
	{ legionEvents},
}

local rotation = {	
	-- AoE
	{ 'Breath of Fire', 'toggle(AoE) & equipped(Sal\'salabim\'s Lost Tunic) & target.range <= 8'}, -- legendary chest (Sal'salabim's Lost Tunic) are equipped
	{ 'Keg Smash', 'toggle(AoE) & player.area(8).enemies >= 2'},
	{ 'Rushing Jade Wind', 'toggle(AoE) & player.area(8).enemies >= 2 & target.range <= 8'},
	{ 'Chi burst', 'toggle(AoE) & talent(1,1) & player.area(8).enemies >= 2'},
	{ 'Breath of Fire', 'toggle(AoE) & player.area(8).enemies >= 2'},
	
	--Solo
	{ 'Keg Smash'},		
	{ 'Blackout Strike', 'target.range <= 5'},
	{ 'Breath of Fire', 'equipped(Sal\'salabim\'s Lost Tunic) & target.range <= 8'},         -- legendary chest (Sal'salabim's Lost Tunic) are equipped								
	{ 'Tiger Palm', 'player.energy >= 65'},
	{ 'Breath of Fire'},									          
	{ 'Rushing Jade Wind'},		
}

local inCombat = {
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

NeP.CR:Add(268, {
	name = '[Silver] Monk - Brewmaster',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
 wow_ver = '7.3.5',
 nep_ver = '1.11',
	load = exeOnLoad
})
