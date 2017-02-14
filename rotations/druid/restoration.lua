local GUI = {  
    --Resurrection
	{type = 'header', text = 'Ressurection', align = 'center'},
	{type = 'checkbox', text = 'Auto Ress out of combat', key = 'rezz', default = false},
	{type = 'ruler'},{type = 'spacer'},

	--Cooldowns
	{type = 'header', text = 'Cooldowns when toggled on', align = 'center'},
	{type = 'checkspin', text = 'Use Iron Bark', key = 'ib', default_check = false, default_spin = 25},
	{type = 'ruler'},{type = 'spacer'},

    --TRINKETS
    {type = 'header', text = 'Trinkets', align = 'center'},
    {type = 'checkbox', text = 'Top Trinket', key = 'trinket_1', default = false},
    {type = 'checkbox', text = 'Bottom Trinket', key = 'Trinket_2', default = false},
    {type = 'ruler'},{type = 'spacer'},

	--KEYBINDS
	{type = 'header', text = 'Keybinds', align = 'center'},
	{type = 'text', text = 'Left Shift: Holy Word: Sanctify|Left Ctrl: Mass Dispel|Alt: Pause', align = 'center'},
	{type = 'checkbox', text = 'Holy Word: Sanctify', key = 'k_HWS', default = false},
	{type = 'checkbox', text = 'Mass Dispel', key = 'k_MD', default = false},
	{type = 'checkbox', text = 'Pause', key = 'k_P', default = false},
	{type = 'ruler'},{type = 'spacer'},

	--POTIONS
	{type = 'header', text = 'Potions', align = 'center'},
	{type = 'text', text = 'Check to enable Potions', align = 'center'},
	{type = 'checkspin', text = 'Healthstone', key = 'p_HS', default_check = false, default_spin = 25},
	{type = 'checkspin', text = 'Ancient Healing Potion', key = 'p_AHP', default_check = false, default_spin = 25},
	{type = 'checkspin', text = 'Ancient Mana Potion', key = 'p_AMP', default_check = false, default_spin = 20},
	{type = 'ruler'},{type = 'spacer'},

	--Before Pull
	{type = 'header', text = 'Pull Timer', align = 'center'},
	{type = 'text', text = 'Cast on Tank.', align = 'center'},
	{type = 'checkbox', text = 'Renew ', key = 'pull_Ren', default= false},
	{type = 'checkbox', text = 'Prayer of Mending', key = 'pull_PoM', default= false},
	{type = 'ruler'}, {type = 'spacer'},

	--DPS
	{type = 'header', text = 'Extra DPS', align = 'center'},
	{type = 'text', text = 'Check to enable extra DPS', align = 'center'},
	{type = 'checkbox', text = 'Holy Word: Chastise', key = 'd_HWC', default = false},
	{type = 'checkbox', text = 'Holy Fire', key = 'd_HF', default = false},
	{type = 'ruler'},{type = 'spacer'},

	--Full DPS
	{type = 'header', text = 'Full DPS', align = 'center'},
	{type = 'text', text = 'Player health values', align = 'center'},
	{type = 'spinner', text = 'Gift of the Naaru', key = 'full_Gift', default = 20},
	{type = 'spinner', text = 'Holy Word: Serenity', key = 'full_HWSE', default = 40},
	{type = 'spinner', text = 'Flash Heal', key = 'full_FH', default = 50},
	{type = 'ruler'},{type = 'spacer'},

	--TANK
	{type = 'header', text = 'Tank', align = 'center'},
	{type = 'text', text = 'Tank health values', align = 'center'},
	{type = 'spinner', text = 'Holy Word: Serenity', key = 't_HWSE', default = 60},
	{type = 'spinner', text = 'Regrowth', key = 'trg', default = 85},
	{type = 'spinner', text = 'Rejuvenation', key = 'trejuv', default = 100},
	{type = 'ruler'},{type = 'spacer'},

	--PLAYER
	{type = 'header', text = 'Player', align = 'center'},
	{type = 'text', text = 'Player health values', align = 'center'},
	{type = 'spinner', text = 'Gift of the Naaru', key = 'p_Gift', default = 20},
	{type = 'spinner', text = 'Holy Word: Serenity', key = 'p_HWSE', default = 40},
	{type = 'spinner', text = 'Flash Heal', key = 'p_FH', default = 70},
	{type = 'spinner', text = 'Prayer of Mending', key = 'p_PoM', default = 100},
	--{type = 'spinner', text = 'Renew', key = 'p_Ren', default = 0},
	{type = 'ruler'},{type = 'spacer'},
	
	-- EMERGENCY
	{type = 'header', text = 'Emergency', align = 'center'},
	{type = 'text', text = 'Emergency health values', align = 'center'},
	{type = 'spinner', text = 'Activate Emergency Healing', key = 'emergency', default = 20},
	{type = 'ruler'},{type = 'spacer'},

	--LOWEST
	{type = 'header', text = 'Lowest', align = 'center'},
	{type = 'text', text = 'Lowest health values', align = 'center'},
	{type = 'spinner', text = 'Regrowth', key = 'lrg', default = 85},
	{type = 'spinner', text = 'Swiftmend', key = 'lsm', default = 90},
	{type = 'spinner', text = 'Rejuvenation', key = 'lrejuv', default = 70},
	{type = 'spinner', text = 'Healing Touch', key = 'lht', default = 95},
	{type = 'ruler'},{type = 'spacer'},

	--MOVING
	{type = 'header', text = 'Movement', align = 'center'},
	{type = 'checkbox', text = 'Angelic Feather', key = 'm_AF', default = false},
	{type = 'checkbox', text = 'Body and Mind', key = 'm_Body', default = false},
	{type = 'text', text = 'Lowest health and moving values', align = 'center'},
	{type = 'spinner', text = 'Swiftmend', key = 'lsmm', default = 90},
	{type = 'spinner', text = 'Rejuvenation', key = 'lrejuvmove', default = 90},
}

