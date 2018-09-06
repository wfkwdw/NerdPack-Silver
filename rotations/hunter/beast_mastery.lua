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
	{ 'Barbed Shot', 'pet.buff(Frenzy).duration <= 1', 'target'}, 
	{ 'Chimaera Shot'}, 
	{ 'Kill Command'},
	{ 'A murder of Crows'}, 
	
	{ 'Dire Beast'},
	
	{ 'Cobra Shot', 'player.spell(Kill Command).cooldown >= 2.5', 'target'},
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
