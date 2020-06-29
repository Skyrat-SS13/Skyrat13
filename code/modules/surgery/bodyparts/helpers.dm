/mob/living/proc/get_bodypart(zone)
	return

/mob/living/carbon/get_bodypart(zone)
	if(!zone)
		zone = BODY_ZONE_CHEST
	for(var/X in bodyparts)
		var/obj/item/bodypart/L = X
		if(L.body_zone == zone)
			return L

/mob/living/carbon/has_hand_for_held_index(i)
	if(i >= hand_bodyparts.len)
		i = hand_bodyparts.len
	if(i)
		var/obj/item/bodypart/L = hand_bodyparts[i]
		if(L && !L.disabled)
			return L
	return FALSE

/mob/proc/has_left_hand(check_disabled = TRUE)
	return TRUE

/mob/living/carbon/has_left_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/L in hand_bodyparts)
		if(L.held_index % 2)
			if(!check_disabled || !L.disabled)
				return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_left_hand()
	return TRUE


/mob/proc/has_right_hand(check_disabled = TRUE)
	return TRUE

/mob/living/carbon/has_right_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/L in hand_bodyparts)
		if(!(L.held_index % 2))
			if(!check_disabled || !L.disabled)
				return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_right_hand()
	return TRUE

/mob/proc/has_left_leg()
	return TRUE

/mob/living/carbon/has_left_leg()
	var/obj/item/bodypart/l_leg = get_bodypart(BODY_ZONE_L_LEG)
	if(l_leg)
		return TRUE
	else
		return FALSE

/mob/proc/has_right_leg()
	return TRUE

/mob/living/carbon/has_right_leg()
	var/obj/item/bodypart/r_leg = get_bodypart(BODY_ZONE_R_LEG)
	if(r_leg)
		return TRUE
	else
		return FALSE

//Limb numbers
/mob/proc/get_num_arms(check_disabled = TRUE)
	return 2

/mob/proc/get_num_hands(check_disabled = TRUE)
	return 2

/mob/living/carbon/get_num_arms(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == ARM_RIGHT)
			if(!check_disabled || !affecting.disabled)
				.++
		if(affecting.body_part == ARM_LEFT)
			if(!check_disabled || !affecting.disabled)
				.++

/mob/living/carbon/get_num_hands(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == HAND_RIGHT)
			if(!check_disabled || !affecting.disabled)
				.++
		if(affecting.body_part == HAND_LEFT)
			if(!check_disabled || !affecting.disabled)
				.++

//sometimes we want to ignore that we don't have the required amount of arms.
/mob/proc/get_arm_ignore()
	return 0

/mob/living/carbon/alien/larva/get_arm_ignore()
	return 1 //so we can still handcuff larvas.


/mob/proc/get_num_legs(check_disabled = TRUE)
	return 2

/mob/proc/get_num_feet(check_disabled = TRUE)
	return 2

/mob/living/carbon/get_num_legs(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == LEG_RIGHT)
			if(!check_disabled || !affecting.disabled)
				.++
		if(affecting.body_part == LEG_LEFT)
			if(!check_disabled || !affecting.disabled)
				.++

/mob/living/carbon/get_num_feet(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == FOOT_RIGHT)
			if(!check_disabled || !affecting.disabled)
				.++
		if(affecting.body_part == FOOT_LEFT)
			if(!check_disabled || !affecting.disabled)
				.++

//sometimes we want to ignore that we don't have the required amount of legs.
/mob/proc/get_leg_ignore()
	return FALSE

/mob/proc/get_feet_ignore()
	return FALSE

/mob/living/carbon/get_leg_ignore()
	if(movement_type & (FLYING|FLOATING))
		return TRUE
	return FALSE

/mob/living/carbon/get_feet_ignore()
	if(movement_type & (FLYING|FLOATING))
		return TRUE
	return FALSE

/mob/living/carbon/alien/larva/get_leg_ignore()
	return TRUE

/mob/living/carbon/alien/larva/get_feet_ignore()
	return TRUE

/mob/living/proc/get_missing_limbs()
	return list()

