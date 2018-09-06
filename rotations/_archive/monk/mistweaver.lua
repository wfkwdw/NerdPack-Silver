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
	{type = 'checkspin',text = 'Healing Potion/Healthstone',			key = 'P_HP', 	default = false},
	{type = 'checkspin',text = 'Mana Potion',							key = 'P_MP', 	default = false},
	{type = 'spinner',	text = 'Health for LotM',						key = 'P_LotM', default = 40},
	{type = 'checkbox', text = 'Auto Ress out of combat', 				key = 'rezz', 	default = false},
	{type = 'ruler'}, {type = 'spacer'},
		
	--------------------------------
	-- TANK
	--------------------------------
	{type = 'header', 	text = 'Tank', align = 'center'},
	{type = 'spinner', 	text = 'Renewing Mist (Health %)', 				key = 'T_RM', 	default = 95},
	{type = 'spinner', 	text = 'Enveloping Mist (Health %)', 			key = 'T_HS', 	default = 90},
	{type = 'spinner', 	text = 'Effuse (Health %)', 					key = 'T_Ef', 	default = 75},
	{type = 'ruler'}, {type = 'spacer'},
	
	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Lowest', align = 'center'},
	{type = 'spinner', 	text = 'Sheilun\'s Gift (Health %)', 			key = 'L_SG',	default = 95},
	{type = 'spinner', 	text = 'Renewing Mist (Health %)', 				key = 'L_RM',	default = 95},
	{type = 'spinner', 	text = 'Enveloping Mist (Health %)', 			key = 'L_HS', 	default = 90},
	{type = 'spinner', 	text = 'Effuse (Health %)', 					key = 'L_Ef', 	default = 70},
}

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print('|cffADFF2F --- |rSilver Paladin |cffADFF2FProtection |r')
	print('|cffADFF2F --- |rMost Talents Supported')
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
		icon = 'Interface\\ICONS\\spell_holy_purify', 
	})
end

local keybinds = {
	{ 'Summon Jade Serpent Statue', 'keybind(control)', 'cursor.ground'},
}

local legionEvents = {

}

local interrupts = {

}

local cooldowns = {
	{ '&Revival', 'toggle(cooldowns) & {area(40,50).heal > 7 || area(40,80).heal > 11 || area(40,85).heal > 15 || area(40,70).heal > 10 || area(40,60).heal>8||area(40,65).heal > 6 || area(40,30).heal > 4 || area(40,20).heal > 2}', 'player'},
	{ 'Thunder Focus Tea'},
	{ 'Chi Burst', 'area(15,90).heal.infront >= 3'},
}

