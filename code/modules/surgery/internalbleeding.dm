/datum/surgery/stop_bleeding
	name = "Vascular Repair"
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,  BODY_ZONE_PRECISE_L_HAND,
						BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
	requires_real_bodypart = 1
	requires_bodypart_type = BODYPART_ORGANIC
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/fix_bleeding,
		/datum/surgery_step/close
		)

//mend bone
/datum/surgery_step/fix_bleeding
	name = "fix internal bleeding"
	implements = list(TOOL_FIXOVEIN = 100, /obj/item/stack/cable_coil = 20)
	time = 30

/datum/surgery_step/fix_bleeding/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to fix [target]'s [parse_zone(target_zone)] torn veins...</span>",
		"[user] begins to fix [target]'s [parse_zone(target_zone)] torn veins.",
		"[user] begins to fix [target]'s [parse_zone(target_zone)] torn veins.")

/datum/surgery_step/fix_bleeding/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	BP.internal_bleeding = TRUE
	var/mob/living/carbon/human/H = target
	if(istype(H))
		H.bleed_rate += 2.5 //Meshuggah - Bleed
	display_results(user, target, "<span class='notice'>You screw up, tearing even more veins in [parse_zone(target_zone)]!</span>",
		"[user] screws up, tearing even more veins in [parse_zone(target_zone)]!",
		"[user] screws up, tearing even more veins in [parse_zone(target_zone)]!")

/datum/surgery_step/fix_bleeding/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	BP.internal_bleeding = FALSE
	display_results(user, target, "<span class='notice'>You fix [target]'s [parse_zone(target_zone)] torn veins.</span>",
		"[user] fixes [target]'s [parse_zone(target_zone)] torn veins.",
		"[user]	fixes [target]'s [parse_zone(target_zone)] torn veins.")
