

local GUI = {

}

local exeOnLoad = function()

end

local PreCombat = {

}


local Survival = {
	{'Death Strike', 'player.health<=80&player.buff(Dark Succor)'},
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
}

local Interrupts = {
	{ 'Mind Freeze'},
	{ 'Arcane Torrent', 'target.range<=8&spell(Mind Freeze).cooldown>gcd&!prev_gcd(Mind Freeze)'},
}

local rotation = {
	{ 'Marrowrend', 'player.buff(Bone Shield).duration <= 3'},
	{ 'Blood Boil', '!target.debuff(Blood Plague)'},
	-- DnD here w/ crimson scourge proc
	{ 'Death and Decay', 'player.buff(Crimson Scourge) & talent(2,1)', 'cursor.ground'},
	{ 'Death Strike', 'player.runicpower >= 75'},
	{ 'Marrowrend', 'player.buff(Bone Shield).count <= 6'},
	-- DnD here 3 or more runes and using talent
	{ 'Heart Strike', 'player.runes >= 3'},
	{ 'Consumption'},
	{ 'Blood Boil'},
}

local inCombat = {
	{ rotation},
}

local outCombat = {

}
NeP.CR:Add(250, {
	name = '[Silver] Death Knight - Blood',
	  ic = inCombat,
	 ooc = outCombat,
	 gui = GUI,
	load = exeOnLoad
})