/mob/living/carbon/get_missing_limbs()
	var/list/full = ALL_BODYPARTS //skyrat edit
	for(var/zone in full)
		if(get_bodypart(zone))
			full -= zone
	return full

/mob/living/carbon/alien/larva/get_missing_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	for(var/zone in full)
		if(get_bodypart(zone))
			full -= zone
	return full

/mob/living/proc/get_disabled_limbs()
	return list()

/mob/living/carbon/get_disabled_limbs()
	var/list/full = ALL_BODYPARTS //skyrat edit
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting && affecting.disabled)
			disabled += zone
	return disabled

/mob/living/carbon/alien/larva/get_disabled_limbs()
	var/list/full = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	var/list/disabled = list()
	for(var/zone in full)
		var/obj/item/bodypart/affecting = get_bodypart(zone)
		if(affecting && affecting.disabled)
			disabled += zone
	return disabled

///Remove all embedded objects from all limbs on the carbon mob
/mob/living/carbon/proc/remove_all_embedded_objects()
	/* skyrat edit
	var/turf/T = get_turf(src)
	*/
	for(var/X in bodyparts)
		var/obj/item/bodypart/L = X
		for(var/obj/item/I in L.embedded_objects)
			/* skyrat edit
			L.embedded_objects -= I
			I.forceMove(T)
			I.unembedded()
			*/
			remove_embedded_object(I)

	clear_alert("embeddedobject")
	SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "embedded")

/mob/living/carbon/proc/has_embedded_objects(include_harmless=FALSE) //skyrat edit
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/L = X
		for(var/obj/item/I in L.embedded_objects)
			//skyrat edit
			if(!include_harmless && I.isEmbedHarmless())
				continue
			return TRUE
			//

//skyrat edit help
///Remove a specific embedded item from the carbon mob
/mob/living/carbon/proc/remove_embedded_object(obj/item/I)
	SEND_SIGNAL(src, COMSIG_CARBON_EMBED_REMOVAL, I)
//

//Helper for quickly creating a new limb - used by augment code in species.dm spec_attacked_by
/mob/living/carbon/proc/newBodyPart(zone, robotic, fixed_icon)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_L_ARM)
			L = new /obj/item/bodypart/l_arm()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_HAND)
			L = new /obj/item/bodypart/l_hand()
		//
		if(BODY_ZONE_R_ARM)
			L = new /obj/item/bodypart/r_arm()
		//skyrat edit
		if(BODY_ZONE_PRECISE_R_HAND)
			L = new /obj/item/bodypart/r_hand()
		//
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head()
		if(BODY_ZONE_L_LEG)
			L = new /obj/item/bodypart/l_leg()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_FOOT)
			L = new /obj/item/bodypart/l_foot()
		//
		if(BODY_ZONE_R_LEG)
			L = new /obj/item/bodypart/r_leg()
		//skyrat edit
		if(BODY_ZONE_PRECISE_R_FOOT)
			L = new /obj/item/bodypart/r_foot()
		//
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest()
		//skyrat edit
		if(BODY_ZONE_PRECISE_GROIN)
			L = new /obj/item/bodypart/groin()
		//
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYPART_ROBOTIC)
			L.body_markings = null
	. = L

/mob/living/carbon/monkey/newBodyPart(zone, robotic, fixed_icon)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_L_ARM)
			L = new /obj/item/bodypart/l_arm/monkey()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_HAND)
			L = new /obj/item/bodypart/l_hand/monkey()
		//
		if(BODY_ZONE_R_ARM)
			L = new /obj/item/bodypart/r_arm/monkey()
		//skyrat edit
		if(BODY_ZONE_PRECISE_R_HAND)
			L = new /obj/item/bodypart/r_hand/monkey()
		//
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head/monkey()
		if(BODY_ZONE_L_LEG)
			L = new /obj/item/bodypart/l_leg/monkey()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_FOOT)
			L = new /obj/item/bodypart/l_foot/monkey()
		//
		if(BODY_ZONE_R_LEG)
			L = new /obj/item/bodypart/r_leg/monkey()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_FOOT)
			L = new /obj/item/bodypart/r_foot/monkey()
		//
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest/monkey()
		//skyrat edit
		if(BODY_ZONE_PRECISE_GROIN)
			L = new /obj/item/bodypart/groin/monkey()
		//
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYPART_ROBOTIC)
	. = L

