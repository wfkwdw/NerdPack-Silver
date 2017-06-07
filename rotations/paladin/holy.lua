--[[
	TO DO:
	Add Nighthold encounter support
	Add mythic 5 man utility
	Add support for all talents
--]]

local GUI = {
	{type = 'header', 	text = 'Generic', align = 'center'},
	{type = 'spinner', 	text = 'DPS while lowest health%', 				key = 'G_DPS', 	default = 70},
	{type = 'spinner', 	text = 'Critical health%', 						key = 'G_CHP', 	default = 30},
	{type = 'spinner', 	text = 'Mana Restore', 							key = 'P_MR', 	default = 20},
	{type = 'checkbox',	text = 'Offensive Holy Shock',					key = 'O_HS', 	default = false},
	{type = 'ruler'}, {type = 'spacer'},
	
	--------------------------------
	-- Toggles
	--------------------------------
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'Avenging Wrath',						key = 'AW', 	default = false},
	{type = 'checkbox',	text = 'Aura Mastery',							key = 'AM', 	default = false},
	{type = 'checkbox',	text = 'Holy Avenger',							key = 'HA', 	default = false},
	{type = 'checkbox',	text = 'Lay on Hands',							key = 'LoH', 	default = false},
	{type = 'checkbox',	text = 'Encounter Support',						key = 'ENC', 	default = true},
	{type = 'checkspin',text = 'Healing Potion',						key = 'P_HP', 	default = false},
	{type = 'checkspin',text = 'Mana Potion',							key = 'P_MP', 	default = false},
	{type = 'checkbox', text = 'Auto Ress out of combat', 				key = 'rezz', 	default = false},
	{type = 'ruler'}, {type = 'spacer'},
		
	--------------------------------
	-- TANK
	--------------------------------
	{type = 'header', 	text = 'Tank', align = 'center'},											
	{type = 'spinner', 	text = 'Blessing of Sacrifice (Health %)', 		key = 'T_BoS', 	default = 30},	
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 		key = 'T_LotM', default = 35},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 				key = 'T_HS', 	default = 90},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 			key = 'T_FoL', 	default = 75},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 				key = 'T_HL', 	default = 90},
	{type = 'ruler'}, {type = 'spacer'},
	
	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Lowest', align = 'center'},
	{type = 'spinner', 	text = 'Lay on Hands (Health %)', 				key = 'L_LoH', 	default = 10},
	{type = 'spinner', 	text = 'Holy Shock (Health %)', 				key = 'L_HS', 	default = 90},
	{type = 'spinner', 	text = 'Light of the Martyr (Health %)', 		key = 'L_LotM', default = 40},
	{type = 'spinner', 	text = 'Light of the Martyr moving (Health %)', key = 'L_LotMm',default = 65},
	{type = 'spinner', 	text = 'Flash of Light (Health %)', 			key = 'L_FoL', 	default = 70},
	{type = 'spinner', 	text = 'Holy Light (Health %)', 				key = 'L_HL', 	default = 90},
}

local exeOnLoad = function()
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
		icon = 'Interface\\ICONS\\spell_holy_purify', 
	})
end

-- Cast that should be interrupted
local interrupts = {
	{ 'Hammer of Justice', nil, 'target'},
	{ 'Blinding Light', 'target.range <= 7' },
}

local survival = {
	{ '#127834', 'UI(P_HP_check) & player.health <= UI(P_HP_spin)'}, -- Health Pot
	{ '#127835', 'UI(P_MP_check) & player.mana <= UI(P_MP_spin)'}, -- Mana Pot
	{ 'Divine Protection', 'player.buff(Blessing of Sacrifice)'},
}

local topUp = { 
	{ 'Holy Shock', nil, 'mouseover'},
	{ 'Flash of Light', nil, 'mouseover'},
}

local oocTopUp = {
	{ 'Light of Dawn', 'area(15,90).heal.infront >= 3 & player.buff(Rule of Law)'},
	{ 'Light of Dawn', 'area(15,90).heal.infront >= 3'},
	{ 'Light of Dawn', 'player.buff(Divine Purpose)'},
	{ 'Holy Shock', 'lowestp.health < 90', 'lowestp'},
	{ 'Holy Light', 'lowestp.health < 90 & !player.moving', 'lowestp'},
}

local DPS = {
	{ '/startattack', '!isattacking'},
	{ 'Consecration', 'target.range <= 6 & target.enemy & !player.moving'},
	{ 'Blinding Light', 'player.area(8).enemies >= 3'},
	{ 'Holy Shock', 'UI(O_HS)', 'target'},
	{ 'Holy Prism', nil, 'target'},
	{ 'Judgment'},
	{ 'Crusader Strike', 'target.range <= 8'},
}

