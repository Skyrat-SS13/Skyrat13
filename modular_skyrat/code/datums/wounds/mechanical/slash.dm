//skyrat edit file
/*
	Cuts
*/

/datum/wound/mechanical/slash
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_LIST_SLASH_MECHANICAL
	treatable_by = list(/obj/item/stack/sticky_tape, /obj/item/stack/sheet)
	treatable_tool = TOOL_WELDER
	treat_priority = TRUE

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// When we have less than this amount of flow, we demote to a lower cut or are healed of the wound
	var/minimum_flow
	/// How fast our blood flow will naturally decrease per tick, not only do larger cuts bleed more faster, they clot slower
	var/clot_rate

	/// Once the blood flow drops below minimum_flow, we demote it to this type of wound. If there's none, we're all better
	var/demotes_to

	/// How much staunching per type (cautery, suturing, bandaging) you can have before that type is no longer effective for this cut NOT IMPLEMENTED
	var/max_per_type
	/// The maximum flow we've had so far
	var/highest_flow

	requires_patch = FALSE
	repeat_patch = TRUE
	repeat_weld = TRUE

	base_treat_time = 2.5 SECONDS
	biology_required = list(HAS_FLESH)
	required_status = BODYPART_ROBOTIC
	can_self_treat = TRUE

/datum/wound/mechanical/slash/self_treat(mob/living/carbon/user, first_time = FALSE)
	. = ..()
	if(.)
		return TRUE
	
	if(victim && limb?.body_zone)
		var/obj/screen/zone_sel/sel = victim.hud_used?.zone_select
		if(istype(sel))
			sel.set_selected_zone(limb?.body_zone)
			victim.grabbedby(victim)
		return

/datum/wound/mechanical/slash/wound_injury(datum/wound/slash/old_wound = null)
	blood_flow = initial_flow
	if(old_wound)
		blood_flow = max(old_wound.blood_flow, initial_flow)

/datum/wound/mechanical/slash/get_examine_description(mob/user)
	if(!patch && !welded)
		return ..()

	var/msg = ""
	if(!patch && welded)
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc], but it has been [(blood_flow < initial_flow * 0.65) ? "decently" : "poorly"] welded together"
	else if(patch && !welded)
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc], but it has been [(blood_flow < initial_flow * 0.65) ? "decently" : "poorly"] patched with \the [patch]"
	else
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc], but it has been [(blood_flow < initial_flow * 0.65) ? "decently" : "poorly"] patched and welded with \the [patch]"
	return "<B>[msg]!</B>"

/datum/wound/mechanical/slash/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim || victim.stat == DEAD || wounding_dmg < WOUND_MINIMUM_DAMAGE)
		return
	if(wounding_type in list(WOUND_SLASH, WOUND_PIERCE)) // can't stab dead bodies to make them leak faster
		blood_flow += 0.05 * wounding_dmg

/datum/wound/mechanical/slash/drag_bleed_amt()
	// compare with being at 100 brute damage before, where you bled (brute/100 * 2), = 2 blood per tile
	var/bleed_amt = min(blood_flow * 0.1, 1) // 3 * 3 * 0.1 = 0.9 blood total, less than before! the share here is .6 blood of course.

	if(limb.current_gauze) // gauze stops all bleeding from dragging on this limb, but wears the gauze out quicker
		limb.seep_gauze(bleed_amt * 0.33)
		return
	testing("blood from drag [name]: [bleed_amt]")
	return bleed_amt

/datum/wound/mechanical/slash/handle_process()
	blood_flow = min(blood_flow, WOUND_SLASH_MAX_BLOODFLOW)

	if(limb.current_gauze)
		if(clot_rate > 0)
			blood_flow -= clot_rate
		blood_flow -= limb.current_gauze.absorption_rate
		limb.seep_gauze(limb.current_gauze.absorption_rate)
	else
		blood_flow -= clot_rate

	if(blood_flow > highest_flow)
		highest_flow = blood_flow

	if(blood_flow < minimum_flow)
		if(demotes_to)
			replace_wound(demotes_to)
		else
			to_chat(victim, "<span class='green'>The cut on your [limb.name] has stopped bleeding!</span>")
			qdel(src)

/datum/wound/mechanical/slash/on_stasis()
	if(blood_flow < minimum_flow)
		if(demotes_to)
			replace_wound(demotes_to)
		else
			qdel(src)
		return

/* BEWARE, THE BELOW NONSENSE IS MADNESS. blunt.dm looks more like what I have in mind and is sufficiently clean, don't pay attention to this messiness */

/datum/wound/mechanical/slash/treat(obj/item/I, mob/user)
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

