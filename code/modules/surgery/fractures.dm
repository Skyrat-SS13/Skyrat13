/datum/surgery/mend_fractures
	name = "Fracture Repair"
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM,\
						BODY_ZONE_PRECISE_R_HAND,  BODY_ZONE_PRECISE_L_HAND,\
						BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
	requires_real_bodypart = 1
	requires_bodypart_type = BODYPART_ORGANIC
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/set_bone,
		/datum/surgery_step/mend_bone,
		/datum/surgery_step/close
		)

//mend bone
/datum/surgery_step/set_bone
	name = "set bone"
	implements = list(TOOL_SETTER = 100, TOOL_WIRECUTTER = 25)
	time = 30

/datum/surgery_step/set_bone/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	var/isencased = BP.encased ? BP.encased : "bone"
	display_results(user, target, "<span class='notice'>You begin to set [target]'s [isencased] in place...</span>",
		"[user] begins to set [target]'s [isencased] in place.",
		"[user] begins to set [target]'s [isencased] in place.")

/datum/surgery_step/set_bone/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	BP.internal_bleeding = TRUE
	for(var/obj/item/organ/O in target.getorganszone(target_zone))
		target.adjustOrganLoss(O.slot, rand(1,5))
	display_results(user, target, "<span class='notice'>You screw up, stabbing the organs in [parse_zone(target_zone)] with sharp bone!</span>",
		"[user] screws up, stabbing the organs in [parse_zone(target_zone)] with sharp bone!",
		"[user] screws up, stabbing the organs in [parse_zone(target_zone)] with sharp bone!")

/datum/surgery_step/set_bone/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	var/isencased = BP.encased ? BP.encased : "bone"
	BP.status_flags &= ~BODYPART_BROKEN
	display_results(user, target, "<span class='notice'>You set [target]'s [isencased] in place.</span>",
		"[user] sets [target]'s [isencased] in place.",
		"[user]	sets [target]'s [isencased] in place.")

//gel bone
/datum/surgery_step/mend_bone
	name = "mend fractures"
	implements = list(TOOL_GEL = 100, /obj/item/stack/medical/ointment = 50)
	time = 30

/datum/surgery_step/mend_bone/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	var/isencased = BP.encased ? BP.encased : "bone"
	display_results(user, target, "<span class='notice'>You begin to mend the fractures in [target]'s [isencased]...</span>",
		"[user] begins to mend the fractures in [target]'s [isencased].",
		"[user] begins to mend the fractures in [target]'s [isencased].")

/datum/surgery_step/mend_bone/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/organ/O in target.getorganszone(target_zone))
		target.adjustOrganLoss(O.slot, 5)
	display_results(user, target, "<span class='notice'>You screw up, splashing all the organs in [parse_zone(target_zone)] with [tool]!</span>",
		"[user] screws up, splashing all the organs in [parse_zone(target_zone)] with [tool]!",
		"[user] screws up, splashing all the organs in [parse_zone(target_zone)] with [tool]!")

/datum/surgery_step/mend_bone/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	var/isencased = BP.encased ? BP.encased : "bone"
	display_results(user, target, "<span class='notice'>You mend the fractures in [target]'s [isencased].</span>",
		"[user] mends the fractures in [target]'s [isencased].",
		"[user] mends the fractures in [target]'s [isencased].")
