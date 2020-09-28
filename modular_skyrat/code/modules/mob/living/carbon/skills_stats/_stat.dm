//Stats
//Code shamelessly stolen from IS12 warfare, thanks based Mattroks
//Every carbon mob by default starts with average stats at everything
//No XP system because stats are something you're pretty much stuck with
/datum/stats
	var/name = "Generic stat" //Name of the stat
	var/desc = "Makes you better at doing vague things." //Description of the stat
	var/level = START_STAT //Level, used in stat calculations.
	var/shorthand = "SH" //Shorthand

//An all purpose proc for getting a multiplicative modifier
//Create new specific subtype procs for more careful handling, this is for simple dumb tasks
//Should use the carbon mob diceroll or get_skill_mod procs if you need to take mood and stamina into account
/datum/stats/proc/get_generic_modifier(default = 1, diminutive = TRUE, sum = 0)
	var/modifier = default
	if(diminutive)
		modifier = max(default * 0.1, round(modifier * level/MAX_STAT))
	else
		modifier = min(default * 2, modifier + (modifier * level/MAX_STAT))
	modifier += sum
	return modifier

//Return a string related to our competence in the given stat
/datum/stats/proc/statnumtodesc(stat)
	switch(stat)
		if(-INFINITY to 6)
			return "crippling"
		if(7)
			return "poor"
		if(8,9)
			return "below average"
		if(10)
			return "average"
		if(11,12)
			return "above average"
		if(13,14)
			return "exceptional"
		if(15,16)
			return "amazing"
		if(17,18)
			return "legendary"
		if(19,20)
			return "mythic"
		if(21 to INFINITY)
			return "superhuman"
		else
			return "inhuman"
