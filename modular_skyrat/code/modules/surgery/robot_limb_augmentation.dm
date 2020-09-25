//ACTUAL SURGERIES
/datum/surgery/augmentation/mechanical
	name = "Mechanical augmentation"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_unwrench,
				/datum/surgery_step/replace_limb)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = ALL_BODYPARTS //skyrat edit
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ROBOTIC
