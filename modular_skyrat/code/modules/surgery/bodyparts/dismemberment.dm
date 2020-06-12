/mob/living/carbon/regenerate_limb(limb_zone, noheal)
	var/obj/item/bodypart/L
	if(get_bodypart(limb_zone))
		return 0
	L = newBodyPart(limb_zone, 0, 0)
	if(L)
		if(!noheal)
			L.brute_dam = 0
			L.burn_dam = 0
			L.brutestate = 0
			L.burnstate = 0

		var/mob/living/carbon/human/H = src
		if(H.dna && H.dna.species && (ROBOTIC_LIMBS in H.dna.species.species_traits))
			L.change_bodypart_status(BODYPART_ROBOTIC)
			L.render_like_organic = TRUE

		L.attach_limb(src, 1)
		return 1 