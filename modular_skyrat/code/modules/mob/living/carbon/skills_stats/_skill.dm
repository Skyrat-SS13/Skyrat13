//Skills
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
/datum/skills/proc/get_generic_modifier(default = 1, diminutive = TRUE)
	var/modifier = default
	if(diminutive)
		modifier = max(0.1, round(modifier - level/MAX_SKILL))
	else
		modifier = min(2, modifier + (modifier * round(modifier - level/MAX_SKILL)))
	return modifier

//Return a string related to our competence in the given skill
/datum/skills/proc/skillnumtodesc(skill)
	switch(skill)
		if(1)
			return "completely worthless"
		if(2)
			return "incompetent"
		if(3)
			return "a novice"
		if(4)
			return "unskilled"
		if(5)
			return "good enough"
		if(6)
			return "adept"
		if(7)
			return "versed"
		if(8)
			return "an expert"
		if(9)
			return "a master"
		if(10)
			return "legendary"
		else
			return "inhuman"

/datum/skills/melee
	name = "Melee"

/datum/skills/ranged
	name = "Ranged"

/datum/skills/firstaid
	name = "First aid"

/datum/skills/surgery
	name = "Surgery"

/datum/skills/chemistry
	name = "Chemistry"

/datum/skills/engineering
	name = "Engineering"
