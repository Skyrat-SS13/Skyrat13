//Stats
//Every carbon mob by default starts with average stats at everything
//No XP system because stats are something you're pretty much stuck with
/datum/stats
	var/name = "Generic stat" //Name of the stat
	var/desc = "Makes you better at doing things vague things." //Description of the stat
	var/level = START_STAT //Level, used in stat calculations.
	var/shorthand = "SH" //Shorthand

//An all purpose proc for getting a multiplicative modifier
//Create new specific subtype procs for more careful handling, this is for simple dumb tasks
//Should use the carbon mob diceroll or get_skill_mod procs if you need to take mood and stamina into account
/datum/stats/proc/get_generic_modifier(default = 1, diminutive = TRUE)
	var/modifier = default
	if(diminutive)
		modifier = max(0.1, round(modifier - level/MAX_STAT))
	else
		modifier = min(2, modifier + (modifier * round(modifier - level/MAX_STAT)))
	return modifier

/datum/stats/proc/statnumtodesc(stat)
	switch(stat)
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
		else
			return "inhuman"

/datum/stats/str
	name = "Strength"
	shorthand = "ST"
	
/datum/stats/end
	name = "Endurance"
	shorthand = "ED"

/datum/stats/dex
	name = "Dexterity"
	shorthand = "DX"

/datum/stats/int
	name = "Intelligence"
	shorthand = "IT"
