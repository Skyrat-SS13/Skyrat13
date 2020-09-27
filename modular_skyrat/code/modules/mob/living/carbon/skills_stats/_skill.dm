//Skills
//Code shamelessly stolen from IS12 warfare, thanks based Mattroks
//Every carbon mob by default starts with average skills at everything
/datum/skills
	var/name = "Generic skill" // Name of the skill
	var/desc = "Makes you better at doing non-vague things." //Description of the skill
	var/level = START_SKILL // What the value is, used in skill checks
	var/xp = 0 // Current xp amount, once we reach level_up_req we level up and reset to 0
	var/level_up_req = SKILL_LVL_REQUIREMENT // How much xp we need before levelling up

//An all purpose proc for getting a multiplicative modifier
//Create new specific subtype procs for more careful handling, this is for simple dumb tasks
//Should use the carbon mob diceroll or get_skill_mod procs if you need to take mood and stamina into account
/datum/skills/proc/get_generic_modifier(default = 1, diminutive = TRUE, sum = 0)
	var/modifier = default
	if(diminutive)
		modifier = max(default * 0.1, round(modifier * level/MAX_SKILL))
	else
		modifier = min(default * 2, modifier + (modifier * level/MAX_SKILL))
	modifier += sum
	return modifier

//Return a string related to our competence in the given skill
/datum/skills/proc/skillnumtodesc(skill)
	switch(skill)
		if(-INFINITY to 0)
			return "unsalvageable"
		if(1,2)
			return "completely worthless"
		if(3,4)
			return "incompetent"
		if(5,6)
			return "a novice"
		if(7,8)
			return "unskilled"
		if(9,10)
			return "good enough"
		if(11,12)
			return "adept"
		if(13,14)
			return "versed"
		if(15,16)
			return "an expert"
		if(17,18)
			return "a master"
		if(19,20)
			return "legendary"
		if(21 to INFINITY)
			return "godlike"
		else
			return "inhuman"
