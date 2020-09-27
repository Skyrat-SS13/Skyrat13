//All of the stat datums used ingame

//Strength
/datum/stats/str
	name = "Strength"
	shorthand = "ST"
	
//Endurance
/datum/stats/end
	name = "Endurance"
	shorthand = "EN"

//Dexterity
/datum/stats/dex
	name = "Dexterity"
	shorthand = "DX"

/datum/stats/dex/proc/get_click_mod()
	return round(1.25 - (0.5 * level/MAX_STAT), 0.1) //Varies from 1.25 to 0.75 depending on how good/bad we are

//Intelligence
/datum/stats/int
	name = "Intelligence"
	shorthand = "IT"

//Luck
/datum/stats/luck
	name = "Luck"
	shorthand = "LK"
