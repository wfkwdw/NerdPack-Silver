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
} 

local exeOnLoad = function()
	print('|cff74ba48MARKSMANSHIP|r')
	print('|cff74ba48Please check out the ReadMe in the addon folder for proper usage.|r')
	print('|cff74ba48Health values can be toggled in the routine settings.|r')
	print('|cff74ba48Please contact Trip on Discord with any problems/suggestions.|r')
	print('|cff74ba48Suggested Talents: 1/1 - 2/1 - 3/1 - 4/3 - 5/1 or 3 - 6/1 or 3 - 7/1 |r')
end

local Survival = {
--	{'Exhilaration', 'UI(s_EH_check) & player.health <= UI(s_EH_spin)'},
	{'Exhilaration', 'player.health <= UI(s_EH)'},
--	{'Exhilaration', 'UI(s_EP_check) & pet.health <= UI(s_EP_spin)'},
	{'Exhilaration', 'pet.health <= UI(s_EP)'},
--	{'Feign Death', 'UI(s_FD_check) & player.health <= UI(s_FD_spin)'},
	{'Feign Death', 'player.health <= UI(s_FD)'},
--	{'Aspect of the Turtle', 'UI(s_AotT_check) & player.health <= UI(s_AotT_spin)'},
	{'Aspect of the Turtle', 'player.health <= UI(s_AotT)'},
--	{'/cancelaura Aspect of the Turtle', 'UI(s_AotTC_check) & player.health >= UI(s_AotTC_spin)'},	
	{'/cancelaura Aspect of the Turtle', 'player.buff(Aspect of the Turtle) & player.health >= UI(s_AotTC)'},
}

local Cooldowns = {
	{ 'Blood Fury'},
	{ 'Berserking'},
	{ 'Trueshot'},
}

local petCare = {
	{ 'Mend Pet', '!pet.buff & pet.health <= 60', 'pet'},
}

local Interrupts = {
	{'Counter Shot'},
}

local misdirection = {
	{ 'Misdirection', '!player.buff & !focus.exists & pet.exists & player.threat = 100', 'pet'},
	{ 'Misdirection', '!player.buff & focus.exists', 'focus'},
	{ 'Misdirection', '!player.buff & tank.exists & tank.threat < 95', 'tank'},
}


local NonPatient = {	
	{'Windburst', 'target.debuff(Vulnerable) & target.debuff(Vulnerable).remains < 2'},
	{'Piercing Shot', 'target.debuff(Vulnerable) & player.focus > 90'},
	{'Black Arrow', 'target.debuff(Vulnerable).remains < 2'},
	{'Explosive Shot', 'target.debuff(Vulnerable).remains < 2||target.area > 1'},
	{'A Murder of Crows', 'target.debuff(Vulnerable).remains < 2'},
	{'Barrage', 'talent(6,2) & toggle(xBarrage)'},
	{'Sentinel', '!target.debuff(Hunter\'s Mark)'},
	{'Sidewinders', '!target.debuff.(Hunter\'s Mark)||{!player.buff(Trueshot) & !player.buff(Marking Targets)} & player.focus > 40 & {{{player.buff(Marking Targets)||player.buff(Trueshot)} & spell(Sidewinders).charges > 1.2}||spell(Sidewinders).charges > 1.8} & spell(Sentinel).cooldown < 10'},
	{'Marked Shot', 'spell(Sentinel).cooldown > 40||target.area(8) > 1'},
	{'Marked Shot', 'talent(7,1) & {{target.debuff(Vulnerable).remains < 1 & spell(Sidewinders).charges < 1.5 & player.focus < 40}||{spell(Sidewinders).charges > 1.7}}'},
	{'Marked Shot', '!talent(7,1) & target.debuff(Vulnerable).remains < 2'},
	{'Aimed Shot', 'target.debuff(Vulnerable).remains > 1.5||{player.focus > 80 & spell(Windburst).cooldown > 3}} & !{talent(7,2) & spell(Piercing Shot).cooldown < 5 & player.focus < 100 & !player.buff(Lock and Load)}'},
	{'Arcane Shot', 'target.area(8) < 2'},
	{'Multishot', 'target.area(8) > 1'},
}

