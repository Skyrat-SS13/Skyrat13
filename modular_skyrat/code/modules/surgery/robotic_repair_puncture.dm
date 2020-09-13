
/////ROBOTIC PIERCE|SLASH FIXING SURGERIES//////

//the step numbers of each of these two, we only currently use the first to switch back and forth due to advancing after finishing steps anyway
#define REALIGN_INNARDS 1
#define WELD_VEINS		2

///// Repair puncture wounds
/datum/surgery/robot_repair_puncture
	name = "Repair mechanical dents"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_repair_innards,
				/datum/surgery_step/mechanic_seal_veins,
				/datum/surgery_step/mechanic_close) // repeat between steps 2 and 3 until healed
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ROBOTIC
	targetable_wound = /datum/wound/mechanical/pierce
	var/puncture_or_slash = "puncture"

//// Repair slash wounds
/datum/surgery/robot_repair_puncture/robotic_repair_slash
	name = "Repair mechanical tearing"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_repair_innards,
				/datum/surgery_step/mechanic_seal_veins,
				/datum/surgery_step/mechanic_close) // repeat between steps 2 and 3 until healed
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ROBOTIC
	targetable_wound = /datum/wound/mechanical/slash
	puncture_or_slash = "slash"

/datum/surgery/repair_puncture/can_start(mob/living/user, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		var/datum/wound/slash_or_pierce = targeted_bodypart.get_wound_type(targetable_wound)
		return (slash_or_pierce && slash_or_pierce.blood_flow > 0)

//SURGERY STEPS

///// realign the hydraulics so we can reweld them
/datum/surgery_step/mechanic_repair_innards
	name = "realign hydraulics"
	implements = list(/obj/item/stack/cable_coil = 100, /obj/item/stack/medical/nanopaste = 100, /obj/item/pipe = 60)
	time = 3 SECONDS
	var/puncture_or_slash = "puncture"

/datum/surgery_step/mechanic_repair_innards/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail)
	. = ..()
	if(istype(surgery.operated_wound, /datum/wound/mechanical/slash))
		puncture_or_slash = "slash"

/datum/surgery_step/mechanic_repair_innards/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/datum/wound/slash_or_pierce = surgery.operated_wound
	if(!slash_or_pierce)
		user.visible_message("<span class='notice'>[user] looks for [target]'s [puncture_or_slash]...</span>", "<span class='notice'>You look for [target]'s [puncture_or_slash]...</span>")
		return

	if(slash_or_pierce.blood_flow <= 0)
		to_chat(user, "<span class='notice'>[target]'s [parse_zone(user.zone_selected)] has no [puncture_or_slash] to repair!</span>")
		surgery.status++
		return

	display_results(user, target, "<span class='notice'>You begin to realign the torn cables in [target]'s [parse_zone(user.zone_selected)]...</span>",
		"<span class='notice'>[user] begins to realign the torn cables in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
		"<span class='notice'>[user] begins to realign the torn cables in [target]'s [parse_zone(user.zone_selected)].</span>")

/datum/surgery_step/mechanic_repair_innards/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/slash_or_pierce = surgery.operated_wound
	if(!slash_or_pierce)
		to_chat(user, "<span class='warning'>[target] has no [puncture_or_slash] wound there!</span>")
	else
		display_results(user, target, "<span class='notice'>You successfully realign some of the cables in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully realigns some of the cables in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully realigns some of the cables in  [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "repaired a robotic [puncture_or_slash] in", addition="INTENT: [uppertext(user.a_intent)]")
		surgery.operated_bodypart.receive_damage(brute=3, wound_bonus=CANT_WOUND)
		slash_or_pierce.blood_flow -= 0.75
	return ..()

/datum/surgery_step/repair_innards/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	. = ..()
	display_results(user, target, "<span class='notice'>You jerk apart some of the cabling in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] jerks apart some of the cabling in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
		"<span class='notice'>[user] jerk apart some of the cabling in [target]'s [parse_zone(target_zone)]!</span>")
	surgery.operated_bodypart.receive_damage(brute=rand(4,8), sharpness=SHARP_EDGED, wound_bonus = 10)

///// Sealing the cables back together
/datum/surgery_step/mechanic_seal_veins
	name = "weld cable"
	implements = list(TOOL_WELDER = 100, /obj/item/gun/energy/laser = 80, TOOL_CAUTERY = 60, /obj/item = 30)
	time = 4 SECONDS
	var/puncture_or_slash = "puncture"

/datum/surgery_step/mechanic_seal_veins/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail)
	. = ..()
	if(istype(surgery.operated_wound, /datum/wound/slash))
		puncture_or_slash = "slash"

/datum/surgery_step/mechanic_seal_veins/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER || implement_type == /obj/item)
		return tool.get_temperature()

	return TRUE

/datum/surgery_step/mechanic_seal_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/datum/wound/slash_or_pierce = surgery.operated_wound
	if(!slash_or_pierce)
		user.visible_message("<span class='notice'>[user] looks for [target]'s [puncture_or_slash]...</span>", "<span class='notice'>You look for [target]'s [puncture_or_slash]...</span>")
		return
	display_results(user, target, "<span class='notice'>You begin to meld some of the split hydraulics in [target]'s [parse_zone(user.zone_selected)]...</span>",
		"<span class='notice'>[user] begins to meld some of the split hydraulics in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
		"<span class='notice'>[user] begins to meld some of the split hydraulics in [target]'s [parse_zone(user.zone_selected)].</span>")

/datum/surgery_step/mechanic_seal_veins/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/slash_or_pierce = surgery.operated_wound
	if(!slash_or_pierce)
		to_chat(user, "<span class='warning'>[target] has no [puncture_or_slash] there!</span>")
		return ..()

	display_results(user, target, "<span class='notice'>You successfully meld some of the split hydraulics in [target]'s [parse_zone(target_zone)] with [tool].</span>",
		"<span class='notice'>[user] successfully melds some of the split hydraulics in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
		"<span class='notice'>[user] successfully melds some of the split hydraulics in [target]'s [parse_zone(target_zone)]!</span>")
	log_combat(user, target, "repaired a robotic [puncture_or_slash] in", addition="INTENT: [uppertext(user.a_intent)]")
	slash_or_pierce.blood_flow -= 1.25
	if(slash_or_pierce.blood_flow > 0)
		surgery.status = REALIGN_INNARDS
		to_chat(user, "<span class='notice'><i>There still seems to be misaligned hydraulics to finish...<i></span>")
	else
		to_chat(user, "<span class='green'>You've repaired all the internal damage in [target]'s [parse_zone(target_zone)]!</span>")
	return ..()

#undef REALIGN_INNARDS
#undef WELD_VEINS
