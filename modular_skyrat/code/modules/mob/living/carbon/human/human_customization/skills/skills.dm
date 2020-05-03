//Defines for levels
#define SKILL_UNSKILLED 1
#define SKILL_BASIC 2
#define SKILL_TRAINED 3
#define SKILL_EXPERIENCED 4
#define SKILL_MASTER 5

/datum/skill
	var/name = "Skill"
	var/desc = "Skill's description."
	var/id = 0
	var/cat_id = 0
	var/difficulty = 2
	var/default_max = SKILL_EXPERIENCED

//Guess you could change those procs to feed off of variable lists in the skill.. but is that more efficient? Won't interfere with how they get saved anyway
/datum/skill/proc/get_cost(level)
	switch(level)
		if(SKILL_BASIC, SKILL_TRAINED)
			return difficulty
		if(SKILL_EXPERIENCED, SKILL_MASTER)
			return difficulty+1
		else
			return 0

/datum/skill/proc/get_level_name(level)
	switch(level)
		if(SKILL_UNSKILLED)
			return "Unskilled"
		if(SKILL_BASIC)
			return "Basic"
		if(SKILL_TRAINED)
			return "Trained"
		if(SKILL_EXPERIENCED)
			return "Experienced"
		if(SKILL_MASTER)
			return "Master"
		else
			return "Something went wrong"

/datum/skill/proc/get_level_desc(level)
	switch(level)
		if(SKILL_UNSKILLED)
			return "Description for unskilled level"
		if(SKILL_BASIC)
			return "Description for basic level"
		if(SKILL_TRAINED)
			return "Description for trained level"
		if(SKILL_EXPERIENCED)
			return "Description for experienced level"
		if(SKILL_MASTER)
			return "Description for master level"
		else
			return "Something went wrong"

/datum/skill/proc/get_change_cost(current, target)
	if(current == target)
		return 0

	var/diff = current - target
	var/spending = FALSE
	if(diff < 0)
		spending = TRUE
		diff = abs(diff)

	var/total = 0
	for(var/i in 1 to diff)
		if(spending)
			total = total + get_cost(current + i)
		else
			total = total + get_cost(current - i)

	if(!spending)
		total = -total

	return total

/***********************************************************/
/******************ACTUAL SKILLS DOWN THERE*****************/
/***********************************************************/
//Defines for skill ID's
#define SKILL_EVA "eva"

#define SKILL_LEADERSHIP "leadership"

#define SKILL_ATMOS "atmos"
#define SKILL_CONSTRUCTION "construction"
#define SKILL_ELECTRICAL "electricial"

#define SKILL_ANATOMY "anatony"
#define SKILL_MEDICINE "medicine"
#define SKILL_CHEMISTRY "chemistry"

#define SKILL_SCIENCE "science"
#define SKILL_COMPLEX_DEVICES "complex devices"

#define SKILL_CLOSE_COMBAT "close combat"
#define SKILL_WEAPONS_EXPERTISE "weapons expertise"
#define SKILL_FORENSICS "forensics"

#define SKILL_BOTANY "botany"
#define SKILL_COOKING "cooking"

/************GENERAL**************/

/datum/skill/eva
	name = "Extra-Vehicular Activity"
	desc = "EVA's description."
	id = SKILL_EVA
	cat_id = SKILL_CAT_GENERAL

/************ORGANIZATIONAL**************/

/datum/skill/leadership
	name = "Leadership"
	desc = "Leader's description."
	id = SKILL_LEADERSHIP
	cat_id = SKILL_CAT_ORGANIZATIONAL

/************ENGINEERING**************/

/datum/skill/atmos
	name = "Atmospherics"
	desc = "Atmo's description."
	id = SKILL_ATMOS
	cat_id = SKILL_CAT_ENGINEERING

/datum/skill/construction
	name = "Construction"
	desc = "const's description."
	id = SKILL_CONSTRUCTION
	cat_id = SKILL_CAT_ENGINEERING

/datum/skill/electrical
	name = "Electrical Engineering"
	desc = "Elec's description."
	id = SKILL_ELECTRICAL
	cat_id = SKILL_CAT_ENGINEERING

/************MEDICAL**************/

/datum/skill/anatomy
	name = "Anatomy"
	desc = "anat's description."
	id = SKILL_ANATOMY
	cat_id = SKILL_CAT_MEDICAL

/datum/skill/medicine
	name = "Medicine"
	desc = "medicine's description."
	id = SKILL_MEDICINE
	cat_id = SKILL_CAT_MEDICAL

/datum/skill/chemistry
	name = "Chemistry"
	desc = "Chem's description."
	id = SKILL_CHEMISTRY
	cat_id = SKILL_CAT_MEDICAL

/************RESEARCH**************/

/datum/skill/science
	name = "Science"
	desc = "Science's description."
	id = SKILL_SCIENCE
	cat_id = SKILL_CAT_RESEARCH

/datum/skill/complex_devices
	name = "Complex Devices"
	desc = "comp's description."
	id = SKILL_COMPLEX_DEVICES
	cat_id = SKILL_CAT_RESEARCH

/************SECURITY**************/

/datum/skill/close_combat
	name = "Close Combat"
	desc = "CC's description."
	id = SKILL_CLOSE_COMBAT
	cat_id = SKILL_CAT_SECURITY

/datum/skill/weapons_expertise
	name = "Weapons Expertise"
	desc = "WE's description."
	id = SKILL_WEAPONS_EXPERTISE
	cat_id = SKILL_CAT_SECURITY

/datum/skill/forensics
	name = "Forensics"
	desc = "Forensics description."
	id = SKILL_FORENSICS
	cat_id = SKILL_CAT_SECURITY

/************SERVICE**************/

/datum/skill/botany
	name = "Botany"
	desc = "botany's description."
	id = SKILL_BOTANY
	cat_id = SKILL_CAT_SERVICE

/datum/skill/cooking
	name = "Cooking"
	desc = "Cooking description."
	id = SKILL_COOKING
	cat_id = SKILL_CAT_SERVICE