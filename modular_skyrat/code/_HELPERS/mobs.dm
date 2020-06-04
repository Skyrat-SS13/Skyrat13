/proc/random_unique_vox_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(vox_name())

		if(!findname(.))
			break

/mob/proc/isRobotic()
	return FALSE

/mob/living/carbon/human/isRobotic()
	if(dna && dna.species.inherent_biotypes & MOB_ROBOTIC)
		return TRUE
	else
		return FALSE
