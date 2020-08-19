//cut wires
/datum/surgery_step/cut_wires
	name = "Cut wires"
	implements = list(
		TOOL_WIRECUTTER		= 100,
		TOOL_SCALPEL 		= 75,
		/obj/item/kitchen/knife	= 50,
		/obj/item				= 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/cut_wires/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to cut loose wires in [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to cut loose wires in [target]'s [parse_zone(target_zone)].",
			"[user] begins to cut loose wires in [target]'s [parse_zone(target_zone)].")

/datum/surgery_step/cut_wires/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	return TRUE

//pry off plating
/datum/surgery_step/pry_off_plating
	name = "Pry off plating"
	implements = list(
		TOOL_CROWBAR = 100,
		TOOL_HEMOSTAT = 10)
	time = 24

/datum/surgery_step/pry_off_plating/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	//skyrat edit
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	if(istype(BP))
		var/datum/wound/slash/critical/incision/inch = new()
		inch.apply_wound(BP, TRUE)
		BP.generic_bleedstacks += 5
	//
	do_sparks(rand(5, 9), FALSE, target.loc)
	return TRUE

/datum/surgery_step/pry_off_plating/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to pry off [target]'s [parse_zone(target_zone)] plating...</span>",
			"[user] begins to pry off [target]'s [parse_zone(target_zone)] plating.",
			"[user] begins to pry off [target]'s [parse_zone(target_zone)] plating.")

//weld plating
/datum/surgery_step/weld_plating
	name = "Weld plating"
	implements = list(
		TOOL_WELDER = 100)
	time = 24

/datum/surgery_step/weld_plating/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	if(implement_type == TOOL_WELDER && !tool.use_tool(user, user, 0, volume=50, amount=1))
		return FALSE
	return TRUE

/datum/surgery_step/weld_plating/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to weld [target]'s [parse_zone(target_zone)] plating...</span>",
			"[user] begins to weld [target]'s [parse_zone(target_zone)] plating.",
			"[user] begins to weld [target]'s [parse_zone(target_zone)] plating.")

//replace wires
/datum/surgery_step/replace_wires
	name = "Replace wires"
	implements = list(/obj/item/stack/cable_coil = 100)
	time = 24
	var/cableamount = 5

/datum/surgery_step/replace_wires/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	var/obj/item/stack/cable_coil/coil = tool
	if(coil.get_amount() < cableamount)
		to_chat(user, "<span class='warning'>Not enough cable!</span>")
		return FALSE
	return TRUE

/datum/surgery_step/replace_wires/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/stack/cable_coil/coil = tool
	if(coil && !(coil.get_amount()<cableamount)) //failproof
		coil.use(cableamount)
	return TRUE

/datum/surgery_step/replace_wires/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to replace [target]'s [parse_zone(target_zone)] wiring...</span>",
			"[user] begins to replace [target]'s [parse_zone(target_zone)] wiring.",
			"[user] begins to replace [target]'s [parse_zone(target_zone)] wiring.")

//add plating
/datum/surgery_step/add_plating
	name = "Add plating"
	implements = list(/obj/item/stack/sheet/metal = 100)
	time = 24
	var/metalamount = 5

/datum/surgery_step/add_plating/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	var/obj/item/stack/sheet/metal/plat = tool
	if(plat.get_amount() < metalamount)
		to_chat(user, "<span class='warning'>Not enough metal!</span>")
		return FALSE
	return TRUE

/datum/surgery_step/add_plating/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/stack/sheet/metal/plat = tool
	if(plat && !(plat.get_amount()<metalamount)) //failproof
		plat.use(metalamount)
	return TRUE

/datum/surgery_step/add_plating/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to add plating to [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to add plating to [target]'s [parse_zone(target_zone)].",
			"[user] begins to add plating to [target]'s [parse_zone(target_zone)].")

//open shell
/datum/surgery_step/mechanic_open
	name = "Unscrew shell"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPEL 		= 75, // med borgs could try to unskrew shell with scalpel
		/obj/item/kitchen/knife	= 50,
		/obj/item				= 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/mechanic_open/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unscrew the shell of [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)].",
			"[user] begins to unscrew the shell of [target]'s [parse_zone(target_zone)].")

/datum/surgery_step/mechanic_open/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	if(istype(tool, /obj/item/cautery) && user.a_intent == INTENT_HELP && target)
		var/obj/item/bodypart/BP = target.get_bodypart(user.zone_selected)
		if(istype(BP))
			BP.attackby(tool, user)
		return FALSE
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	return TRUE

/datum/surgery_step/mechanic_open/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	if(istype(BP))
		var/datum/wound/mechanical/slash/critical/incision/inch = new()
		inch.apply_wound(BP, TRUE)
		BP.generic_bleedstacks += 5

//close shell
/datum/surgery_step/mechanic_close
	name = "Screw shell"
	implements = list(
		TOOL_SCREWDRIVER		= 100,
		TOOL_SCALPELl 		= 75,
		/obj/item/kitchen/knife	= 50,
		/obj/item				= 10) // 10% success with any sharp item.
	time = 24

/datum/surgery_step/mechanic_close/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to screw the shell of [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to screw the shell of [target]'s [parse_zone(target_zone)].",
			"[user] begins to screw the shell of [target]'s [parse_zone(target_zone)].")

/datum/surgery_step/mechanic_close/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	. = ..()
	//skyrat edit
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	if(istype(BP))
		for(var/datum/wound/slash/critical/incision/inch in BP.wounds)
			inch.remove_wound()
		for(var/datum/wound/mechanical/slash/critical/incision/inch in BP.wounds)
			inch.remove_wound()
	//

/datum/surgery_step/mechanic_close/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	return TRUE

//prepare electronics
/datum/surgery_step/prepare_electronics
	name = "Prepare electronics"
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 10) // try to reboot internal controllers via short circuit with some conductor
	time = 24

/datum/surgery_step/prepare_electronics/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to prepare electronics in [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)].",
			"[user] begins to prepare electronics in [target]'s [parse_zone(target_zone)].")

//unwrench
/datum/surgery_step/mechanic_unwrench
	name = "Unwrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 24

/datum/surgery_step/mechanic_unwrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to unwrench some bolts in [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)].",
			"[user] begins to unwrench some bolts in [target]'s [parse_zone(target_zone)].")

//wrench
/datum/surgery_step/mechanic_wrench
	name = "Wrench bolts"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_RETRACTOR = 10)
	time = 24

/datum/surgery_step/mechanic_wrench/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to wrench some bolts in [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)].",
			"[user] begins to wrench some bolts in [target]'s [parse_zone(target_zone)].")

//open hatch
/datum/surgery_step/open_hatch
	name = "Open the hatch"
	accept_hand = 1
	time = 10

/datum/surgery_step/open_hatch/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to open the hatch holders in [target]'s [parse_zone(target_zone)]...</span>",
		"[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)].",
		"[user] begins to open the hatch holders in [target]'s [parse_zone(target_zone)].")
