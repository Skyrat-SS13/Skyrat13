
/////BONE FIXING SURGERIES//////

///// Repair Hairline Fracture (Severe)
/datum/surgery/mechanic_repair_bone_hairline
	name = "Repair endoskeleton damage (malfunctioning)"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_repair_bone_hairline,
				/datum/surgery_step/mechanic_close)
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ROBOTIC
	targetable_wound = /datum/wound/mechanical/blunt/severe

/datum/surgery/mechanic_repair_bone_hairline/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return (targeted_bodypart.get_wound_type(targetable_wound))

///// Repair Compound Fracture (Critical)
/datum/surgery/mechanic_repair_bone_compound
	name = "Repair endoskeleton damage (broken)"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_unwrench,
				/datum/surgery_step/open_hatch,
				/datum/surgery_step/mechanic_reset_compound_fracture,
				/datum/surgery_step/mechanic_repair_bone_compound,
				/datum/surgery_step/mechanic_wrench,
				/datum/surgery_step/mechanic_close)
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ROBOTIC
	targetable_wound = /datum/wound/mechanical/blunt/critical

/datum/surgery/mechanic_repair_bone_compound/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return(targeted_bodypart.get_wound_type(targetable_wound))

//SURGERY STEPS

///// Repair Hairline Fracture (Severe)
/datum/surgery_step/mechanic_repair_bone_hairline
	name = "Repair malfunctioning actuators"
	implements = list(/obj/item/stack/medical/nanopaste = 100, /obj/item/stack/sticky_tape/super = 100, /obj/item/stack/sticky_tape = 75)
	time = 40

/datum/surgery_step/mechanic_repair_bone_hairline/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target, "<span class='notice'>You begin to repair the actuators in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to repair the actuators in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to repair the actuators in [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/mechanic_repair_bone_hairline/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(istype(tool, /obj/item/stack))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(user, target, "<span class='notice'>You successfully repair the actuators in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully repairs the actuators in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully repairs the actuators in [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "repaired malfunctioning actuators in", addition="INTENT: [uppertext(user.a_intent)]")
		surgery.operated_wound.remove_wound()
	else
		to_chat(user, "<span class='warning'>[target] has no hairline fracture there!</span>")
	return ..()

/datum/surgery_step/mechanic_repair_bone_hairline/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

///// Reset Compound Fracture (Crticial)
/datum/surgery_step/mechanic_reset_compound_fracture
	name = "Reset components"
	implements = list(/obj/item/wrench = 100, /obj/item/bonesetter = 70)
	time = 40

/datum/surgery_step/mechanic_reset_compound_fracture/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target, "<span class='notice'>You begin to reset the components in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to reset the components in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to reset the components in [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/mechanic_reset_compound_fracture/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(istype(tool, /obj/item/stack))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(user, target, "<span class='notice'>You successfully reset the components in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully resets the components in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully resets the components in [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "reset a compound fracture in", addition="INTENT: [uppertext(user.a_intent)]")
	else
		to_chat(user, "<span class='warning'>[target] has no compound fracture there!</span>")
	return ..()

/datum/surgery_step/mechanic_reset_compound_fracture/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(2)

///// Repair Compound Fracture (Crticial)
/datum/surgery_step/mechanic_repair_bone_compound
	name = "Replace broken components"
	implements = list(/obj/item/stack/medical/nanopaste = 100, /obj/item/stack/sticky_tape/super = 100, /obj/item/stock_parts = 100, /obj/item/stack/sticky_tape = 50)
	time = 40

/datum/surgery_step/mechanic_repair_bone_compound/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(user, target, "<span class='notice'>You begin to replace the broken component in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to replace the broken component in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to replace the broken component in [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/mechanic_repair_bone_compound/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(istype(tool, /obj/item/stack))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(user, target, "<span class='notice'>You successfully replace the broken component in [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully replaced the broken component in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully replaced the broken component in [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "repaired broken actuators in", addition="INTENT: [uppertext(user.a_intent)]")
		qdel(surgery.operated_wound)
	else
		to_chat(user, "<span class='warning'>[target] has no broken actuators there!</span>")
	return ..()

/datum/surgery_step/mechanic_repair_bone_compound/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)
