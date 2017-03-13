local GUI = {

	--Survival (Hunter)
	{type = 'header', text = 'Stay Alive (Hunter)!', align = 'center'},
--	{type = 'checkspin', text = 'Exhilaration', key = 's_EH', default_check = true, default_spin = 30},
	{type = 'checkbox', text = 'Exhilaration', key = 's_EHc', default = true},
	{type = 'spinner', text = 'Exhilaration', key = 's_EH', default = 30},
--	{type = 'checkspin', text = 'Feign Death', key = 's_FD', default_check = false, default_spin = 10},
	{type = 'checkbox', text = 'Feign Death', key = 's_FDc', default = true},
	{type = 'spinner', text = 'Feign Death', key = 's_FD', default = 10},
--	{type = 'checkspin', text = 'Aspect of the Turtle Start', key = 's_AotT', default_check = true, default_spin = 20},
	{type = 'checkbox', text = 'Aspect of the Turtle Start', key = 's_AotTch', default = true},
	{type = 'spinner', text = 'Aspect of the Turtle Start', key = 's_AotT', default = 20},
--	{type = 'checkspin', text = 'Aspect of the Turtle Cancel', key = 's_AotTC', default_check = true, default_spin = 35},	
	{type = 'checkbox', text = 'Aspect of the Turtle Cancel', key = 's_AotTCc', default = true},
	{type = 'spinner', text = 'Aspect of the Turtle Cancel', key = 's_AotTC', default = 35},
	{type = 'ruler'}, {type = 'spacer'},
	
	--Survival (Pet)
	{type = 'header', text = 'Stay Alive (Pet)!', align = 'center'},
--	{type = 'checkspin', text = 'Exhilaration', key = 's_EP', default_check = true, default_spin = 10},
	{type = 'checkbox', text = 'Exhilaration', key = 's_EPc', default = true},
	{type = 'spinner', text = 'Exhilaration', key = 's_EP', default = 10},
	{type = 'ruler'}, {type = 'spacer'},
	
	--Kara Ring
	{type = 'header', text = 'Use Equipment Actives'},
	{type = 'checkbox', text = 'Karazhan Ring', key = 'a_KR', default = true},
} 

local exeOnLoad = function()
	
	print('|cff74ba48BEAST MASTERY|r')
	print('|cff74ba48Please check out the ReadMe in the addon folder for proper usage.|r')
	print('|cff74ba48Health values can be toggled in the routine settings.|r')
	print('|cff74ba48Please contact Trip on Discord with any problems/suggestions.|r')
	print('|cff74ba48Suggested Talents: 1/3 - 2/1 - 3/1 - 4/2 or 3 - 5/1 - 6/1 or 3 - 7/1 or 2|r')
	print('|cff74ba48Generic Users: Hold Shift or stand close for AoE rotation')
	
		NeP.Interface:AddToggle({
			key = 'PetSummon',
			name = 'Auto Summon/Dismiss Pet',
			text = 'Auto Summon/Dismiss Pet (Pet Slot 1) when entering and leaving combat. Useful for dungeons where pets get stuck or pull unwanted crap.',
			icon = 'Interface\\Icons\\spell_nature_spiritwolf',
		})		
		
--[[		NeP.Interface:AddToggle({
			key = 'BattleRes',
			name = 'Swap to BRez Pet',
			text = 'Automatically dismiss and summon your BRez pet (Slot 2) if healer dies. Will cast BRez automatically.',
			icon = 'Interface\\Icons\\spell_nature_reincarnation',
		})		]]	
	
end

local Survival = {
--	{'Exhilaration', 'UI(s_EH_check) & player.health <= UI(s_EH_spin)'},
	{'Exhilaration', 'player.health <= UI(s_EH) & UI(s_EHc)'},
--	{'Exhilaration', 'UI(s_EP_check) & pet.health <= UI(s_EP_spin)'},
	{'Exhilaration', 'pet.health <= UI(s_EP) & UI(s_EPc)'},
--	{'Feign Death', 'UI(s_FD_check) & player.health <= UI(s_FD_spin)'},
	{'Feign Death', 'player.health <= UI(s_FD) & UI(s_FDc)'},
--	{'Aspect of the Turtle', 'UI(s_AotT_check) & player.health <= UI(s_AotT_spin)'},
	{'Aspect of the Turtle', 'player.health <= UI(s_AotT) & UI(s_AotTch)'},
--	{'/cancelaura Aspect of the Turtle', 'UI(s_AotTC_check) & player.health >= UI(s_AotTC_spin)'},	
	{'/cancelaura Aspect of the Turtle', 'player.buff(Aspect of the Turtle) & player.health >= UI(s_AotTC) & UI(s_AotTCc)'},
}

local Cooldowns = {
	{'Blood Fury'},
	{'Berserking'},
}

local Interrupts = {
	{'Counter Shot'},
}

