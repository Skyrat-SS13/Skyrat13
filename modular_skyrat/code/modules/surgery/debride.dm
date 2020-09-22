
/////INFECTION FIXING SURGERIES//////

///// Debride infected flesh
/datum/surgery/debride
	name = "Debride infected flesh"
	steps = list(/datum/surgery_step/debride, /datum/surgery_step/dress)
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE

/datum/surgery/debride/can_start(mob/living/user, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/bodypart/BP = target.get_bodypart(user.zone_selected)
		if(BP)
			for(var/datum/wound/W in BP.wounds)
				if(W.germ_level)
					return TRUE
			if(BP.germ_level)
				return TRUE
		else
			return FALSE

//SURGERY STEPS
///// Debride
/datum/surgery_step/debride
	name = "Excise infection"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_SCALPEL = 85, TOOL_SAW = 60, TOOL_WIRECUTTER = 40)
	time = 3 SECONDS
	repeatable = TRUE

/datum/surgery_step/debride/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
	if(targeted_bodypart)
		if(targeted_bodypart.germ_level <= 0)
			to_chat(user, "<span class='notice'>[target]'s [parse_zone(user.zone_selected)] has no infected flesh to remove!</span>")
			surgery.status++
			repeatable = FALSE
			return
		display_results(user, target, "<span class='notice'>You begin to excise infected flesh from [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to excise infected flesh from [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to excise infected flesh from [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/debride/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
	if(targeted_bodypart)
		display_results(user, target, "<span class='notice'>You successfully excise some of the infected flesh from [target]'s [parse_zone(target_zone)].</span>",
			"<span class='notice'>[user] successfully excises some of the infected flesh from [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully excises some of the infected flesh from  [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "excised infected flesh in", addition="INTENT: [uppertext(user.a_intent)]")
		targeted_bodypart.receive_damage(brute=3, wound_bonus=CANT_WOUND)
		targeted_bodypart.germ_level -= (WOUND_SANITIZATION_STERILIZER * 2)
		for(var/datum/wound/infected_wound in targeted_bodypart.wounds)
			infected_wound.germ_level -= WOUND_SANITIZATION_STERILIZER
			infected_wound.sanitization += 0.5
		if(targeted_bodypart.germ_level <= 0)
			repeatable = FALSE
	else
		to_chat(user, "<span class='warning'>[target] has no infected flesh there!</span>")
	return ..()

/datum/surgery_step/debride/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	display_results(user, target, "<span class='notice'>You carve away some of the healthy flesh from [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] carves away some of the healthy flesh from [target]'s [parse_zone(target_zone)] with [tool]!</span>",
		"<span class='notice'>[user] carves away some of the healthy flesh from  [target]'s [parse_zone(target_zone)]!</span>")
	surgery.operated_bodypart.receive_damage(brute=rand(4,8), sharpness=SHARP_EDGED)

/datum/surgery_step/debride/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(!..())
		return
	var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
	while(targeted_bodypart && (targeted_bodypart.germ_level || targeted_bodypart.is_dead()))
		if(!..())
			break

///// Dressing exposed flesh
/datum/surgery_step/dress
	name = "Bandage exposed flesh"
	implements = list(/obj/item/stack/medical/gauze = 100, /obj/item/stack/sticky_tape/surgical = 100)
	time = 4 SECONDS

/datum/surgery_step/dress/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
	if(targeted_bodypart)
		display_results(user, target, "<span class='notice'>You begin to dress the flesh on [target]'s [parse_zone(user.zone_selected)]...</span>",
			"<span class='notice'>[user] begins to dress the flesh on [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
			"<span class='notice'>[user] begins to dress the flesh on [target]'s [parse_zone(user.zone_selected)].</span>")
	else
		user.visible_message("<span class='notice'>[user] looks for [target]'s [parse_zone(user.zone_selected)].</span>", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/dress/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
	if(targeted_bodypart)
		display_results(user, target, "<span class='notice'>You successfully wrap [target]'s [parse_zone(target_zone)] with [tool].</span>",
			"<span class='notice'>[user] successfully wraps [target]'s [parse_zone(target_zone)] with [tool]!</span>",
			"<span class='notice'>[user] successfully wraps [target]'s [parse_zone(target_zone)]!</span>")
		log_combat(user, target, "dressed infection in", addition="INTENT: [uppertext(user.a_intent)]")
		targeted_bodypart.apply_gauze(tool)
		targeted_bodypart.germ_level -= WOUND_SANITIZATION_STERILIZER
		if(targeted_bodypart.germ_level < INFECTION_LEVEL_TWO)
			targeted_bodypart.revive_limb()
		for(var/datum/wound/infected_wound in targeted_bodypart.wounds)
			infected_wound.sanitization += 3
			if(istype(infected_wound, /datum/wound/burn))
				var/datum/wound/burn/burn_wound = infected_wound
				burn_wound.flesh_healing += 5
	else
		to_chat(user, "<span class='warning'>[target] has no burns there!</span>")
	return ..()

/datum/surgery_step/dress/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	..()
	if(istype(tool, /obj/item/stack))
		var/obj/item/stack/used_stack = tool
		used_stack.use(2)
