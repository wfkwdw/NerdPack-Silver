local GUI = {
	{type = 'header', 	text = 'Toggles', align = 'center'},
	{type = 'checkbox',	text = 'MultiDot (Bosses)',					key = 'MDb', 	default = true},
	{type = 'checkbox',	text = 'MultiDot (Mobs)',					key = 'MDm', 	default = true},
	{type = 'checkbox',	text = 'Burning Rush',						key = 'BR', 	default = true},}

local exeOnLoad = function()
	print('|cffADFF2F ----------------------------------------------------------------------|r')
	print("|cffADFF2F --- |rWARLOCK |cffADFF2FAffliction |r")
	print("|cffADFF2F --- |rRecommended Talents: 1/2 - 2/2 - 3/1 - 4/1 - 5/3 - 6/3 - 7/2")
	print('|cffADFF2F ----------------------------------------------------------------------|r')
end

local survival = {
	{ '#Healthstone', 'health <= 40', 'player'},
	{ 'Unending Resolve', 'health <= 20', 'player'},
	{ 'Drain Life', 'player.health <= 40 & !player.moving', 'target'},
}

local petCare = {
	{ 'Summon Imp', '!talent(6,3) & !partycheck = 1 & !player.lastcast & { !pet.exists || pet.dead}'},
	{ 'Summon Voidwalker', '!talent(6,3) & partycheck = 1 & !player.lastcast & { !pet.exists || pet.dead}'},
	
	{ 'Summon Felhunter', 'talent(6,3) & !player.lastcast & { !pet.exists || pet.dead } & player.buff(Grimoire of Sacrifice).duration <= 600'},
	{ 'Grimoire of Sacrifice', '!player.buff & !player.lastcast & pet.exists & talent(6,3)'}, 
	
	{ 'Health Funnel', 'health <= 30 & alive & !player.moving', 'pet'}, 
} 

local interrupts = {
	{ 'Shadow Lock'},
}

local utility = {
	{ 'Shadowfury', 'target.area(8).enemies >= 3 & !player.moving', 'target.ground'}, 
}

local pvp = {

}

local cooldowns = {
	{ '#trinket1'},
	{ '#trinket2'},
	{ 'Blood Fury'}, 

	-- /dump NeP.DSL:Get('unstableAffliction')('target')

	-- Setup for Darkglare
	{ 'Unstable Affliction', 'player.spell(Summon Darkglare).cooldown <= 2.5 & !player.moving & toggle(cooldowns) & unstableAffliction < 3', 'target'}, 
	{ 'Phantom Singularity', 'unstableAffliction >= 3', 'target'},
	{ 'Summon Darkglare', 'debuff(Agony) & debuff(Corruption) & unstableAffliction >= 3', 'target'},
}

local agonyCycle = {
	{ 'Agony', 'enemy & debuff.duration <= 5.4 & range <= 40', 'focus'},
	{ 'Agony', 'combat & debuff.duration <= 5.4 & range <= 40 & deathin >= 7 & count.enemies.debuffs <= 5', 'enemies'},
}

local agony = {
	{ 'Agony', 'debuff.duration <= 5.4', 'target'},
	{ agonyCycle},
}

local corruptionCycle = {
	{ 'Corruption', 'enemy & debuff.duration <= 4.2 & range <= 40', 'focus'},
	{ 'Corruption', 'UI(MDm) & combat & { talent(2,2) & !debuff & deathin >= 7 || !talent(2,2) & debuff.duration <= 4.2}  & range <= 40 & deathin >= 7 & count.enemies.debuffs <= 5', 'enemies'},
}

local corruption = {
	{ 'Corruption', 'debuff.duration <= 4.2 & !talent(2,2)', 'target'},
	{ 'Corruption', '!debuff & talent(2,2)', 'target'},
	{ corruptionCycle, '!target.area(10).enemies >= 4'}, 
} 

local siphonCycle = {
	{ 'Siphon Life', 'enemy & debuff.duration <= 4.5 & range <= 40', 'focus'},
	{ 'Siphon Life', 'UI(MDm) & combat & debuff.duration <= 4.5 & range <= 40 & deathin >= 7 & count.enemies.debuffs <= 3', 'enemies'},
}

local siphon = {
	{ 'Siphon Life', 'debuff.duration <= 4.5', 'target'},
	{ siphonCycle}, 
}

local unstableAfflictionCycle = {
	{ 'Unstable Affliction', 'combat & debuff(Agony) & !debuff & range <= 40 & count.enemies.debuffs <= 5', 'enemies'},
}

local singleTarget = {
	{ agony},
	{ 'Unstable Affliction', 'player.shards >= 5 & !player.moving', 'target'},
	{ corruption},
	{ cooldowns, 'toggle(cooldowns) & target.bosscheck >= 1'}, 
	{ siphon},
	{ 'Unstable Affliction', 'player.shards >= 4 & !player.moving', 'target'},
	{ 'Haunt', '!player.moving'},
	{ 'Deathbolt'},
	{ 'Phantom Singularity'},
	{ 'Summon Darkglare', 'toggle(cooldowns) & debuff(Agony) & debuff(Corruption) & unstableAffliction >= 1 & bosscheck >= 1', 'target'},
	{ 'Unstable Affliction', '!debuff & !player.moving & !player.lastcast || unstableAffliction = 1 & debuff.duration <= 1 & !player.lastcast ', 'target'},
	{ 'Drain Life', 'player.buff(Inevitable Demise).count >= 100 & !player.moving', 'target'},
	{ 'Shadow Bolt', '!player.moving'},
}

local multiTarget = {
	{ agony},
	{ 'Seed of Corruption', '!player.lastcast & !debuff & area(10).enemies >= 2 & debuff(Corruption).duration <= 6.2 & !player.moving', 'target'},
	{ corruption, '!debuff(Seed of Corruption) & !player.lastcast(Seed of Corruption)'},
	{ cooldowns, 'toggle(cooldowns) & target.bosscheck >= 1'}, 
	{ 'Seed of Corruption', 'target.area(10).enemies >= 8 & player.shards >= 1', 'target'},
	{ 'Unstable Affliction', 'player.shards >= 5 & !player.moving', 'target'},
	{ 'Phantom Singularity'},
	{ unstableAfflictionCycle, '!player.moving & player.shards >= 2'}, 
	{ siphon},
	{ 'Shadow Bolt'},
}

local burningRush = {
	{ '/cancelaura Burning Rush', 'player.lastmoved >= .02 & player.buff(Burning Rush) || player.health < 40 & player.buff(Burning Rush)'},
	{ 'Burning Rush', 'player.movingfor >= 2 & !player.buff & player.health >= 60'},
}


local inCombat = {
	{ burningRush, 'UI(BR)'},
	{ survival},
	{ utility}, 
	{ petCare},
	{ interrupts, 'target.interruptAt(50)'},
	{ multiTarget, 'target.area(10).enemies >= 2 & toggle(aoe)'},
	{ singleTarget, 'target.area(10).enemies < 2 & toggle(aoe) || !toggle(aoe)'},
}

local outCombat = {
	{ burningRush, 'UI(BR)'},
	{ survival},
	{ petCare},
}

NeP.CR:Add(265, {
      name = '[Silver] Warlock - Affliction',
        ic = inCombat,
       ooc = outCombat,
       gui = GUI,
      load = exeOnLoad,
   wow_ver = '8.0.1',
   nep_ver = '1.11',
})