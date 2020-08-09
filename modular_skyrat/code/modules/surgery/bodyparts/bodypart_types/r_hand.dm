/obj/item/bodypart/r_hand
	name = "right hand"
	desc = "It probably wasn't the right hand."
	icon_state = "default_human_r_hand"
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_PRECISE_R_HAND
	body_part = HAND_RIGHT
	held_index = 2
	px_x = 6
	px_y = -3
	stam_heal_tick = 4
	parent_bodyzone = BODY_ZONE_R_ARM
	dismember_bodyzone = BODY_ZONE_R_ARM
	heal_zones = list(BODY_ZONE_R_ARM)
	amputation_point = "right arm"
	children_zones = list()
	specific_locations = list("right palm", "right back palm")
	max_cavity_size = WEIGHT_CLASS_TINY

/obj/item/bodypart/r_hand/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/r_hand/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(owner.stat < UNCONSCIOUS)
		switch(disabled)
			if(BODYPART_DISABLED_DAMAGE)
				owner.emote("scream")
				to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
			if(BODYPART_DISABLED_PARALYSIS)
				to_chat(owner, "<span class='userdanger'>You can't feel your [name]!</span>")
	if(held_index)
		owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	if(owner.hud_used)
		var/obj/screen/inventory/hand/L = owner.hud_used.hand_slots["[held_index]"]
		if(L)
			L.update_icon()