local tank = {
	{{
		{ 'Beacon of Light', '!tank.buff(Beacon of Faith) & !tank.buff(Beacon of Light)', 'tank'},
		{ 'Beacon of Faith', '!tank2.buff(Beacon of Faith) & !tank2.buff(Beacon of Light)', 'tank2'},
	}, '!talent(7,3)'},
	{ 'Bestow Faith', '!tank.buff & talent(1,1) & tank.health <= 90', 'tank'},
	{ 'Bestow Faith', '!tank2.buff & talent(1,1) & tank2.health <= 90', 'tank2'},
}

local encounters = {
	-- Time Release
	{ 'Holy Shock', nil, 'ldebuff(Time Release)'},
	{ 'Flash of Light', 'debuff(Time Release).duration >= 1', 'ldebuff(Time Release)'},
	
	-- M Bot
	{ 'Divine Protection', 'player.debuff(Toxic Spores)'},
}

local aoeHealing = {
	{ 'Beacon of Virtue', 'lowestp.area(30,95).heal >= 3 & talent(7,3)'},
	{ 'Rule of Law', 'area(22,90).heal.infront >= 3 & !player.buff & spell(Light of Dawn).cooldown = 0'},
	{ 'Light of Dawn', 'area(15,90).heal.infront >= 3 & player.buff(Rule of Law)'},
	{ 'Light of Dawn', 'area(15,90).heal.infront >= 3'},
	{ 'Light of Dawn', 'player.buff(Divine Purpose)'},
	{ 'Holy Prism', 'target.area(15,80).heal >= 3'},
}

local healing = {
	{{ -- Aura of Sacrifice Rotation
		{ 'Avenging Wrath'},
		{ 'Holy Avenger'},
		{ 'Holy Shock', nil, 'lowestp'},
		{ 'Light of Dawn'},
		{ 'Flash of Light', nil, 'lowestp'},
	}, 'player.buff(Aura Mastery) & talent(5,2)'},
		
	{ aoeHealing},
	
	-- Tyrs Deliverance
	{ '200652', 'player.area(15,75).heal >= 3'},
	{ '200652', 'player.area(22,75).heal >= 3 & player.buff(Rule of Law)'},
	
	{ encounters, 'UI(ENC)'},
	
	{ 'Light of the Martyr', '!player & player.buff(Maraad\'s Dying Breath) & lowestp.health <= UI(L_FoL)', 'lowestp'},
	
	-- Infusion of Light
	--{ 'Flash of Light', 'player.buff(Infusion of Light).count >= 2', 'lowestp'},
	{ 'Flash of Light', 'lowestp.health <= UI(L_FoL) & player.buff(Infusion of Light)', 'lowestp'},
	{ 'Flash of Light', 'player.buff(Infusion of Light).duration <= 3 & player.buff(Infusion of Light)', 'lowestp'},
	
	-- Need player health spinner added
	{{
		{ 'Light of the Martyr', '!player & tank.health <= UI(T_LotM)', 'tank'},
		{ 'Light of the Martyr', '!player & tank2.health <= UI(T_LotM)', 'tank2'},
		{ 'Light of the Martyr', '!player & lowestp.health <= UI(L_LotM)', 'lowestp'},
	}, 'player.health >= 40'},
	
	{ 'Holy Shock', 'tank.health <= UI(T_HS)', 'tank'},
	{ 'Holy Shock', 'tank2.health <= UI(T_HS)', 'tank2'},
	{ 'Holy Shock', 'lowestp.health <= UI(L_HS)', 'lowestp'},
	
	{ 'Flash of Light', 'lbuff(200654).health <= UI(L_FoL)', 'lbuff(200654)'},
	
	{ 'Light of the Martyr', '!player & lowest.health <= UI(L_FoL) & { player.buff(Divine Shield) || player.buff(Xavaric\'s Magnum Opus) }', 'lowest'},
	{ 'Flash of Light', 'tank.health <= UI(T_FoL)', 'tank'},
	{ 'Flash of Light', 'tank2.health <= UI(T_FoL)', 'tank2'},
	{ '!Flash of Light', 'lowestp.health <= UI(L_FoL) & player.casting(Holy Light) & player.casting.percent <= 50', 'lowestp'},
	{ 'Flash of Light', 'lowestp.health <= UI(L_FoL)', 'lowestp'},
	
	{ 'Judgment', 'target.enemy'}, -- Keep up dmg reduction buff
	
	-- Grievous Wound (M+)
	{ 'Holy Shock', nil, 'ldebuffa(Grievous Wound)'},
	{ 'Flash of Light', nil, 'ldebuffa(Grievous Wound)'},
	
	{ 'Holy Light', 'tank.health <= UI(T_HL)', 'tank'},
	{ 'Holy Light', 'tank2.health <= UI(T_HL)', 'tank2'},
	{ 'Holy Light', 'lowestp.health <= UI(L_HL)', 'lowestp'},
}