/datum/wound/mechanical/slash/weld(obj/item/I, mob/user, power = 0)
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
	var/self_penalty_mult = (user == victim ? 2 : 1)
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	limb.heal_damage(10, 10)
	welded = TRUE
	if(patched)
		user.visible_message("<span class='green'>[user] welds \the [patch] on [victim]'s [limb.name] with [I].</span>", "<span class='green'>You weld \the patch on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	else
		user.visible_message("<span class='green'>[user] welds \the [lowertext(name)] [victim]'s [limb.name] with [I].</span>", "<span class='green'>You weld \the [lowertext(name)] on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	var/blood_cauterized = (1 / self_penalty_mult) * max(0.5, patched)
	blood_flow -= blood_cauterized

	if(repeat_patch)
		patched = 0

	if((blood_flow > minimum_flow) && (repeat_weld) && !requires_patch)
		try_treating(I, user)
	else if(demotes_to)
		to_chat(user, "<span class='green'>You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts.</span>")
	return TRUE

/datum/wound/mechanical/slash/patch(obj/item/stack/sheet/I, mob/user, power)
	if(!repeat_patch && welded)
		to_chat(user, "<span class='warning'>The limb has already been welded!</span>")
		return
	else if(patched)
		to_chat(user, "<span class='warning'>The limb has already been patched!</span>")
		return
	user.visible_message("<span class='notice'>[user] begins wrapping [victim]'s [limb.name] with \the [I]...</span>", "<span class='notice'>You begin wrapping [user == victim ? "your" : "[victim]'s"] [limb.name] with \the [I]...</span>")
	var/self_penalty_mult = (user == victim ? 2 : 1)
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	
	if(!I.use(max(1, severity - WOUND_SEVERITY_TRIVIAL)))
		to_chat(user, "<span class='warning'>There aren't enough stacks of [I.name] to patch \the [src.name]!</span>")
		return

	limb.heal_damage(5 * power, 5 * power)
	var/blood_cauterized = power * 0.15
	blood_flow -= blood_cauterized
	patch = "[lowertext(I.name)]"
	patched = power
	user.visible_message("<span class='green'>[user] wraps [victim]'s [limb.name] with [I].</span>", "<span class='green'>You wrap [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	return TRUE

/datum/wound/mechanical/slash/moderate
	name = "Ripped Metal"
	desc = "Patient's exoskeleton has been badly ripped, generating moderate hydraulic leakage."
	treat_text = "Recommended mineral patching and welding of the affected area, but application of sticky tape may suffice."
	examine_desc = "has an open tear"
	occur_text = "is ripped open, slowly leaking hydraulic fluid"
	sound_effect = 'modular_skyrat/sound/effects/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = ALL_BODYPARTS
	initial_flow = 2
	minimum_flow = 0.5
	max_per_type = 3
	clot_rate = 0.15
	threshold_minimum = 20
	threshold_penalty = 10
	status_effect_type = /datum/status_effect/wound/slash/moderate
	scarring_descriptions = list("light, faded lines", "minor cut marks", "a small faded slit", "a series of small scars")

/datum/wound/mechanical/slash/severe
	name = "Jagged Tear"
	desc = "Patient's exoskleton has been severely ripped, allowing significant fluid leakage."
	treat_text = "Recommended full internal repair, but mineral patching, taping and welding of the limb may suffice."
	examine_desc = "has a severe tear"
	occur_text = "is ripped open, cables spurting fluid"
	sound_effect = 'modular_skyrat/sound/effects/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	viable_zones = ALL_BODYPARTS
	initial_flow = 3.25
	minimum_flow = 2.75
	clot_rate = 0.07
	max_per_type = 4
	threshold_minimum = 50
	threshold_penalty = 25
	demotes_to = /datum/wound/mechanical/slash/moderate
	status_effect_type = /datum/status_effect/wound/slash/severe
	scarring_descriptions = list("a twisted line of faded gashes", "a gnarled sickle-shaped slice scar", "a long-faded puncture wound")

/datum/wound/mechanical/slash/critical
	name = "Torn Cabling"
	desc = "Patient's exoskeleton is completely torn open, along with loss of armoring. Extreme leakage."
	treat_text = "Full internal repair of the affected area, but mineral patching, taping and welding of the limb can prevent a worsening situation."
	examine_desc = "is spurting hydraulic fluid at an alarming rate"
	occur_text = "is torn open, spraying fluid wildly"
	sound_effect = 'modular_skyrat/sound/effects/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	viable_zones = ALL_BODYPARTS
	initial_flow = 4.25
	minimum_flow = 4
	clot_rate = -0.05 // critical cuts actively get worse instead of better
	max_per_type = 5
	threshold_minimum = 80
	threshold_penalty = 40
	demotes_to = /datum/wound/mechanical/slash/severe
	status_effect_type = /datum/status_effect/wound/slash/critical
	scarring_descriptions = list("a winding path of very badly healed scar tissue", "a series of peaks and valleys along a gruesome line of cut scar tissue", "a grotesque snake of indentations and stitching scars")

/datum/wound/mechanical/slash/critical/incision
	name = "Open Hatch"
	desc = "Patient has had his hatch opened for surgical purposes."
	treat_text = "Finalization of surgical procedures on the affected limb."
	examine_desc = "is mechanically opened, components visible from it's open hatches"
	occur_text = "is mechanically breached"
	sound_effect = 'modular_skyrat/sound/effects/blood1.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	viable_zones = ALL_BODYPARTS
	wound_type = WOUND_LIST_INCISION_MECHANICAL
	initial_flow = 1.5
	minimum_flow = 0.1
	clot_rate = 0.02
	max_per_type = 5
	demotes_to = null
	scarring_descriptions = list("a precise line of scarred tissue", "a long line of slightly darker tissue")
