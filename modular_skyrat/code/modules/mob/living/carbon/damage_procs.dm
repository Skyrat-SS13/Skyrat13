/mob/living/carbon/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	if(HAS_TRAIT(src, TRAIT_TOXIMMUNE)) //Prevents toxin damage, but not healing
		amount = min(amount, 0)
	return ..()