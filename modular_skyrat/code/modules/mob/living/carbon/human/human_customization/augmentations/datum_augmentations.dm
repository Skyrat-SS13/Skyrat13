#define ATTRIBUTE_STRENGTH 1
#define ATTRIBUTE_DEXTERITY 2
#define ATTRIBUTE_AGILITY 3
#define ATTRIBUTE_CONSTITUTION 4
#define ATTRIBUTE_INTELLIGENCE 5

/datum/augmentation
	var/name = "Augmentation."
	var/desc = "Basic augmentation, you are not supposed to see this. Report to admins."
	var/id = 0
	var/cost = 0
	var/affecting_zone = BODY_ZONE_R_ARM

/datum/augmentation/proc/get_cost()
	return cost

/datum/augmentation/proc/apply_to_mob(mob)
	var/mob/living/carbon/human/H = mob
	return TRUE