local Patient = {
	{'Sidewinders', 'player.buff(Trueshot) & {target.debuff(Vulnerable).remains < 2||player.focus < 35} & {target.area(8) < 2||!target.debuff(Hunter\'s Mark)}'},
	{'Sidewinders', '!player.buff(Trueshot) & target.debuff(Vulnerable).remains < 2 & player.focus < 60 & !{target.debuff(Hunter\'s Mark)||{spell(Sidewinders).charges > 1.3 & target.area(8) < 2}}'},
	{'Sidewinders', '!target.debuff(Vulnerable) & player.buff(Marking Shot) & !target.debuff(Hunter\'s Mark)||spell(Sidewinders).charges > 1.9'},	
	{'Windburst', 'target.debuff(Vulnerable).remains < 2 & {talent(7,1)||player.focus > 60 & !{talent(7,2) & spell(Piercing Shot).cooldown < 5 & player.focus < 100 & !player.buff(Lock and Load)}}'},
	{'Black Arrow'},
	{'A Murder of Crows'},
	{'Barrage', 'talent(6,2) & toggle(xBarrage)'},
	{'Piercing Shot', 'target.debuff(Vulnerable).remains < 4 & player.focus > 80'},
	{'Marked Shot', 'target.debuff(Hunter\'s Mark) & player.buff(Marking Targets)'},	
	{'Marked Shot', '!talent(7,1) & target.area(10) > 1 & {!{talent(7,2) & spell(Piercing Shot).cooldown < 5 & player.focus < 100 & !player.buff(Lock and Load)}||target.debuff(Vulnerable)}'},
	{'Marked Shot', 'talent(7,1) & {{target.debuff(Vulnerable).remains < 2 & player.focus > 50}||target.area(10) > 1}'},
	{'Marked Shot', '!talent(7,1) & target.area(8) < 2 & target.debuff(Vulnerable).remains < 2 & {target.debuff(Hunter\'s Mark).remains < gcd||player.focus > 90}'},
	{'Aimed Shot', 'target.debuff(Vulnerable).remains > 1.7 & {player.buff(Trueshot)||player.buff(Lock and Load)} & {target.area(8) < 2||talent(7,1)} & !{talent(7,2) & spell(Piercing Shot).cooldown < 5 & player.focus < 100 & !player.buff(Lock and Load)}'},
	{'Aimed Shot', 'talent(7,1) & player.focus > 60 & !target.debuff(Hunter\'s Mark)'},
	{'Aimed Shot', 'target.debuff(Vulnerable).remains > 1.7 & !{talent(7,2) & spell(Piercing Shot).cooldown < 5 & player.focus < 100 & !player.buff(Lock and Load)}'},
	{'Aimed Shot', 'player.focus >= 100 & !{talent(7,2) & spell(Piercing Shot).cooldown < 5 & player.focus < 100 & !player.buff(Lock and Load)}'},
	{'Arcane Shot', 'player.buff(Trueshot) & target.area(8) < 2'},
	{'Multishot', 'player.buff(Trueshot) & target.area(8) > 1'},
	{'Arcane Shot', 'target.area(8) < 2 & target.debuff(Vulnerable).remains < 2||{player.debuff(Vulnerable).remains < 2}'},
	{'Multishot', 'target.area(8) > 2 & target.debuff(Vulnerable).remains < 2||{player.debuff(Vulnerable).remains < 2}'},
}


local Keybinds ={
	{'Binding Shot', 'keybind(control)', 'target.ground'},
	{'%pause', 'keybind(alt)'},
}

local inCombat = {
	{'/startattack', '!isattacking'},
	{ Keybinds},
	{ "/targetenemy [noexists]", "!target.exists" },
    { "/targetenemy [dead][noharm]", "target.dead" },
	{ 'Volley', 'talent(6,3) & !player.buff(Volley)'},	
	{ Survival, '!player.buff(Feign Death)'},
	{ Cooldowns, 'toggle(cooldowns)'},
	{ misdirection, '!player.buff(Feign Death)'},
	{ petCare, '!player.buff(Feign Death)'},
	{ Interrupts, 'target.interruptAt(50) & toggle(interrupts) & target.infront & target.range <= 30'},
	{ NonPatient, '!talent(4,3) & target.range < 40 & !player.buff(Feign Death)'},
	{ Patient, 'talent(4,3) & target.range < 40 & target.infront & !player.buff(Feign Death)'},
}

local outCombat = {
	{ Keybinds},
	{ petCare, '!player.buff(Feign Death)'},
}

NeP.CR:Add(254, {
	name = '|cffFF7373[Silver]|r HUNTER - Marksmanship',
	ic = inCombat,
	ooc = outCombat,
	gui = GUI,
	load = exeOnLoad
})