//Stats
//Every carbon mob by default starts with average stats at everything
//No XP system because stats are something you're pretty much stuck with
/datum/stats
	var/name = "Generic stat"
	var/level = START_STAT //Level, used in stat calculations.
	var/shorthand = "SH" //Shorthand

/datum/stats/proc/statnumtodesc(stat)
	switch(stat)
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
