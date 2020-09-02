/datum/surgery/mechanic_prosthetic_replacement
	name = "Prosthetic replacement"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_unwrench,
				/datum/surgery_step/open_hatch,
				/datum/surgery_step/mechanic_add_prosthetic,
				/datum/surgery_step/mechanic_close)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = ALL_BODYPARTS //skyrat edit
	requires_bodypart = FALSE //need a missing limb
	requires_bodypart_type = 0

/datum/surgery/mechanic_prosthetic_replacement/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	if(!iscarbon(target))
		return 0
	var/mob/living/carbon/C = target
	var/obj/item/bodypart/BP = C.get_bodypart(SSquirks.bodypart_child_to_parent[user.zone_selected])
	if(BP?.status & BODYPART_ORGANIC)
		return 0
	if(!C.get_bodypart(user.zone_selected)) //can only start if limb is missing
		return 1

/datum/surgery_step/mechanic_add_prosthetic
	name = "Add prosthetic"
	implements = list(/obj/item/bodypart = 100, /obj/item/organ_storage = 100, /obj/item = 100, /obj/item/melee/synthetic_arm_blade = 100)
	time = 32
	var/organ_rejection_dam = 0

/datum/surgery_step/mechanic_add_prosthetic/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/organ_storage))
		if(!tool.contents.len)
			to_chat(user, "<span class='notice'>There is nothing inside [tool]!</span>")
			return -1
		var/obj/item/I = tool.contents[1]
		if(!isbodypart(I))
			to_chat(user, "<span class='notice'>[I] cannot be attached!</span>")
			return -1
		tool = I
	if(istype(tool, /obj/item/bodypart))
		var/obj/item/bodypart/BP = tool
		if(ismonkey(target))// monkey patient only accept organic monkey limbs
			if((BP.status & BODYPART_ROBOTIC) || BP.animal_origin != MONKEY_BODYPART)
				to_chat(user, "<span class='warning'>[BP] doesn't match the patient's morphology.</span>")
				return -1
		if(!(BP.status & BODYPART_ROBOTIC))
			organ_rejection_dam = 10
			if(ishuman(target))
				if(BP.animal_origin)
					to_chat(user, "<span class='warning'>[BP] doesn't match the patient's morphology.</span>")
					return -1
				var/mob/living/carbon/human/H = target
				if(H.dna.species.id != BP.species_id)
					organ_rejection_dam = 30
				if(ROBOTIC_LIMBS in H.dna?.species?.species_traits)
					organ_rejection_dam = 0

		if(target_zone == BP.body_zone) //so we can't replace a leg with an arm, or a human arm with a monkey arm.
			display_results(user, target, "<span class ='notice'>You begin to replace [target]'s [parse_zone(target_zone)] with [tool]...</span>",
				"[user] begins to replace [target]'s [parse_zone(target_zone)] with [tool].",
				"[user] begins to replace [target]'s [parse_zone(target_zone)].")
		//skyrat edit
		else if(target_zone in BP.children_zones)
			display_results(user, target, "<span class ='notice'>You begin to replace [target]'s [parse_zone(BP.children_zones[1])] with [tool]...</span>",
				"[user] begins to replace [target]'s [parse_zone(BP.children_zones[1])] with [tool].",
				"[user] begins to replace [target]'s [parse_zone(BP.children_zones[1])].")
		//
		else
			to_chat(user, "<span class='warning'>[tool] isn't the right type for [parse_zone(target_zone)].</span>")
			return -1
	else
		display_results(user, target, "<span class='notice'>You begin to attach [tool] onto [target]...</span>",
			"[user] begins to attach [tool] onto [target]'s [parse_zone(target_zone)].",
			"[user] begins to attach something onto [target]'s [parse_zone(target_zone)].")

/datum/surgery_step/mechanic_add_prosthetic/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/organ_storage))
		tool.icon_state = initial(tool.icon_state)
		tool.desc = initial(tool.desc)
		tool.cut_overlays()
		tool = tool.contents[1]
	if(istype(tool, /obj/item/bodypart) && user.temporarilyRemoveItemFromInventory(tool))
		var/obj/item/bodypart/L = tool
		//skyrat edit
		var/bruh = null
		if(target_zone != L.body_zone)
			if(target_zone in L.children_zones)
				for(var/obj/item/bodypart/fosterchild in src)
					if((fosterchild.body_zone in L.children_zones) && (target_zone == fosterchild.body_zone) && !bruh)
						fosterchild.forceMove(get_turf(target))
						fosterchild.attach_limb(target)
						L.forceMove(get_turf(target))
						bruh = fosterchild
		else
			L.attach_limb(target)
		//
		if(organ_rejection_dam)
			target.adjustToxLoss(organ_rejection_dam)
		display_results(user, target, "<span class='notice'>You succeed in replacing [target]'s [parse_zone(target_zone)].</span>",
			"[user] successfully replaces [target]'s [parse_zone(target_zone)] with [bruh ? bruh : tool]!",
			"[user] successfully replaces [target]'s [parse_zone(target_zone)]!")
		return 1
	else
		var/obj/item/bodypart/L = target.newBodyPart(target_zone, FALSE, FALSE)
		L.is_pseudopart = TRUE
		L.attach_limb(target)
		display_results(user, target, "<span class='notice'>You attach [tool].</span>",
			"[user] finishes attaching [tool]!",
			"[user] finishes the attachment procedure!")
		if(istype(tool))
			var/obj/item/new_limb = new(target)
			if(target_zone == BODY_ZONE_PRECISE_R_HAND)
				target.put_in_r_hand(new_limb)
				ADD_TRAIT(new_limb, TRAIT_NODROP, "surgery")
			else if(target_zone == BODY_ZONE_PRECISE_L_HAND)
				target.put_in_l_hand(new_limb)
				ADD_TRAIT(new_limb, TRAIT_NODROP, "surgery")
			L.name = "[new_limb.name] [L.name]"
			L.desc = new_limb.desc
			L.custom_overlay = mutable_appearance(new_limb.icon, new_limb.icon_state, FLOAT_LAYER, FLOAT_PLANE, new_limb.color)
			L.custom_overlay.transform *= 0.5
			L.custom_overlay.pixel_x = 0
			L.custom_overlay.pixel_y = 0
			L.custom_overlay.pixel_x += 8
			L.custom_overlay.pixel_y -= 8
			switch(target_zone)
				if(BODY_ZONE_HEAD)
					L.custom_overlay.pixel_x -= 8
					L.custom_overlay.pixel_y += 16
				if(BODY_ZONE_CHEST)
					L.custom_overlay.pixel_x -= 8
					L.custom_overlay.pixel_y += 8
				if(BODY_ZONE_PRECISE_GROIN)
					L.custom_overlay.pixel_x -= 8
					L.custom_overlay.pixel_y += 6
				if(BODY_ZONE_R_LEG)
					L.custom_overlay.pixel_x += 0
					L.custom_overlay.pixel_y += 2
				if(BODY_ZONE_PRECISE_R_FOOT)
					L.custom_overlay.pixel_x += 0
					L.custom_overlay.pixel_y += 0
				if(BODY_ZONE_L_LEG)
					L.custom_overlay.pixel_x -= 16
					L.custom_overlay.pixel_y += 2
				if(BODY_ZONE_PRECISE_L_FOOT)
					L.custom_overlay.pixel_x -= 16
					L.custom_overlay.pixel_y += 0
			target.regenerate_icons()
			return 1
		qdel(tool)
