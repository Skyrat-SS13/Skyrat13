/mob/living/carbon/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	if(HAS_TRAIT(src, TRAIT_TOXIMMUNE)) //Prevents toxin damage, but not healing
		amount = min(amount, 0)
	return ..()

/mob/living/carbon/proc/getCurrentOrgans()
	. = list()
	for(var/obj/item/organ/O in internal_organs)
		. += O

/mob/living/carbon/proc/getOrgans()
	. = list()
	for(var/obj/item/organ/O in initial(internal_organs))
		. += O

/mob/living/carbon/proc/getMissingOrgans()
	var/list/current = getCurrentOrgans()
	var/list/missing = getOrgans()
	for(var/obj/item/organ/O in current)
		if(O.type in missing)
			missing -= O.type
	. = missing

/mob/living/carbon/adjustCloneLoss(amount, updating_health = TRUE, forced = FALSE)
	if(HAS_TRAIT(src, TRAIT_CLONEIMMUNE)) //Prevents bleed damage, but not healing
		amount = min(amount, 0)
	return ..()
