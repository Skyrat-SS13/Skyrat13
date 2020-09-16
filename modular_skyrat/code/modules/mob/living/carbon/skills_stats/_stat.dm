//Stats
//Every carbon mob by default starts with average stats at everything
//No XP system because stats are something you're pretty much stuck with
/datum/stats
	var/name = "Generic stat"
	var/level = START_STAT //Level, used in stat calculations.
	var/shorthand = "SH" //Shorthand

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
