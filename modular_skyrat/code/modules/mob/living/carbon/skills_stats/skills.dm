//All of the skill datums used ingame
/datum/skills/melee
	name = "Melee Combat"

/datum/skills/ranged
	name = "Ranged Combat"

/datum/skills/firstaid
	name = "First Aid"

/datum/skills/firstaid/proc/get_medicalstack_mod()
	return clamp((MAX_SKILL/2)/max(1, level), 0.5, 4)

/datum/skills/surgery
	name = "Surgery"

/datum/skills/surgery/proc/no_anesthesia_punishment()
	return (0.2 + round(0.6 * MAX_SKILL/max(1, level), 0.1))

/datum/skills/surgery/proc/get_speed_mod()
	return clamp((MAX_SKILL/2)/max(1, level), 0.35, 2.5)

/datum/skills/surgery/proc/get_probability_mod()
	return clamp((MAX_SKILL/2)/max(1, level), 0.3, 2.5)

/datum/skills/chemistry
	name = "Chemistry"

/datum/skills/construction
	name = "Construction"

/datum/skills/electronics
	name = "Electronics"

/datum/skills/research
	name = "Research"

/datum/skills/cooking
	name = "Cooking"

/datum/skills/agriculture
	name = "Agriculture"

/datum/skills/gaming
	name = "Gaming"
