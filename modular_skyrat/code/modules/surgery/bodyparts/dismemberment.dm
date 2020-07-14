/mob/living/carbon/regenerate_limb(limb_zone, noheal, ignore_parent_restriction) //skyrat edit
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
		if(istype(H) && (ROBOTIC_LIMBS in H.dna?.species?.species_traits))
			L.change_bodypart_status(BODYPART_ROBOTIC)
			L.render_like_organic = TRUE
		
		L.attach_limb(src, 1, ignore_parent_restriction) //skyrat edit
		var/datum/scar/S = new
		var/datum/wound/loss/phantom_loss = new // stolen valor, really
		S.generate(L, phantom_loss)
		QDEL_NULL(phantom_loss)
		return 1