local moving = {
	{ 'Renewing Mist', 'health <= UI(T_RM) & !buff', 'tank1'},
	{ 'Renewing Mist', 'health <= UI(T_RM) & !buff', 'tank2'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest2'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest3'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest4'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest5'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest6'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest7'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest8'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest9'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest10'},
	{ '!Renewing Mist', 'health <= UI(T_RM) & !buff & player.channeling(Soothing Mist)', 'tank1'},
	{ '!Renewing Mist', 'health <= UI(T_RM) & !buff & player.channeling(Soothing Mist)', 'tank2'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest2'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest3'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest4'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest5'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest6'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest7'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest8'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest9'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest10'},
	
	{ 'Essence Font', 'toggle(AOE) & player.area(25,85).heal >= 3', 'lowestp'},
	{ '!Essence Font', 'toggle(AOE) & player.area(25,85).heal >= 3 & player.channeling(Soothing Mist)', 'lowestp'},
}

local healing = {
	{ 'Renewing Mist', 'health <= UI(T_RM) & !buff', 'tank1'},
	{ 'Renewing Mist', 'health <= UI(T_RM) & !buff', 'tank2'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest2'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest3'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest4'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest5'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest6'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest7'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest8'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest9'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest10'},
	{ '!Renewing Mist', 'health <= UI(T_RM) & !buff & player.channeling(Soothing Mist)', 'tank1'},
	{ '!Renewing Mist', 'health <= UI(T_RM) & !buff & player.channeling(Soothing Mist)', 'tank2'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest2'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest3'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest4'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest5'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest6'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest7'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest8'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest9'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest10'},
	
	{ 'Vivify', 'player.buff(Uplifting Trance) & area(30,75).heal > 1', 'lowestp'},
	{ '!Vivify', 'player.buff(Uplifting Trance) & area(30,75).heal > 1 & player.channeling(Soothing Mist)', 'lowestp'},
	
	{ 'Essence Font', 'toggle(AOE) & player.area(25,75).heal >= 3', 'lowestp'},
	{ '!Essence Font', 'toggle(AOE) & player.area(25,75).heal >= 3 & player.channeling(Soothing Mist)', 'lowestp'},
	
	{ 'Vivify', 'area(40,80).heal >= 3 & toggle(AOE)', 'tank'},
	{ 'Vivify', 'area(40,80).heal >= 3 & toggle(AOE)', 'tank2'},
	{ 'Vivify', 'area(40,80).heal >= 3 & toggle(AOE)', 'lowestp'},
	{ '!Vivify', 'area(40,80).heal >= 3 & toggle(AOE) & player.channeling(Soothing Mist)', 'tank'},
	{ '!Vivify', 'area(40,80).heal >= 3 & toggle(AOE) & player.channeling(Soothing Mist)', 'tank2'},
	{ '!Vivify', 'area(40,80).heal >= 3 & toggle(AOE) & player.channeling(Soothing Mist)', 'lowestp'},	
	
	{ 'Sheilun\'s Gift', 'spell.count >= 4 & health <= UI(L_SG)', 'lowestp'},
	{ '!Sheilun\'s Gift', 'spell.count >= 4 & health <= UI(L_SG)', 'lowestp'},
	
	{ 'Enveloping Mist', 'tank.health <= UI(T_HS) & !buff & !debuff(Spirit Realm).any', 'tank'},
	{ 'Enveloping Mist', 'tank2.health <= UI(T_HS) & !buff & !debuff(Spirit Realm).any', 'tank2'},
	{ 'Enveloping Mist', 'lowestp.health <= UI(L_HS) & !buff & !debuff(Spirit Realm).any', 'lowestp'},
	{ '!Enveloping Mist', 'tank.health <= UI(T_HS) & player.channeling(Soothing Mist) & !buff & !debuff(Spirit Realm).any', 'tank'},
	{ '!Enveloping Mist', 'tank2.health <= UI(T_HS) & player.channeling(Soothing Mist) & !buff', 'tank2'},
	{ '!Enveloping Mist', 'lowestp.health <= UI(L_HS) & player.channeling(Soothing Mist) & !buff', 'lowestp'},
	
	{ 'Effuse', 'tank.health <= UI(T_Ef)', 'tank'},
	{ 'Effuse', 'tank2.health <= UI(T_Ef)', 'tank2'},
	{ 'Effuse', 'lowestp.health <= UI(L_Ef)', 'lowestp'},
	{ '!Effuse', 'tank.health <= UI(T_Ef) & player.channeling(Soothing Mist)', 'tank'},
	{ '!Effuse', 'tank2.health <= UI(T_Ef) & player.channeling(Soothing Mist)', 'tank2'},
	{ '!Effuse', 'lowestp.health <= UI(L_Ef) & player.channeling(Soothing Mist)', 'lowestp'},

}

local lowMana = {
	{ 'Renewing Mist', 'health <= UI(T_RM) & !buff', 'tank1'},
	{ 'Renewing Mist', 'health <= UI(T_RM) & !buff', 'tank2'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest2'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest3'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest4'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest5'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest6'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest7'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest8'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest9'},
	{ 'Renewing Mist', 'health <= UI(L_RM) & !buff', 'lowest10'},
	{ '!Renewing Mist', 'health <= UI(T_RM) & !buff & player.channeling(Soothing Mist)', 'tank1'},
	{ '!Renewing Mist', 'health <= UI(T_RM) & !buff & player.channeling(Soothing Mist)', 'tank2'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest2'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest3'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest4'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest5'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest6'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest7'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest8'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest9'},
	{ '!Renewing Mist', 'health <= UI(L_RM) & !buff & player.channeling(Soothing Mist)', 'lowest10'},

	{ 'Sheilun\'s Gift', 'spell.count >= 4 & health <= UI(L_SG)', 'lowestp'},
	{ '!Sheilun\'s Gift', 'spell.count >= 4 & health <= UI(L_SG)', 'lowestp'},

	{ 'Enveloping Mist', 'tank.health <= UI(T_HS) & !buff', 'tank'},
	{ 'Enveloping Mist', 'tank2.health <= UI(T_HS) & !buff', 'tank2'},
	{ 'Enveloping Mist', 'lowestp.health <= UI(L_HS) & !buff', 'lowestp'},
	{ '!Enveloping Mist', 'tank.health <= UI(T_HS) & player.channeling(Soothing Mist) & !buff', 'tank'},
	{ '!Enveloping Mist', 'tank2.health <= UI(T_HS) & player.channeling(Soothing Mist) & !buff', 'tank2'},
	{ '!Enveloping Mist', 'lowestp.health <= UI(L_HS) & player.channeling(Soothing Mist) & !buff', 'lowestp'},

	{ 'Effuse', 'tank.health <= UI(T_Ef) & !debuff(Spirit Realm).any', 'tank'},
	{ 'Effuse', 'tank2.health <= UI(T_Ef) & !debuff(Spirit Realm).any', 'tank2'},
	{ 'Effuse', 'lowestp.health <= UI(L_Ef) & !debuff(Spirit Realm).any', 'lowestp'},
	{ '!Effuse', 'tank.health <= UI(T_Ef) & player.channeling(Soothing Mist)', 'tank'},
	{ '!Effuse', 'tank2.health <= UI(T_Ef) & player.channeling(Soothing Mist)', 'tank2'},
	{ '!Effuse', 'lowestp.health <= UI(L_Ef) & player.channeling(Soothing Mist)', 'lowestp'},	
}

local thunderFocusTea = {
	{ 'Enveloping Mist', 'lowestp.health <= UI(L_HS) & !buff', 'lowestp'},
	{ '!Enveloping Mist', 'lowestp.health <= UI(L_HS) & player.channeling(Soothing Mist) & !buff', 'lowestp'},
	
	{ 'Effuse', 'lowestp.health <= UI(L_Ef) & !debuff(Spirit Realm).any', 'lowestp'},
	{ '!Effuse', 'lowestp.health <= UI(L_Ef) & player.channeling(Soothing Mist)', 'lowestp'},	
}

local dps = {
	{ '/startattack', '!isattacking & target.range < 10 & target.enemy & target.alive'},
	{ 'Rising Sun Kick', 'player.mana > UI(P_MR)'}, 
	{ 'Tiger Palm', 'player.buff(Teachings of the Monastery).count <= 2', 'target'},
	{ 'Blackout Kick', 'player.buff(Teachings of the Monastery)', 'target'},
}

local inCombat = {
	{ keybinds},
	{ '%dispelall', 'toggle(disp) & spell(Detox).cooldown = 0'},
	{ cooldowns, 'toggle(cooldowns)'}, 
	{ moving, 'player.moving'}, 
	{ thunderFocusTea, 'player.buff(Thunder Focus Tea)'}, 
	{ lowMana, '!player.moving & player.mana <= UI(P_MR)'},
	{ healing, '!player.moving & player.mana > UI(P_MR)'},
	{ dps, 'toggle(dps) & target.enemy & target.infront'},
}

local outCombat = {
	{ keybinds},
	{ moving, 'player.moving'}, 
	{ healing, '!player.moving'},
}

NeP.CR:Add(270, {
	name = '[Silver] Monk - Mistweaver',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
 wow_ver = '7.3.5',
 nep_ver = '1.11',
	load = exeOnLoad
})
