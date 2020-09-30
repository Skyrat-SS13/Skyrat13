//All of the skill datums used ingame
/datum/skills/melee
	name = "Melee Combat"

/datum/skills/ranged
	name = "Ranged Combat"

/datum/skills/firstaid
	name = "First Aid"

/datum/skills/firstaid/proc/get_medicalstack_mod()
	return ((MAX_SKILL/2)/level)

/datum/skills/surgery
	name = "Surgery"

/datum/skills/surgery/proc/no_anesthesia_punishment()
	return (0.2 + (0.6 * MAX_SKILL/level))

/datum/skills/surgery/proc/get_speed_mod()
	return ((MAX_SKILL/2)/level)

/datum/skills/surgery/proc/get_probability_mod()
	return ((MAX_SKILL/2)/level)

/datum/skills/chemistry
	name = "Chemistry"

/datum/skills/construction
	name = "Construction"

/datum/skills/electronics
	name = "Electronics"

/datum/skills/gaming
	name = "Gaming"
