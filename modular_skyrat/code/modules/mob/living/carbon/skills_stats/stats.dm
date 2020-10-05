//All of the stat datums used ingame

//Strength
/datum/stats/str
	name = "Strength"
	shorthand = "ST"
	
//Endurance
/datum/stats/end
	name = "Endurance"
	shorthand = "EN"

/datum/stats/proc/get_shock_mult() //this is stupid
	return 1

/datum/stats/end/get_shock_mult()
	return round(1.25 - (0.5 * level/MAX_STAT), 0.1) //Varies from 1.25 to 0.75 depending on how good/bad we are

//Dexterity
/datum/stats/dex
	name = "Dexterity"
	shorthand = "DX"

/datum/stats/dex/proc/get_ran_zone_prob()
	return 50 + (50 * level/MAX_STAT)

/datum/stats/dex/proc/get_click_mod()
	return round(1.25 - (0.5 * level/MAX_STAT), 0.1) //Varies from 1.25 to 0.75 depending on how good/bad we are

/datum/stats/dex/proc/get_base_miss_chance()
	return (20 - level)

/datum/stats/dex/proc/get_miss_stamina_mult()
	return round(1.5 - (level/MAX_STAT), 0.1)

/datum/stats/dex/proc/get_disarm_mult()
	return round(max(2 - (level/MAX_STAT * 2), 0.1))

//Intelligence
/datum/stats/int
	name = "Intelligence"
	shorthand = "IT"
