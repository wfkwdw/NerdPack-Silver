local GUI = {  

	{type = 'spinner', 	text = 'Critical health%', 						key = 'ch', 	default = 30},

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
end

local keybinds = {
	{ '%pause', 'keybind(alt)'},
	{ 'Efflorescence', 'keybind(control)', 'cursor.ground'},
}



local potions = {

}

local dps = {
	{ 'Moonfire', '!debuff'},
	{ 'Solar Wrath'},
}

local innervate = {
	{ 'Rejuvenation', nil, 'lnbuff(Rejuvenation)'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation)', 'lnbuff(Rejuvenation (Germination))'},
	{ 'Regrowth', nil, 'lowest'},
}

local treeForm = {

}

local moving = {
	{ 'Lifebloom', 'tank.buff.duration <= 4.5', 'tank'},

	{ 'Rejuvenation', 'health <= UI(trejuv)', 'tank'},
	{ 'Rejuvenation', 'health <= UI(trejuv)', 'tank2)'},
	{ 'Rejuvenation', 'health <= UI(lrejuv)', 'lnbuff(Rejuvenation)'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm)', 'tank'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm)', 'tank2'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm)', 'lnbuff(Rejuvenation (Germination))'},
	
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank'},
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank2'},
	{ 'Swiftmend', 'health <= UI(tsm)', 'lowest'},
}

local emergency = {
	{ 'Swiftment', nil, 'loweset'},
	{ 'Regrowth', nil, 'lowest'},
}

local healing = {
	{ emergency, 'lowest.health <= UI(ch)'}, 
	{ innervate, 'player.buff(Innervate)'},
	{ 'Lifebloom', 'tank.buff.duration <= 4.5 & tank.health >= UI(tsm) || !tank.buff', 'tank'},
	
	{ 'Wild Growth', 'area(30,75).heal >= 3', 'lowest'}, 
	{ 'Essence of G\'Hanir', 'lowest.area(30,75).heal >= 3 & lastcast(Wild Growth)'}, 
	{ 'Flourish', 'talent(7,3) & player.lastcast(Wild Growth) & lowest.health <= 50'}, 
	
	{ 'Regrowth', 'player.buff(Clearcasting)', 'lowest'},
	
	-- Rejuv
	{ 'Rejuvenation', 'health <= UI(trejuv) & !buff', 'tank'},
	{ 'Rejuvenation', 'health <= UI(trejuv) & !buff', 'tank2)'},
	{ 'Rejuvenation', 'health <= UI(lrejuv) & !buff', 'lnbuff(Rejuvenation)'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff', 'tank'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff', 'tank2'},
	{ 'Rejuvenation', 'talent(6,3) & buff(Rejuvenation) & health <= UI(lgerm) & !buff', 'lnbuff(Rejuvenation (Germination))'},
	
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank'},
	{ 'Swiftmend', 'health <= UI(tsm)', 'tank2'},
	{ 'Swiftmend', 'health <= UI(tsm)', 'lowest'},

	{ 'Regrowth', 'tank.health <= UI(trg)', 'tank'},
	{ 'Regrowth', 'tank2.health <= UI(trg)', 'tank2'},
	{ 'Regrowth', 'lowest.health <= UI(lrg)', 'lowest'},
	
	{ 'Healing Touch', 'tank.health <= UI(tht)', 'tank'},
	{ 'Healing Touch', 'tank2.health <= UI(tht)', 'tank2'},
	{ 'Healing Touch', 'lowest.health <= UI(lht)', 'lowest'},
}

local inCombat = {
	{ keybinds},
	{ healing},
	{ dps},
}

local outCombat = {
	{ keybinds},
	--{ healing},
}

NeP.CR:Add(105, {
  name = '[Silver] Druid - Restoration',
  ic = inCombat,
  ooc = outCombat,
  gui = GUI,
  load = exeOnLoad
})
