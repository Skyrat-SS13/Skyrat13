//this file is a skyrat edit
/*
	Mechanical wounds are simply put the IPC/Synthliz/Synth equivalent for each wound.
	Instead of using sutures, they get healed with welders - etc.
*/

/datum/wound/mechanical
	name = "mechanical wound"
	desc = "A wound that is mechanical."
	treat_text = "Weld it back together, doofus."
	examine_desc = "is badly dented"
	
	a_or_from = "a"
	occur_text = "sparks"
	sound_effect

	severity = WOUND_SEVERITY_MODERATE
	wound_type = WOUND_LIST_MECHANICAL

	organic_only = FALSE
	robotic_only = TRUE

	treatable_by = list()
	treatable_by_grabbed = list()
	treatable_sharp = FALSE
	accepts_gauze = FALSE
	base_treat_time = 6 SECONDS

	processes = FALSE
	treat_priority = FALSE

	ignore_preexisting = FALSE

	disabling = FALSE

	//list of minerals that can "patch" mechanical wounds, associated with efficiency
	var/list/patch_metals = list(
								/obj/item/stack/sheet/plastic = 0.2,
								/obj/item/stack/sheet/glass = 0.25,
								/obj/item/stack/sheet/rglass = 0.5,
								/obj/item/stack/sheet/plasmaglass = 0.75,
								/obj/item/stack/sheet/plasmarglass = 1,
								/obj/item/stack/sheet/mineral/uranium = 1,
								/obj/item/stack/sheet/mineral/gold = 1,
								/obj/item/stack/sheet/mineral/plasma = 1,
								/obj/item/stack/sheet/titaniumglass = 1.5,
								/obj/item/stack/sheet/plastitaniumglass = 1.75,
								/obj/item/stack/sheet/metal = 2,
								/obj/item/stack/sheet/mineral/silver = 2,
								/obj/item/stack/sheet/runed_metal = 2,
								/obj/item/stack/sheet/plasteel = 2.5,
								/obj/item/stack/sheet/mineral/titanium = 3,
								/obj/item/stack/sheet/mineral/plastitanium = 4,
								/obj/item/stack/sheet/mineral/diamond = 4.25,
								/obj/item/stack/sheet/mineral/abductor = 5,
								/obj/item/stack/sheet/mineral/adamantine = 5,
								/obj/item/stack/sheet/mineral/bananium = 5,
								/obj/item/stack/sheet/mineral/runite = 5,
								)
	/// String naming our patch
	var/patch = ""
	/// Integer to track if a mineral patch was applied, and can be welded proper
	var/patched = 0
	/// Boolean to know if a patch was welded
	var/welded = FALSE
	/// Do we require a patch to weld this wound?
	var/requires_patch = TRUE
	/// Can we repeat patching?
	var/repeat_patch = FALSE
	/// Can we repeat welding?
	var/repeat_weld = FALSE

/datum/wound/mechanical/get_examine_description(mob/user)
	if(!limb.current_gauze && !patch && !welded)
		return ..()
	
	var/msg = ""
	var/sling_condition = ""
	// how much life we have left in these bandages
	switch(limb.current_gauze.obj_integrity / limb.current_gauze.max_integrity * 100)
		if(0 to 25)
			sling_condition = "just barely "
		if(25 to 50)
			sling_condition = "loosely "
		if(50 to 75)
			sling_condition = "mostly "
		if(75 to INFINITY)
			sling_condition = "tightly "

	msg = "<B>[victim.p_their(TRUE)] [limb.name] is [sling_condition] held together with [limb.current_gauze.name]</B>"
	if(!msg && patch)
		msg = "[..()]<B>, and has been patched[welded ? ", and welded," : ""] with [patch]</B>"
	else if(!msg && welded)
		msg = "[..()]<B>, and has been welded</B>"
	return msg

/// if someone is using a mineral sheet on the wound
/datum/wound/mechanical/proc/patch(obj/item/stack/sheet/I, mob/user, power)
	if(!repeat_patch && welded)
		to_chat(user, "<span class='warning'>The limb has already been patched and welded!</span>")
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

	limb.heal_damage(5 * power, 5 * power)
	patch = "[lowertext(I.name)]"
	patched = power
	user.visible_message("<span class='green'>[user] wraps [victim]'s [limb.name] with [I].</span>", "<span class='green'>You wrap [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	return TRUE

/// Welding the patch proper
/datum/wound/mechanical/proc/weld(obj/item/I, mob/user, power = 0)
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

	limb.heal_damage(5, 5)
	welded = TRUE
	if(patched)
		user.visible_message("<span class='green'>[user] welds \the [patch] on [victim]'s [limb.name] with [I].</span>", "<span class='green'>You weld \the patch on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	else
		user.visible_message("<span class='green'>[user] welds \the [lowertext(name)] [victim]'s [limb.name] with [I].</span>", "<span class='green'>You weld \the [lowertext(name)] on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	if(repeat_patch)
		patched = 0
	return TRUE

/// Duct tape gauze
/datum/wound/mechanical/proc/tape(obj/item/stack/sticky_tape/I, mob/user, power = 0)
	if(limb.current_gauze)
		to_chat(user, "<span class='warning'>The limb has already been taped!</span>")
		return
	user.visible_message("<span class='notice'>[user] begins wrapping [victim]'s [limb.name] with \the [I]...</span>", "<span class='notice'>You begin wrapping [user == victim ? "your" : "[victim]'s"] [limb.name] with \the [I]...</span>")
	var/self_penalty_mult = (user == victim ? 2.5 : 1)
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	limb.heal_damage(3, 3)
	limb.apply_gauze(I)
	user.visible_message("<span class='green'>[user] wraps on [victim]'s [limb.name] with [I].</span>", "<span class='green'>You wrap [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>")
	return TRUE

/// We cannot be healed normally.
/datum/wound/mechanical/on_xadone(power)
	return FALSE

/datum/wound/mechanical/on_hemostatic(quantity)
	return FALSE
