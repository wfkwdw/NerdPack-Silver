local GUI = {
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'MultiDot (Bosses)',					key = 'MDb', 	default = true},}

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end


local dots = {
	{ '!Agony', 'debuff.duration <= 5.4 & range <= 40'},
	
	{ '!Agony', 'UI(MDb) & debuff.duration <= 5.4 & range <= 40', 'boss1'},
	{ '!Agony', 'UI(MDb) & debuff.duration <= 5.4 & range <= 40', 'boss2'},
	{ '!Agony', 'UI(MDb) & debuff.duration <= 5.4 & range <= 40', 'boss3'},
	{ '!Agony', 'UI(MDb) & debuff.duration <= 5.4 & range <= 40', 'boss4'},
	{ '!Agony', 'UI(MDb) & debuff.duration <= 5.4 & range <= 40', 'boss5'},
	
	{ '!Corruption', 'debuff.duration <= 4.2 & range <= 40'},
	
	{ '!Corruption', 'UI(MDb) & debuff.duration <= 4.2 & range <= 40', 'boss1'},
	{ '!Corruption', 'UI(MDb) & debuff.duration <= 4.2 & range <= 40', 'boss2'},
	{ '!Corruption', 'UI(MDb) & debuff.duration <= 4.2 & range <= 40', 'boss3'},
	{ '!Corruption', 'UI(MDb) & debuff.duration <= 4.2 & range <= 40', 'boss4'},
	{ '!Corruption', 'UI(MDb) & debuff.duration <= 4.2 & range <= 40', 'boss5'},
	
	{ '!Siphon Life', 'debuff.duration <= 4.5 & range <= 40'},
	
	{ '!Siphon Life', 'UI(MDb) & debuff.duration <= 4.5 & range <= 40', 'boss1'},
	{ '!Siphon Life', 'UI(MDb) & debuff.duration <= 4.5 & range <= 40', 'boss2'},
	{ '!Siphon Life', 'UI(MDb) & debuff.duration <= 4.5 & range <= 40', 'boss3'},
	{ '!Siphon Life', 'UI(MDb) & debuff.duration <= 4.5 & range <= 40', 'boss4'},
	{ '!Siphon Life', 'UI(MDb) & debuff.duration <= 4.5 & range <= 40', 'boss5'},
}

local aoe = {
	{ 'Agony', 'debuff.duration <= 5.4 & range <= 40 & count.enemies.debuffs <= 4', 'enemies'},
	{ 'Seed of Corruption', '!debuff'},
	{ 'Seed of Corruption', '!debuff', 'lowestenemy'},
}

local inCombat = {
	{ 'Life Tap', 'player.mana <= 30'},
	{ aoe, 'target.area(10).enemies >= 3'},
	{ dots, 'target.area(10).enemies < 3 & { !player.casting(Unstable Affliction) || !player.casting(Seed of Corruption)}'},
	{ 'Phantom Singularity'},
	{ '!Unstable Affliction', 'target.area(15).enemies < 3 & !player.casting(Unstable Affliction) & { player.soulshards >= 2 & player.lastcast & player.unstableaffliction <= 4 || player.soulshards >= 3 & player.unstableaffliction <= 4 || player.soulshards >= 3 & target.unstableaffliction >= 1 || player.soulshards > 0 & !debuff}' },
	{ 'Reap Souls', 'player.buff(Tormented Souls).count >= 4 || target.unstableaffliction >= 2 & player.buff(Tormented Souls).count >= 1'},
	{ 'Drain Soul'},
}

local outCombat = {

}

NeP.CR:Add(265, {
  name = '[Silver] Warlock - Affliction',
  ic = inCombat,
  ooc = outCombat,
  gui = GUI,
  load = exeOnLoad
})