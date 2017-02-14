local GUI = {
	{type = 'header', 	text = 'Generic', align = 'center'},
	{type = 'spinner', 	text = 'DPS while lowest health%', 			key = 'G_DPS', 	default = 70},
	{type = 'spinner', 	text = 'Critical health%', 					key = 'G_CHP', 	default = 30},
	{type = 'ruler'},{type = 'spacer'},
	
	--------------------------------
	-- Toggles
	--------------------------------
	
	--------------------------------
	-- TANK
	--------------------------------
	{type = 'header', 	text = 'Tank', align = 'center'},
	{type = 'spinner', 	text = 'Riptide (Health %)', 					key = 'T_RT', 	default = 90},
	{type = 'spinner', 	text = 'Healing Surge (Health %)', 				key = 'T_HS', 	default = 75},
	{type = 'spinner', 	text = 'Healing Wave (Health %)', 				key = 'T_HW', 	default = 90},
	{type = 'ruler'},{type = 'spacer'},
	
	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Lowest', align = 'center'},
	{type = 'spinner', 	text = 'Riptide (Health %)', 					key = 'L_RT', 	default = 90},
	{type = 'spinner', 	text = 'Healing Surge (Health %)', 				key = 'L_HS', 	default = 70},
	{type = 'spinner', 	text = 'Healing Wave (Health %)', 				key = 'L_HW', 	default = 90},	
}

local exeOnLoad = function()

	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rPALADIN |cffADFF2FHoly |r')
	print('|cffADFF2F --- |rRecommended Talents: 1/1 - 2/3 - 3/3 - 4/3 - 5/1 - 6/2 - 7/2')
	print('|cffADFF2F ----------------------------------------------------------------------|r')

	NeP.Interface:AddToggle({
		key = 'dps',
		name = 'DPS',
		text = 'DPS while healing',
		icon = 'Interface\\Icons\\spell_holy_crusaderstrike',
	})
	NeP.Interface:AddToggle({
		key = 'disp',
		name = 'Dispell',
		text = 'ON/OFF Dispel All',
		icon = 'Interface\\ICONS\\spell_holy_purify', --toggle(disp)
	})
end

local utility = {

}

-- Cast that should be interrupted
local interrupts = {

}

local survival = {

}

local topUp = { 

}

local DPS = {

}

local keybinds = {
	{ 'Healing Rain', 'keybind(lcontrol)', 'cursor.ground'},
}

local healing = {	
	-- AoE
	{ 'Healing Stream Totem', 'lowest.area(40,90).heal >= 3'},
	{ 'Chain Heal', 'lowest.area(30,80).heal >= 3'},
	
	{ 'Riptide', 'tank.health <= UI(T_RT) & !tank.buff', 'tank'},
	{ 'Riptide', 'lnbuff(Riptide).health <= UI(L_RT)', 'lnbuff(Riptide)'},
	
	{ 'Healing Surge', 'tank.health <= UI(T_HS)', 'tank'},
	{ 'Healing Surge', 'lowest.health <= UI(L_HS)', 'lowest'},
	
	{ 'Healing Wave', 'tank.health <= UI(T_HW)', 'tank'},
	{ 'Healing Wave', 'lowest.health <= UI(L_HW)', 'lowest'},
}

local emergency = {
	{ '!Holy Shock', '!player.casting(200652)', 'lowest'},
	{ '!Flash of Light', '!player.moving & !player.casting(200652)', 'lowest'},
	{ '!Light of the Martyr', '!player.casting(Flash of Light) & !player.casting(200652)', 'lowest'},
}

local cooldowns = {
	{ 'Lay on Hands', 'lowest.health <= UI(L_LoH) & !lowest.debuff(Forbearance).any', 'lowest'},
	{ 'Aura Mastery', 'player.area(40,40).heal >= 4'},
	{ 'Avenging Wrath', 'player.area(35,65).heal >= 4'},
	{ 'Holy Avenger', 'player.area(40,75).heal >= 3'},
	
	{ 'Blessing of Sacrifice', 'tank.health <= UI(T_BoS)', 'tank'}, 
	{ 'Blessing of Sacrifice', 'tank2.health <= UI(T_BoS)', 'tank2'}, 
	
	--{ '#trinket2', 'player.area(40,75).heal >= 3'},
	
	{ 'Rule of Law', 'lowest.range >= 15 & lowest.health <= UI(L_FoL) & !player.buff'},
}

local moving = {

}

local inCombat = {
	{ keybinds},
	--{ topUp, 'keybind(lcontrol)'},
	{ utility}, -- Raid utility!
	{ survival}, 
	{ interrupts, 'target.interruptAt(35)'},
	{ '%dispelall', 'toggle(disp) & spell(Purify Spirit).cooldown = 0'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ emergency, 'lowest.health <= UI(G_CHP) & !player.casting(200652)'},
	{ tank},
	{ DPS, 'toggle(dps) & target.enemy & target.infront & lowest.health >= UI(G_DPS)'},
	{ moving, 'player.moving'},
	{ healing, '!player.moving'},
	{ DPS, 'toggle(dps) & target.enemy & target.infront'},
}

local outCombat = {
	{ keybinds},
}

NeP.CR:Add(264, {
	name = '[Silver] Shaman - Restoration',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})