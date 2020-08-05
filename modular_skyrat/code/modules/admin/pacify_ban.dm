/mob/living/carbon/human/proc/update_pacification_ban()
	if(client)
		if(jobban_isbanned(src, COLLARBAN) && !(has_trauma_type(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_ABSOLUTE)))
			gain_trauma_type(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_ABSOLUTE)
		else if (has_trauma_type(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_ABSOLUTE))
			cure_trauma_type(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_ABSOLUTE)
	else
		return FALSE

/datum/job/after_spawn(mob/living/H, mob/M)
	. = ..()
	if(jobban_isbanned(M, COLLARBAN) && ishuman(H))
		var/mob/living/carbon/human/E = H
		E.update_pacification_ban()