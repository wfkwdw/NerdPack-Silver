local GUI = {

} 

local exeOnLoad = function()
	print('|cff74ba48BEAST MASTERY|r')
	print('|cff74ba48 _')
	print('|cff74ba48 _')
	print('|cff74ba48 _')
	print('|cff74ba48Suggested Talents: NA')
end

local survival = {

}

local misdirection = {
	{ 'Misdirection', '!player.buff & !focus.exists & pet.exists & player.threat = 100', 'pet'},
	{ 'Misdirection', '!player.buff & focus.exists', 'focus'},
	{ 'Misdirection', '!player.buff & tank.exists & threat > 95', 'tank'},
}

local cooldowns = {
	{'Blood Fury'},
	{'Berserking'},
}

local interrupts = {
	{'Counter Shot'},
}

local keybinds = {
	{ 'Binding Shot', 'keybind(control)', 'target.ground'},
	{ '%pause', 'keybind(alt)'},
}

local rotation = {
	{ 'Murder of Crows', '!player.spell(Bestial Wrath).cooldown <= 30'},
	{ 'Multi-Shot', 'target.area(8).enemies >= 5 & pet.buff(Beast Cleave).duration <= gcd'},
	{ 'Titan\'s Thunder', 'player.lastcast(Dire Beast) || talent(2,2)'},
	{ 'Dire Beast', '!player.spell(Bestial Wrath).cooldown <= 3'},
	{ 'Bestial Wrath'},
	{ 'Kill Command'},
	{ 'Multi-Shot', 'target.area(8).enemies >= 2 & pet.buff(Beast Cleave).duration <= gcd'}, 
	{ '/cast Cobra Shot', 'player.focus > 90 || player.focus >=  60 & player.spell(Kill Command).cooldown > 3'},
}

local inCombat = {
	{ misdirection},
	{ 'Volley', '!buff', 'player'},
	{ interrupts, 'target.interruptAt(35)'}, 
	{ rotation},
}

local outCombat = {
	{ Keybinds},
	{ 'Dismiss Pet', 'pet.exists & toggle(PetSummon) & !player.buff(Feign Death)'},
}

NeP.CR:Add(253, {
	name = '|cffFF7373[Silver]|r HUNTER - Beast Mastery',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
