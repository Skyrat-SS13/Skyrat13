//skyrat edit obviously
/*
	Pierce
*/

/datum/wound/mechanical/pierce
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_LIST_PIERCE_MECHANICAL
	treatable_by = list(/obj/item/stack/sticky_tape, /obj/item/stack/sheet)
	treatable_tool = TOOL_WELDER
	base_treat_time = 7 SECONDS
	accepts_gauze = FALSE //we use our own weird sticky tape method as gauze

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// If gauzed, what percent of the internal bleeding actually clots of the total absorption rate
	var/gauzed_clot_rate
	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient

	requires_patch = FALSE
	repeat_patch = TRUE
	repeat_weld = TRUE

/datum/wound/mechanical/pierce/wound_injury(datum/wound/old_wound)
	blood_flow = initial_flow

/datum/wound/mechanical/pierce/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat == DEAD || wounding_dmg < 5)
		return
	if(victim.blood_volume && prob(internal_bleeding_chance + wounding_dmg))
		if(limb.current_gauze && limb.current_gauze.splint_factor)
			wounding_dmg *= (1 - limb.current_gauze.splint_factor)
		var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient) // 12 brute toolbox can cause up to 15/18/21 bloodloss on mod/sev/crit
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message("<span class='smalldanger'>Hydraulic fluid leaks from the hole in [victim]'s [limb.name].</span>", "<span class='danger'>You leak hydraulic fluid from the blow to your [limb.name].</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message("<span class='smalldanger'>A small stream of hydraulic fluid spurts from the hole in [victim]'s [limb.name]!</span>", "<span class='danger'>You spurt a string of hydraulic fluid from the blow to your [limb.name]!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message("<span class='danger'>A spray of hydraulic fluid streams from the gash in [victim]'s [limb.name]!</span>", "<span class='danger'><b>You gush out a spray of hydraulic fluid from the blow to your [limb.name]!</b></span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/mechanical/pierce/handle_process()
	blood_flow = min(blood_flow, WOUND_SLASH_MAX_BLOODFLOW)

	if(limb.current_gauze)
		blood_flow -= limb.current_gauze.absorption_rate * gauzed_clot_rate
		limb.current_gauze.absorption_capacity -= limb.current_gauze.absorption_rate

	if(blood_flow <= 0)
		qdel(src)

/datum/wound/mechanical/pierce/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sheet))
		var/repair = 0
		for(var/i in patch_metals)
			if(istype(I, i))
				repair = patch_metals[i]
		if(repair)
			patch(I, user, repair)
	else if(istype(I, /obj/item/stack/sticky_tape))
		tape(I, user, patched)
	else if(I.tool_behaviour == treatable_tool)
		weld(I, user, patched)

