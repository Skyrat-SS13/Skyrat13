
/////ROBOTIC BURN FIXING SURGERIES//////

///// Pry warped metal
/datum/surgery/robot_debride
	name = "Pry off warped metal"
	steps = list(/datum/surgery_step/robotic_debride,
				/datum/surgery_step/robotic_dress)
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE
	requires_bodypart_type = BODYPART_ROBOTIC
	targetable_wound = /datum/wound/mechanical/burn

/datum/surgery/debride/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		var/datum/wound/mechanical/burn/burn_wound = targeted_bodypart.get_wound_type(targetable_wound)
		return(burn_wound && burn_wound.heat_warping > 0)

//SURGERY STEPS

///// Pry (Debride)
/datum/surgery_step/robotic_debride
	name = "Pry warped metal"
	implements = list(TOOL_CROWBAR = 100, TOOL_RETRACTOR = 50, TOOL_SHOVEL = 30)
	time = 3 SECONDS
	repeatable = TRUE

/datum/surgery_step/robotic_debride/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		var/datum/wound/mechanical/burn/burn_wound = surgery.operated_wound
		if(burn_wound.heat_warping <= 0)
			to_chat(user, "<span class='notice'>[target]'s [parse_zone(user.zone_selected)] has no warped to remove!</span>")
			surgery.status++
			repeatable = FALSE
			return
		display_results(user, target, "<span class='notice'>You begin to pry off warped metal from [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to pry off warped metal from [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to pry off warped metal from [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/robotic_debride/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/mechanical/burn/burn_wound = surgery.operated_wound
	if(burn_wound)
		display_results(user, target, "<span class='notice'>You successfully pry off some warped metal from [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully pries off some warped metal from [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully pries off some warped metal from  [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "pried warped metal in", addition="INTENT: [uppertext(user.a_intent)]")
		surgery.operated_bodypart.receive_damage(brute=5, wound_bonus=CANT_WOUND)
		burn_wound.heat_warping -= 4
		if(burn_wound.heat_warping <= 0)
			repeatable = FALSE
	else
		to_chat(user, "<span class='warning'>[target] has no warped metal there!</span>")
	return ..()

/datum/surgery_step/robotic_debride/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	display_results(user, target, "<span class='notice'>You carve away some intact metal from [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] carves away some intact metal from [target]'s [parse_zone(target_zone)] with [tool]!</span>",
		"<span class='notice'>[user] carves away some intact metal from  [target]'s [parse_zone(target_zone)]!</span>")
	surgery.operated_bodypart.receive_damage(brute=rand(4,10), sharpness=SHARP_EDGED)

/datum/surgery_step/robotic_debride/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(!..())
		return
	var/datum/wound/mechanical/burn/burn_wound = surgery.operated_wound
	while(burn_wound && burn_wound.heat_warping > 0)
		if(!..())
			break

///// Patch limb (Dressing burns)
/datum/surgery_step/robotic_dress
	name = "Patch limb"
	implements = list(/obj/item/stack/sticky_tape = 100, /obj/item/stack/sheet = 70)
	time = 4 SECONDS

/datum/surgery_step/robotic_dress/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/datum/wound/mechanical/burn/burn_wound = surgery.operated_wound
	if(burn_wound)
		display_results(user, target, "<span class='notice'>You begin to patch the wounds on [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to patch the wounds on [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to patch the wounds on [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/robotic_dress/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/datum/wound/mechanical/burn/burn_wound = surgery.operated_wound
	if(burn_wound)
		display_results(user, target, "<span class='notice'>You successfully patch [target]'s [parse_zone(target_zone)] with [tool].</span>",
			"<span class='notice'>[user] successfully patches [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully patches [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "patched robotic burns in", addition="INTENT: [uppertext(user.a_intent)]")
		burn_wound.heat_warping -= 2
		burn_wound.heat_warpingnt += 0.75
		var/obj/item/bodypart/the_part = target.get_bodypart(target_zone)
		if(istype(tool, /obj/item/stack/sticky_tape))
			the_part.apply_gauze(tool)
	else
		to_chat(user, "<span class='warning'>[target] has no burns there!</span>")
	return ..()

/datum/surgery_step/robotic_dress/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(2)