local emergency = {
	{ '!Holy Shock', '!player.casting(200652)', 'lowestp'},
	{ '!Flash of Light', '!player.moving & !player.casting(200652)', 'lowestp'},
	{ '!Light of the Martyr', '!player.casting(Flash of Light) & !player.casting(200652)', 'lowestp'},
}

local cooldowns = {
	-- Need to rewrite for Raid and 5 Man
	{ 'Lay on Hands', 'UI(LoH) & lowestp.health <= UI(L_LoH) & !lowestp.debuff(Forbearance).any', 'lowestp'},
	{ 'Aura Mastery', 'UI(AM) & player.area(40,40).heal >= 4'},
	{ 'Avenging Wrath', 'UI(AW) & player.area(35,65).heal >= 4 & player.spell(Holy Shock).cooldown = 0'},
	{ 'Holy Avenger', 'UI(HA) & player.area(40,75).heal >= 3 & player.spell(Holy Shock).cooldown = 0'},
	
	{ 'Blessing of Sacrifice', 'tank.health <= UI(T_BoS)', 'tank'}, 
	{ 'Blessing of Sacrifice', 'tank2.health <= UI(T_BoS)', 'tank2'}, 
	
	--{ '#trinket2', 'player.area(40,95).heal >= 3'},
}

local moving = {
	{ aoeHealing},
	
	{ 'Holy Shock', nil, 'ldebuff(Grievous Wound)'},
	
	{{
		{ 'Light of the Martyr', '!player & tank.health <= UI(T_LotM)', 'tank'},
		{ 'Light of the Martyr', '!player & tank2.health <= UI(T_LotM)', 'tank2'},
		{ 'Light of the Martyr', '!player & lowestp.health <= UI(L_LotM)', 'lowestp'},
	}, 'player.health >= 40 || player.buff(Divine Shield)'},
	
	{ 'Holy Shock', 'tank.health <= UI(T_HS)', 'tank'},
	{ 'Holy Shock', 'lowestp.health <= UI(L_HS)', 'lowestp'},
	
	{ 'Judgment', 'target.enemy'},
}

local manaRestore = {
	{ aoeHealing},
	
	-- Holy Shock
	{ 'Holy Shock', 'tank.health <= UI(T_HS) / 2', 'tank'},
	{ 'Holy Shock', 'tank2.health <= UI(T_HS) / 2', 'tank2'},
	{ 'Holy Shock', 'lowestp.health <= UI(L_HS) / 2', 'lowestp'},
	
	-- Flash of Light
	{ 'Flash of Light', 'tank.health <= UI(T_FoL) / 2', 'tank'},
	{ 'Flash of Light', 'tank2.health <= UI(T_FoL) / 2', 'tank2'},
	{ 'Flash of Light', 'lowestp.health <= UI(L_FoL) / 2', 'lowestp'},
	
	-- Holy Light
	{ 'Holy Light', 'tank.health <= UI(T_HL) / 2', 'tank'},
	{ 'Holy Light', 'tank2.health <= UI(T_HL) / 2', 'tank2'},
	{ 'Holy Light', 'lowestp.health <= UI(L_HL) / 2', 'lowestp'},
}

local inCombat = {
	{ pause, 'keybind(lalt)'},
	{ topUp, 'keybind(lcontrol)'},
	{ survival}, 
	{ interrupts, 'target.interruptAt(35)'},
	{ '%dispelall', 'toggle(disp) & spell(Cleanse).cooldown = 0'},
	{ cooldowns, 'toggle(cooldowns)'},
	{ emergency, 'lowestp.health <= UI(G_CHP) & !player.casting(200652)'},
	{ tank},
	{ DPS, 'toggle(dps) & target.enemy & target.infront & lowestp.health >= UI(G_DPS)'},
	{ moving, 'player.moving'},
	{ manaRestore, 'player.mana < UI(P_MR)'},
	{ healing, '!player.moving & player.mana >= UI(P_MR)'},
	{ DPS, 'toggle(dps) & target.enemy & target.infront'},
}

local outCombat = {
	-- Need to prevent this while eating
	{ tank},
	{ topUp, 'keybind(lcontrol)'},
	
	-- Precombat
	{ 'Bestow Faith', 'pull_timer <= 3', 'tank'},
	{ '#Potion of Prolonged Power', '!player.buff & pull_timer <= 2'},
	
	-- Grievous Wound (M+)
	{ 'Holy Shock', nil, 'ldebuffa(Grievous Wound)'},
	{ 'Flash of Light', nil, 'ldebuffa(Grievous Wound)'},
	
	{ oocTopUp},
	
	-- Testing low mana
	--{ manaRestore, 'player.mana < UI(P_MR)'},
	--{ healing, '!player.moving & player.mana >= UI(P_MR)'},
	
	{ '%ressdead(Redemption)', 'UI(rezz)'},
	
	--{ 'Flash of Light', nil, 'ldebuff(Forbearance)'},
}

NeP.CR:Add(65, {
	name = '[Silver] Paladin - Holy',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})