/datum/wound/mechanical/pierce/weld(obj/item/I, mob/user, power = 0)
	if(!repeat_weld && welded)
		to_chat(user, "<span class='warning'>The limb has already been welded!</span>")
		return
	if(requires_patch && !patched)
		to_chat(user, "<span class='warning'>The limb doesn't have a mineral patch!</span>")
		return
	if(patched)
		user.visible_message("<span class='notice'>[user] begins welding \the [patch] on [victim]'s [limb.name] with \the [I]...</span>", "<span class='notice'>You begin welding \the [patch] [user == victim ? "your" : "[victim]'s"] [limb.name] with \the [I]...</span>")
	else
		user.visible_message("<span class='notice'>[user] begins welding \the [lowertext(name)] on [victim]'s [limb.name] with \the [I]...</span>", "<span class='notice'>You begin welding \the [lowertext(name)] on [user == victim ? "your" : "[victim]'s"] [limb.name] with \the [I]...</span>")
	var/self_penalty_mult = (user == victim ? 2.5 : 1)
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	limb.heal_damage(2.5, 2.5)
	welded = TRUE
	if(patched)
		user.visible_message("<span class='green'>[user] welds \the [patch] on [victim]'s [limb.name] with [I].</span>", "<span class='green'>You weld \the patch on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	else
		user.visible_message("<span class='green'>[user] welds \the [lowertext(name)] [victim]'s [limb.name] with [I].</span>", "<span class='green'>You weld \the [lowertext(name)] on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	var/blood_cauterized = (1 / self_penalty_mult) * 0.25 * max(0.5, patched)
	blood_flow -= blood_cauterized

	if(repeat_patch)
		patched = 0

	if((blood_flow > 0) && (repeat_weld) && !requires_patch)
		try_treating(I, user)
	return TRUE

/datum/wound/mechanical/pierce/patch(obj/item/stack/sheet/I, mob/user, power)
	if(!repeat_patch && welded)
		to_chat(user, "<span class='warning'>The limb has already been welded!</span>")
		return
	else if(patched)
		to_chat(user, "<span class='warning'>The limb has already been patched!</span>")
		return
	user.visible_message("<span class='notice'>[user] begins wrapping [victim]'s [limb.name] with \the [I]...</span>", "<span class='notice'>You begin wrapping [user == victim ? "your" : "[victim]'s"] [limb.name] with \the [I]...</span>")
	var/self_penalty_mult = (user == victim ? 2.5 : 1)
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	
	if(!I.use(2))
		to_chat(user, "<span class='warning'>[capitalize(I)] doesn't have enough sheets!</span>")
		return

	limb.heal_damage(3.5 * power/2, 2.5 * power)
	var/blood_cauterized = power * 0.10
	blood_flow -= blood_cauterized
	patch = "[lowertext(I.name)]"
	patched = power
	user.visible_message("<span class='green'>[user] wraps [victim]'s [limb.name] with [I].</span>", "<span class='green'>You wrap [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	return TRUE

/datum/wound/mechanical/pierce/get_examine_description(mob/user)
	if(!patch && !welded)
		return ..()

	var/msg = ""
	if(!patch && welded)
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc], but it has been [(blood_flow < initial_flow * 0.65) ? "decently" : "poorly"] welded together"
	else if(patch && !welded)
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc], but it has been [(blood_flow < initial_flow * 0.65) ? "decently" : "poorly"] patched with \the [patch]"
	else
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc], but it has been [(blood_flow < initial_flow * 0.65) ? "decently" : "poorly"] patched and welded with \the [patch]"
	msg += "!"
	return "<B>[msg]</B>"

/datum/wound/mechanical/pierce/moderate
	name = "Minor Dent"
	desc = "Patient's exoskeleton has been slightly punctured, causing minor hydraulic leakage in the affected area."
	treat_text = "Recommended mineral patching and welding of the affected area, but application of sticky tape may suffice."
	examine_desc = "has a small, circular hole, gently leaking"
	occur_text = "spurts out a thin stream of hydraulic fluid"
	sound_effect = 'modular_skyrat/sound/effects/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	treatable_by = list(/obj/item/stack/sticky_tape, /obj/item/stack/sheet)
	initial_flow = 1.5
	gauzed_clot_rate = 0.8
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 30
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scarring_descriptions = list("a small, faded bruise", "a small twist of reformed skin", "a thumb-sized puncture scar")

/datum/wound/mechanical/pierce/severe
	name = "Open Dent"
	desc = "Patient's internals have been severely punctured, causing reduced limb stability and noticeable hydraulic leakage."
	treat_text = "Recommended full internal repair, but mineral patching and welding of the limb may suffice."
	examine_desc = "is pierced clear through, with jagged metal edges leaking hydraulic fluids"
	occur_text = "looses a violent spray of hydraulic fluid, revealing a considerable hole"
	sound_effect = 'modular_skyrat/sound/effects/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	treatable_by = list(/obj/item/stack/sheet)
	initial_flow = 2.25
	gauzed_clot_rate = 0.6
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	threshold_minimum = 50
	threshold_penalty = 25
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scarring_descriptions = list("an ink-splat shaped pocket of scar tissue", "a long-faded puncture wound", "a tumbling puncture hole with evidence of faded stitching")

/datum/wound/mechanical/pierce/critical
	name = "Ruptured Hydraulics"
	desc = "Patient's hydraulic cablings have been shredded, causing critical leakage and damage to internal components."
	treat_text = "Full internal repair of the affected area."
	examine_desc = "is ripped clear through, barely held together by it's endoskeleton"
	occur_text = "blasts apart, sending chunks of viscera flying in all directions"
	sound_effect = 'modular_skyrat/sound/effects/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	treatable_by = list()
	treatable_tool = NONE
	initial_flow = 3
	gauzed_clot_rate = 0.4
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.75
	threshold_minimum = 100
	threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scarring_descriptions = list("a rippling shockwave of scar tissue", "a wide, scattered cloud of shrapnel marks", "a gruesome multi-pronged puncture scar")
