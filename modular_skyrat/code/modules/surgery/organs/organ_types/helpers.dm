/mob/proc/getorgan(typepath)
	return

/mob/proc/getorganszone(zone)
	return

/mob/proc/getorganslot(slot)
	return

/mob/living/carbon/getorgan(typepath)
	return (locate(typepath) in internal_organs)

/mob/living/carbon/getorganszone(zone, subzones = 0)
	. = list()
	if(subzones)
		// Include subzones - groin for chest, eyes and mouth for head
		if(zone == BODY_ZONE_HEAD)
			. |= getorganszone(BODY_ZONE_PRECISE_EYES)
			. |= getorganszone(BODY_ZONE_PRECISE_MOUTH)
		/* skyrat edit
		if(zone == BODY_ZONE_CHEST)
			. |= getorganszone(BODY_ZONE_PRECISE_GROIN)
		*/

	for(var/X in internal_organs)
		var/obj/item/organ/O = X
		if(zone == O.zone)
			. |= O

/mob/living/carbon/getorganslot(slot)
	return internal_organs_slot[slot]
