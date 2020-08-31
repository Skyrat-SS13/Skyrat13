#define BLURRY_VISION_ONE	1
#define BLURRY_VISION_TWO	2
#define BLIND_VISION_THREE	3

/obj/item/organ/eyes
	name = BODY_ZONE_PRECISE_EYES
	icon_state = "eyeballs"
	desc = "I see you!"
	zone = BODY_ZONE_PRECISE_EYES
	slot = ORGAN_SLOT_EYES
	gender = PLURAL

	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY
	maxHealth = 0.5 * STANDARD_ORGAN_THRESHOLD		//half the normal health max since we go blind at 30, a permanent blindness at 50 therefore makes sense unless medicine is administered
	high_threshold = 0.3 * STANDARD_ORGAN_THRESHOLD	//threshold at 30
	low_threshold = 0.2 * STANDARD_ORGAN_THRESHOLD	//threshold at 15

	low_threshold_passed = "<span class='info'>Distant objects become somewhat less tangible.</span>"
	high_threshold_passed = "<span class='info'>Everything starts to look a lot less clear.</span>"
	now_failing = "<span class='warning'>Darkness envelopes you, as your eyes go blind!</span>"
	now_fixed = "<span class='info'>Color and shapes are once again perceivable.</span>"
	high_threshold_cleared = "<span class='info'>Your vision functions passably once more.</span>"
	low_threshold_cleared = "<span class='info'>Your vision is cleared of any ailment.</span>"

	var/sight_flags = 0
	var/see_in_dark = 2
	var/tint = 0
	var/eye_color = "" //set to a hex code to override a mob's eye color
	var/old_eye_color = "fff"
	var/flash_protect = 0
	var/see_invisible = SEE_INVISIBLE_LIVING
	var/lighting_alpha
	var/eye_damaged	= FALSE	//indicates that our eyes are undergoing some level of negative effect

/obj/item/organ/eyes/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = FALSE)
	. = ..()
	if(!.)
		return
	switch(eye_damaged)
		if(BLURRY_VISION_ONE, BLURRY_VISION_TWO)
			owner.overlay_fullscreen("eye_damage", /obj/screen/fullscreen/impaired, eye_damaged)
		if(BLIND_VISION_THREE)
			owner.become_blind(EYE_DAMAGE)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		old_eye_color = H.eye_color
		if(eye_color)
			H.eye_color = eye_color
		else
			eye_color = H.eye_color
		if(!special)
			H.dna?.species?.handle_body(H) //regenerate eyeballs overlays.
	M.update_tint()
	owner.update_sight()

/obj/item/organ/eyes/Remove(special = FALSE)
	. = ..()
	var/mob/living/carbon/C = .
	if(QDELETED(C))
		return
	switch(eye_damaged)
		if(BLURRY_VISION_ONE, BLURRY_VISION_TWO)
			C.clear_fullscreen("eye_damage")
		if(BLIND_VISION_THREE)
			C.cure_blind(EYE_DAMAGE)
	if(ishuman(C) && eye_color)
		var/mob/living/carbon/human/H = C
		H.eye_color = old_eye_color
		if(!special)
			H.dna.species.handle_body(H)
	if(!special)
		C.update_tint()
		C.update_sight()

/obj/item/organ/eyes/applyOrganDamage(d, maximum = maxHealth)
	. = ..()
	if(!.)
		return
	var/old_damaged = eye_damaged
	switch(damage)
		if(INFINITY to maxHealth)
			eye_damaged = BLIND_VISION_THREE
		if(maxHealth to high_threshold)
			eye_damaged = BLURRY_VISION_TWO
		if(high_threshold to low_threshold)
			eye_damaged = BLURRY_VISION_ONE
		else
			eye_damaged = FALSE
	if(eye_damaged == old_damaged || !owner)
		return
	if(old_damaged == BLIND_VISION_THREE)
		owner.cure_blind(EYE_DAMAGE)
	else if(eye_damaged == BLIND_VISION_THREE)
		owner.become_blind(EYE_DAMAGE)
	if(eye_damaged && eye_damaged != BLIND_VISION_THREE)
		owner.overlay_fullscreen("eye_damage", /obj/screen/fullscreen/impaired, eye_damaged)
	else
		owner.clear_fullscreen("eye_damage")

#undef BLURRY_VISION_ONE
#undef BLURRY_VISION_TWO
#undef BLIND_VISION_THREE