/mob/living/carbon/alien/larva/newBodyPart(zone, robotic, fixed_icon)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head/larva()
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest/larva()
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYPART_ROBOTIC)
	. = L

/mob/living/carbon/alien/humanoid/newBodyPart(zone, robotic, fixed_icon)
	var/obj/item/bodypart/L
	switch(zone)
		if(BODY_ZONE_L_ARM)
			L = new /obj/item/bodypart/l_arm/alien()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_HAND)
			L = new /obj/item/bodypart/l_hand/alien()
		//
		if(BODY_ZONE_R_ARM)
			L = new /obj/item/bodypart/r_arm/alien()
		//skyrat edit
		if(BODY_ZONE_PRECISE_R_HAND)
			L = new /obj/item/bodypart/r_hand/alien()
		//
		if(BODY_ZONE_HEAD)
			L = new /obj/item/bodypart/head/alien()
		if(BODY_ZONE_L_LEG)
			L = new /obj/item/bodypart/l_leg/alien()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_FOOT)
			L = new /obj/item/bodypart/l_foot/alien()
		//
		if(BODY_ZONE_R_LEG)
			L = new /obj/item/bodypart/r_leg/alien()
		//skyrat edit
		if(BODY_ZONE_PRECISE_L_FOOT)
			L = new /obj/item/bodypart/r_foot/alien()
		//
		if(BODY_ZONE_CHEST)
			L = new /obj/item/bodypart/chest/alien()
		//skyrat edit
		if(BODY_ZONE_PRECISE_GROIN)
			L = new /obj/item/bodypart/groin/alien()
		//
	if(L)
		L.update_limb(fixed_icon, src)
		if(robotic)
			L.change_bodypart_status(BODYPART_ROBOTIC)
	. = L

/mob/living/carbon/proc/Digitigrade_Leg_Swap(swap_back)
	for(var/X in bodyparts)
		var/obj/item/bodypart/O = X
		if((O.body_part == LEG_LEFT || O.body_part == LEG_RIGHT || O.body_part == FOOT_RIGHT || O.body_part == FOOT_LEFT) && ((!O.use_digitigrade && !swap_back) || (O.use_digitigrade && swap_back))) //skyrat edit
			O.use_digitigrade = swap_back ? NOT_DIGITIGRADE : FULL_DIGITIGRADE
			O.update_limb(FALSE, src)

	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.w_uniform)
			H.update_inv_w_uniform()
		if(H.shoes)
			H.update_inv_shoes()
		if(H.wear_suit)
			H.update_inv_wear_suit()

/mob/living/carbon/proc/get_body_parts_flags()
	for(var/X in bodyparts)
		var/obj/item/bodypart/L = X
		switch(L.body_part)
			//skyrat edit on all of this pretty much
			if(CHEST)
				. |= CHEST
			if(GROIN)
				. |= GROIN
			if(LEG_LEFT)
				. |= LEG_LEFT
			if(LEG_RIGHT)
				. |= LEG_RIGHT
			if(FOOT_LEFT)
				. |= FOOT_LEFT
			if(FOOT_RIGHT)
				. |= FOOT_RIGHT
			if(ARM_LEFT)
				. |= ARM_LEFT
			if(ARM_RIGHT)
				. |= ARM_RIGHT
			if(HAND_LEFT)
				. |= HAND_LEFT
			if(HAND_RIGHT)
				. |= HAND_RIGHT
			//
		. |= L.body_part

///Get the bodypart for whatever hand we have active, Only relevant for carbons
/mob/proc/get_active_hand()
	return FALSE

/mob/living/carbon/get_active_hand()
	var/which_hand = BODY_ZONE_PRECISE_L_HAND
	if(!(active_hand_index % 2))
		which_hand = BODY_ZONE_PRECISE_R_HAND
	return get_bodypart(check_zone(which_hand))
