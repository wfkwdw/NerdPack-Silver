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

}

local preCombat = {

}

local inCombat = {
	{ '/startattack', '!isattacking & target.enemy'},
}

local outCombat = {
	{ keybinds},
	{ preCombat}
}

NeP.CR:Add(251, {
	name = '[Silver] Death Knight - Frost',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})