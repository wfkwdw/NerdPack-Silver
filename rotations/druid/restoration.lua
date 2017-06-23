local GUI = {  
	{type = 'header', 	text = 'Generic', align = 'center'},
	{type = 'spinner', 	text = 'Critical health%', 						key = 'ch', 	default = 30},
	
	--------------------------------
	-- Toggles
	--------------------------------
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'Encounter Support',						key = 'ENC', 	default = true},
	{type = 'checkspin',text = 'Healing Potion/Healthstone',			key = 'P_HP', 	default = true},
	{type = 'checkspin',text = 'Mana Potion',							key = 'P_MP', 	default = true},
	{type = 'ruler'}, {type = 'spacer'},

	--------------------------------
	-- TANK
	--------------------------------
	{type = 'header', 	text = 'Tank', align = 'center'},											
	{type = 'spinner', 	text = 'Rejuv', 								key = 'trejuv', default = 100},
	{type = 'spinner', 	text = 'Germ', 									key = 'tgerm', 	default = 90},
	{type = 'spinner', 	text = 'Swiftmend', 							key = 'tsm', 	default = 90},
	{type = 'spinner', 	text = 'Healing touch)', 						key = 'tht',	default = 90},
	{type = 'spinner', 	text = 'Regrowth', 								key = 'trg', 	default = 60},
	{type = 'ruler'}, {type = 'spacer'},
	
	--------------------------------
	-- LOWEST
	--------------------------------
	{type = 'header', 	text = 'Lowest', align = 'center'},
	{type = 'spinner', 	text = 'Rejuv', 								key = 'lrejuv', default = 90},
	{type = 'spinner', 	text = 'Germ', 									key = 'lgerm', 	default = 75},
	{type = 'spinner', 	text = 'Swiftmend', 							key = 'lsm', 	default = 90},
	{type = 'spinner', 	text = 'Healing touch)', 						key = 'lht',	default = 90},
	{type = 'spinner', 	text = 'Regrowth', 								key = 'lrg', 	default = 60},
}

local exeOnLoad = function()
	print('|cffFACC2E Resto Druid Rotation loaded|r')
	print('|cffFACC2E For Settings Right-Click the MasterToggle and go to Combat Routines Settings |r')
	print('|cffFACC2E Have a nice day!|r')
	
	NeP.Interface:AddToggle({
		key = 'disp',
		name = 'Dispell',
		text = 'ON/OFF Dispel All',
		icon = 'Interface\\ICONS\\spell_holy_purify', 
	})
end

local keybinds = {
	{ '%pause', 'keybind(alt)'},
	{ 'Efflorescence', 'keybind(control)', 'cursor.ground'},
}

local potions = {
	{ '#127834', 'UI(P_HP_check) & player.health <= UI(P_HP_spin)'}, -- Health Pot
	{ '#Healthstone', 'UI(P_HP_check) & player.health <= UI(P_HP_spin)'},
	{ '#127835', 'UI(P_MP_check) & player.mana <= UI(P_MP_spin)'}, -- Mana Pot
}

local dps = {
	{ 'Moonfire', '!debuff'},
	{ 'Sunfire', '!debuff'},
	{ 'Solar Wrath'},
}

local treeForm = {

}

local emergency = {
	{ 'Swiftment', nil, 'loweset'},
	{ 'Regrowth', nil, 'lowest'},
}

local rejuvSpam = {
	{ 'Rejuvenation', 'health <= UI(trejuv) & !buff', 'tank'},
	{ 'Rejuvenation', 'health <= UI(trejuv) & !buff', 'tank2)'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest2'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest3'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest4'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest5'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest6'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest7'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest8'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest9'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lowest10'},
	
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'tank'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'tank2'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest2'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest3'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest4'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest5'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest6'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest7'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest8'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest9'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff(Rejuvenation (Germination))', 'lowest10'},
}

local innervate = {
	{ 'Rejuvenation', '!buff', 'tank'},
	{ 'Rejuvenation', '!buff', 'tank2)'},
	{ 'Rejuvenation', '!buff', 'lowest'},
	{ 'Rejuvenation', '!buff', 'lowest2'},
	{ 'Rejuvenation', '!buff', 'lowest3'},
	{ 'Rejuvenation', '!buff', 'lowest4'},
	{ 'Rejuvenation', '!buff', 'lowest5'},
	{ 'Rejuvenation', '!buff', 'lowest6'},
	{ 'Rejuvenation', '!buff', 'lowest7'},
	{ 'Rejuvenation', '!buff', 'lowest8'},
	{ 'Rejuvenation', '!buff', 'lowest9'},
	{ 'Rejuvenation', '!buff', 'lowest10'},
	
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'tank'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'tank2'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest2'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest3'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest4'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest5'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest6'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest7'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest8'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest9'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & !buff(Rejuvenation (Germination))', 'lowest10'},
	
	{ 'Regrowth', nil, 'lowest'},
}

local moving = {
	{ 'Cenarion Ward', '!buff', 'tank'},
	{ 'Cenarion Ward', '!buff', 'tank2'},
	{ 'Lifebloom', 'tank.buff.duration <= 4.5', 'tank'},
	
	{ rejuvSpam},
	
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank'},
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank2'},
	{ 'Swiftmend', 'health <= UI(lsm)', 'lowest'},
}

local healing = {
	{ 'Cenarion Ward', '!buff', 'tank'},
	{ 'Cenarion Ward', '!buff', 'tank2'},
	{ emergency, 'lowest.health <= UI(ch)'}, 
	{ innervate, 'player.buff(Innervate).any'},
	{ 'Lifebloom', 'tank.buff.duration <= 4.5 & tank.health >= UI(tsm) || !tank.buff', 'tank'},
	
	{ 'Wild Growth', 'area(30,75).heal >= 3', 'lowest'}, 
	{ 'Essence of G\'Hanir', 'lowest.area(30,75).heal >= 3 & lastcast(Wild Growth)'}, 
	{ 'Flourish', 'talent(7,3) & player.lastcast(Wild Growth) & lowest.health <= 50'}, 
	
	{ 'Regrowth', 'player.buff(Clearcasting)', 'lowest'},
	
	-- Rejuv
	{ rejuvSpam},
	
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank'},
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank2'},
	{ 'Swiftmend', 'health <= UI(lsm)', 'lowest'},

	{ 'Regrowth', 'tank.health <= UI(trg)', 'tank'},
	{ 'Regrowth', 'tank2.health <= UI(trg)', 'tank2'},
	{ 'Regrowth', 'lowest.health <= UI(lrg)', 'lowest'},
	
	{ 'Healing Touch', 'tank.health <= UI(tht)', 'tank'},
	{ 'Healing Touch', 'tank2.health <= UI(tht)', 'tank2'},
	{ 'Healing Touch', 'lowest.health <= UI(lht)', 'lowest'},
}

local inCombat = {
	{ '/cancelaura Cat Form', 'buff(Cat Form)', 'player'},
	{ keybinds},
	{ '%dispelall', 'toggle(disp) & spell(Nature\'s Cure).cooldown = 0'},
	{ healing},
	{ dps},
}

local outCombat = {
	{ '/cancelaura Cat Form', 'buff(Cat Form)', 'player'},
	{ keybinds},
	{ rejuvSpam, '!buff(Eating)'},
	--{ healing},
}

NeP.CR:Add(105, {
  name = '[Silver] Druid - Restoration',
  ic = inCombat,
  ooc = outCombat,
  gui = GUI,
  load = exeOnLoad
})