local exeOnLoad = function()
	
    
	print('|cffFACC2E Resto Druid Rotation loaded|r')
	print('|cffFACC2E For Settings Right-Click the MasterToggle and go to Combat Routines Settings |r')
	print('|cffFACC2E Have a nice day!|r')
	
	NeP.Interface:AddToggle({
		key = 'dps',
		name = 'DPS!',
		text = 'ON/OFF using DPS in rotation',
		icon = 'Interface\\ICONS\\spell_nature_starfall', --toggle(DPS)
	})

	NeP.Interface:AddToggle({
		key = 'disp',
		name = 'Dispell',
		text = 'ON/OFF Dispel All',
		icon = 'Interface\\ICONS\\spell_holy_dispelmagic', --toggle(disp)
	})


end

local keybinds = {
	{ '%pause', 'keybind(alt)'},
	{ 'Efflorescence', 'keybind(control)', 'cursor.ground'},
}

local target = {
	{{ -- Targeting
		{ '/targetenemy [noexists]', { -- Target an enemy
			'!target.exists',
		}},
		{ '/focus [@targettarget]',{ -- Set focus to current targets target
			'target.enemy',
			'target(target).friend' ,
		}},
	}},
}

local potions = {
	--Health Stone below 20% health. Active when NOT channeling Divine Hymn.
	{ '#Healthstone', 'UI(p_HS_check) & player.health <= UI(p_HS_spin) & !player.channeling(Tranquility)'},
	--Ancient Healing Potion below 20% health. Active when NOT channeling Divine Hymn.
	{ '#Ancient Healing Potion', 'UI(p_AHP_check) & player.health <= UI(p_AHP_spin) & !player.channeling(Tranquility)'},
	--Ancient Mana Potion below 20% mana. Active when NOT channeling Divine Hymn.
	{ '#Ancient Mana Potion', 'UI(p_AMP_check) & player.mana <= UI(p_AMP_spin) & !player.channeling(Tranquility)'}
}

local dps = {
	{ 'Moonfire', '!target.debuff'},
	{ 'Sunfire', '!target.debuff'},
	{ 'Solar Wrath', '!player.moving'},
}

