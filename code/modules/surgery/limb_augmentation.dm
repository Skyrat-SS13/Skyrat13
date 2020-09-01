/////AUGMENTATION SURGERIES//////
//SURGERY STEPS

/datum/surgery_step/replace_limb
	name = "Replace limb"
	implements = list(/obj/item/bodypart = 100, /obj/item/organ_storage = 100)
	time = 32

/datum/surgery_step/replace_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(istype(tool, /obj/item/organ_storage) && istype(tool.contents[1], /obj/item/bodypart))
		tool = tool.contents[1]
	var/obj/item/bodypart/aug = tool
	/* Skyrat edit - we don't care if the limb is robotic, this will pretty much serve as a "limb replacement" surgery for extreme wounds.
	if(!(aug.status & BODYPART_ROBOTIC))
		to_chat(user, "<span class='warning'>That's not an augment, silly!</span>")
		return -1
	*/
	if(aug.body_zone != target_zone)
		to_chat(user, "<span class='warning'>[tool] isn't the right type for [parse_zone(target_zone)].</span>")
		return -1
	L = surgery.operated_bodypart
	if(L)
		display_results(user, target, "<span class ='notice'>You begin to augment [target]'s [parse_zone(user.zone_selected)]...</span>",
			"[user] begins to augment [target]'s [parse_zone(user.zone_selected)] with [aug].",
			"[user] begins to augment [target]'s [parse_zone(user.zone_selected)].")
	else
		user.visible_message("[user] looks for [target]'s [parse_zone(user.zone_selected)].", "<span class ='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

//ACTUAL SURGERIES
/datum/surgery/augmentation
	name = "Augmentation"
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/replace_limb)
	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = ALL_BODYPARTS //skyrat edit
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ORGANIC

//SURGERY STEP SUCCESSES
/datum/surgery_step/replace_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/bodypart/tool, datum/surgery/surgery)
	if(L)
		if(istype(tool, /obj/item/organ_storage))
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = tool.contents[1]
		//skyrat edit
		if(istype(tool) && user.temporarilyRemoveItemFromInventory(tool))
			if(tool.body_zone == target_zone)
				tool.replace_limb(target, TRUE)
			else if(target_zone in tool.children_zones)
				var/obj/item/bodypart/BP
				for(var/obj/item/bodypart/candidate in tool)
					if(target_zone == candidate.body_zone)
						BP = candidate
				if(BP)
					BP.replace_limb(target, TRUE)
				else
					return FALSE
		//
		display_results(user, target, "<span class='notice'>You successfully augment [target]'s [parse_zone(target_zone)].</span>",
			"[user] successfully augments [target]'s [parse_zone(target_zone)] with [tool]!",
			"[user] successfully augments [target]'s [parse_zone(target_zone)]!")
		log_combat(user, target, "augmented", addition="by giving him new [parse_zone(target_zone)] INTENT: [uppertext(user.a_intent)]")
	else
		to_chat(user, "<span class='warning'>[target] has no [parse_zone(target_zone)] there!</span>")
	return TRUE