local BRez = {
	{'Dismiss Pet', 'pet.exists & toggle(BattleRes) & !spell(Gift of Chi-Ji).exists'},
	{'83242', '!pet.exists & toggle(BattleRes)'},
	{'Gift of Chi-Ji', 'lowest(healer)'},
}

local ManualAoE = {
	{'!Kill Command', 'target.petrange <= 25 & !lastcast(Kill Command)'},
	{'!Kill Command', '!advanced & !lastcast(Kill Command)'},
	{'Mend Pet', 'pet.exists & pet.alive & pet.health < 100 & !pet.buff(Mend Pet)'},
	{'A Murder of Crows', 'talent(6,1)'},	
	{'Dire Beast', 'cooldown(Bestial Wrath).remains > 2'},
	{'Dire Frenzy', 'talent(2,2) &cooldown(Bestial Wrath).remains > 2'},
	{'Aspect of the Wild', 'player.buff(Bestial Wrath)'},	
	{'#142173', 'UI(a_KR) & player.buff(Temptation).count <= 3'},
	{'Barrage', 'talent(6,1) & player.focus > 90'},	
	{'Titan\'s Thunder', 'cooldown(Dire Beast).remains >= 3||player.buff(Bestial Wrath) & player.buff(Dire Beast)'},
	{'Bestial Wrath'},	
	{'Multi-Shot', '{pet.buff(Beast Cleave).remains < gcd.max*2||!pet.buff(Beast Cleave)}'},	
	{'Chimaera Shot', 'talent(2,3) & player.focus < 90'},	
	{'Cobra Shot', '{talent(7,2) & {cooldown(Bestial Wrath).remains >= 4 & {player.buff(Bestial Wrath) & cooldown(Kill Command).remains >= 2}||player.focus > 119}}||{!talent(7,2) & player.focus > 90}'},	
}

local ST = {	
	{'!Kill Command', 'target.petrange <= 25 & !lastcast(Kill Command)'},
	{'!Kill Command', '!advanced & !lastcast(Kill Command)'},		
	{'Volley', '!player.buff(Volley)'},
	{'Mend Pet', 'pet.exists & pet.alive & pet.health < 100 & !pet.buff(Mend Pet)'},
	{'A Murder of Crows', 'talent(6,1)'},	
	{'Dire Beast', 'cooldown(Bestial Wrath).remains > 2'},	
	{'Dire Frenzy', 'talent(2,2)&cooldown(Bestial Wrath).remains > 2'},	
	{'Aspect of the Wild', 'player.buff(Bestial Wrath)'},
	{'#142173', 'UI(a_KR) & player.buff(Temptation).count <= 3'},	
	{'Barrage', 'talent(6,1) & {target.area(15).enemies > 1||{target.area(15).enemies = 1 & player.focus > 90}}'},	
	{'Titan\'s Thunder', 'cooldown(Dire Beast).remains >= 3||player.buff(Bestial Wrath) & player.buff(Dire Beast)'},
	{'Bestial Wrath'},	
	{'Multi-Shot', 'target.area(8).enemies > 4 & {pet.buff(Beast Cleave).remains < gcd.max||!pet.buff(Beast Cleave)} & toggle(AoE)'},
	{'Multi-Shot', 'target.area(8).enemies > 1 & {pet.buff(Beast Cleave).remains < gcd.max*2||!pet.buff(Beast Cleave)} & toggle(AoE)'},
	{'Chimaera Shot', 'talent(2,3) & player.focus < 90'},
	{'/cast Cobra Shot', '{talent(7,2) & {cooldown(Bestial Wrath).remains >= 4 & {player.buff(Bestial Wrath) & cooldown(Kill Command).remains >= 2}||player.focus > 119}}||{!talent(7,2) & player.focus > 90}'},	
}

local Keybinds = {
	{'Binding Shot', 'keybind(control)', 'target.ground'},
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	--{'/startattack', '!isattacking'},
	{Keybinds},	
	{'883', '!pet.exists & toggle(PetSummon)'},	
--	{BRez, '!focus.alive'},
	{'Revive Pet', '!pet.alive'},
	{'Volley', 'talent(6,3) & !player.buff(Volley)'},	
	{Survival, '!player.buff(Feign Death)'},
	{Cooldowns, 'toggle(cooldowns)'},
	{Interrupts, 'target.interruptAt(50) & toggle(interrupts) & target.infront & target.range <= 30'},
	{ManualAoE, 'keybind(shift) & target.range < 40 & target.infront & !player.buff(Feign Death)'},
	{ST, '!keybind(shift) & target.range < 40 & target.infront & !player.buff(Feign Death)'},
}

local outCombat = {
	{Keybinds},
	{'Dismiss Pet', 'pet.exists & toggle(PetSummon) & !player.buff(Feign Death)'},
}

NeP.CR:Add(253, {
	name = '|cffFF7373[Silver]|r HUNTER - Beast Mastery',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})