local innervate = {
	-- Swiftmend
	{ 'Swiftmend', 'lowest.health <= UI(lsmm) & lowest.buff(Rejuvenation)', 'lowest'},

	-- Apply Rejuv to 10 lowests players
    { 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest1'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest2'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest3'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest4'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest5'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest6'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest7'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest8'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest9'},
	{ 'Rejuvenation', 'lowest1.health <= 99 & !lowest1.buff', 'lowest10'},
	
	{ 'Regrowth', nil, 'lowest'}, 
}

local treeForm = {

}

local tank = {
	-- Lifebloom on the tank
	{ 'Lifebloom', 'focus.buff(Lifebloom).duration <= 5', 'focus'},
	{ 'Lifebloom', 'tank.buff(Lifebloom).duration <= 5 & !focus.exists', 'tank'},
	
	-- Regrowth on tank
	{'Regrowth', 'focus.health <= UI(trg) & !player.moving', 'focus'},
	{'Regrowth', 'tank.health <= UI(trg) & !player.moving', 'tank'},

	--Renew if tank missing Rejuvenation and when tank health is below or if UI value.
	{'Rejuvenation', '!focus.buff(Rejuvenation) & focus.health <= UI(trejuv)', 'focus'},
	{'Rejuvenation', '!tank.buff(Rejuvenation) & tank.health <= UI(trejuv)', 'tank'}
}

local lowest = {  
	-- Essance of G'Hanir
	{ '208253', 'lowest.area(40, 60).heal >= 3 & toggle(AOE)'},
	{ 'Wild Growth', 'player.lastcast(208253)', 'lowest'},

	-- Wild Growth
	{ 'Wild Growth', 'lowest.area(40, 85).heal >= 3 & toggle(AOE)', 'lowest'},
	
	-- Flourish
	{ 'Flourish', 'player.lastcast(Wild Growth) & lowest.area(40, 60).heal >= 3'},
	
	-- Regrowth with OOM proc
	{ 'Regrowth', 'player.buff(Clearcasting)', 'lowest'},
	
	-- Apply Rejuv to 10 lowests players
    { 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest1'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest2'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest3'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest4'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest5'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest6'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest7'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest8'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest9'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuv) & !lowest1.buff', 'lowest10'},
	
	-- Swiftmend
	{ 'Swiftmend', 'lowest.health <= UI(lsm) & lowest.buff(Rejuvenation)', 'lowest'},
	
	-- Regrowth on lowest player
	{ 'Regrowth', 'lowest.health <= UI(lrg)', 'lowest'},
	
	-- Healing Touch
	{ 'Healing Touch', 'lowest.health <= UI(lht)', 'lowest'},
}

local moving = {
	-- Swiftmend
	{ 'Swiftmend', 'lowest.health <= UI(lsmm) & lowest.buff(Rejuvenation)', 'lowest'},
	
	-- Apply Rejuv to 10 lowests players
    { 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest1'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest2'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest3'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest4'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest5'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest6'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest7'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest8'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest9'},
	{ 'Rejuvenation', 'lowest1.health <= UI(lrejuvmove) & !lowest1.buff', 'lowest10'},
}

local emergency = {
	{ '!Rejuvenation', '!lowest.buff', 'lowest'}, 
	{ '!Swiftmend', nil, 'lowest'},
	{ '!Regrowth', '!player.moving', 'lowest'},
	
}

local InCombat = {
	{ '/cancelaura Cat Form', 'player.buff(Cat Form)'},
	{ target},
	{ potions},
	{ keybinds},
	{ '%dispelall', 'toggle(disp) & !player.channeling(Tranquility) & spell(88423).cooldown = 0'},
	{ emergency, 'lowest.health <= UI(emergency) & player.casting.percent <= 60 & !player.channeling(Tranquility)'},
	{ innervate, 'player.buff(Innervate) & !player.channeling(Tranquility)'},
	{ treeForm, 'player.buff(Incarnation: Tree of Life) & !player.channeling(Tranquility)'},
	-- Iron Bark if lowest health is below or if UI value and checked.
	{ '!Ironbark', 'UI(ib_check) & lowest.health <= UI(ib_spin) & toggle(cooldowns) & !player.channeling(Tranquility)', 'lowest'},
	{ moving, 'player.moving & !player.channeling(Tranquility)'},
	{{
		{ tank},
		{ lowest, '!player.moving'},
		{ dps, 'toggle(dps)'},
	}, '!player.moving & !player.channeling(Tranquility)'},
}

local OutCombat = {
	{ keybinds},
	--{ emergency, 'lowest.health <= UI(emergency) & player.casting.percent <= 60 & !player.channeling(Tranquility)'},
	--{ tank},
	--{ lowest, '!player.moving'},
	--{ moving, 'player.moving'}
}

NeP.CR:Add(105, {
  name = '[Silver] Druid - Restoration',
  ic = InCombat,
  ooc = OutCombat,
  gui = GUI,
  load = exeOnLoad
})
