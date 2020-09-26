//the skyrat edit this is
// TODO: well, a lot really, but specifically I want to add potential fusing of clothing/equipment on the affected area, and limb infections, though those may go in body part code
/datum/wound/burn
	a_or_from = "from"
	wound_type = WOUND_LIST_BURN
	processes = TRUE
	sound_effect = 'modular_skyrat/sound/effects/sizzle1.ogg'

	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh) // sterilizer and alcohol will require reagent treatments, coming soon

	associated_alerts = list("sepsis" = /obj/screen/alert/status_effect/wound/sepsis)

	// Flesh damage vars
	/// How much damage to our flesh we currently have. Once both this and germ_level reach 0, the wound is considered healed
	var/flesh_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers flesh_damage
	var/flesh_healing = 0

	base_treat_time = 3 SECONDS
	biology_required = list(HAS_FLESH)
	required_status = BODYPART_ORGANIC
	pain_amount = 5 //Burns are awful
	infection_chance = 25
	infection_rate = 1.5

/datum/wound/burn/handle_process()
	. = ..()
	if(flesh_healing > 0)
		var/bandage_factor = (limb.current_gauze ? limb.current_gauze.splint_factor : 1)
		flesh_damage = max(0, flesh_damage - 1)
		flesh_healing = max(0, flesh_healing - bandage_factor) // good bandages multiply the length of flesh healing

	if((flesh_damage <= 0) && (germ_level <= WOUND_INFECTION_SANITIZATION_RATE))
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return

/datum/wound/burn/get_scanner_description(mob/user)
	. = ..()
	. += "<div class='ml-3'>"

	if(germ_level <= sanitization && flesh_damage <= flesh_healing)
		. += "No further treatment required: Burns will heal shortly."
	else
		if(flesh_damage > 0)
			. += "Flesh damage detected: Please apply ointment or regenerative mesh to allow recovery.\n"
	. += "</div>"

/datum/wound/burn/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/medical/ointment))
		ointment(I, user)
	else if(istype(I, /obj/item/stack/medical/mesh))
		mesh(I, user)
	else if(istype(I, /obj/item/flashlight/pen/paramedic))
		uv(I, user)

/*
	new burn common procs
*/

/// If someone is using ointment on our burns
/datum/wound/burn/ointment(obj/item/stack/medical/ointment/I, mob/user)
	user.visible_message("<span class='notice'>[user] begins applying [I] to [victim]'s [limb.name]...</span>", "<span class='notice'>You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]...</span>")
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay), target = victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	if(!I.use(1))
		to_chat(user, "<span class='warning'>There aren't enough stacks of [I.name] to heal \the [src.name]!</span>")
		return
	
	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message("<span class='green'>[user] applies [I] to [victim].</span>", "<span class='green'>You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name].</span>")
	sanitization += I.sanitization
	flesh_healing += I.flesh_regeneration

	if((germ_level <= 0 || sanitization >= germ_level) && (flesh_damage <= 0 || flesh_healing > flesh_damage))
		to_chat(user, "<span class='notice'>You've done all you can with [I], now you must wait for the flesh on [victim]'s [limb.name] to recover.</span>")
	else
		try_treating(I, user)

/// If someone is using mesh on our burns
/datum/wound/burn/mesh(obj/item/stack/medical/mesh/I, mob/user)
	user.visible_message("<span class='notice'>[user] begins wrapping [victim]'s [limb.name] with [I]...</span>", "<span class='notice'>You begin wrapping [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]...</span>")
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay), target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	if(!I.use(1))
		to_chat(user, "<span class='warning'>There aren't enough stacks of [I.name] to heal \the [src.name]!</span>")
		return
	
	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message("<span class='green'>[user] applies [I] to [victim].</span>", "<span class='green'>You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name].</span>")
	sanitization += I.sanitization
	flesh_healing += I.flesh_regeneration

	if(sanitization >= germ_level && flesh_healing > flesh_damage)
		to_chat(user, "<span class='notice'>You've done all you can with [I], now you must wait for the flesh on [victim]'s [limb.name] to recover.</span>")
	else
		try_treating(I, user)

/// basic support for instabitaluri/synthflesh healing flesh damage, more chem support in the future
/datum/wound/burn/proc/regenerate_flesh(amount)
	flesh_healing += amount * 0.5 // 20u patch will heal 10 flesh standard

// we don't even care about first degree burns, straight to second
/datum/wound/burn/moderate
	name = "Second Degree Burns"
	desc = "Patient is suffering considerable burns with mild skin penetration, weakening limb integrity and increased burning sensations."
	treat_text = "Recommended application of topical ointment or regenerative mesh to affected region."
	examine_desc = "is badly burnt and breaking out in blisters"
	occur_text = "breaks out with violent red burns"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = ALL_BODYPARTS
	damage_multiplier_penalty = 1.1
	threshold_minimum = 40
	threshold_penalty = 30 // burns cause significant decrease in limb integrity compared to other wounds
	status_effect_type = /datum/status_effect/wound/burn/moderate
	flesh_damage = 5
	scarring_descriptions = list("small amoeba-shaped skinmarks", "a faded streak of depressed skin")
	pain_amount = 7 //Burns are awful
	infection_chance = 30
	infection_rate = 1.5

/datum/wound/burn/severe
	name = "Third Degree Burns"
	desc = "Patient is suffering extreme burns with full skin penetration, creating serious risk of infection and greatly reduced limb integrity."
	treat_text = "Recommended immediate disinfection and excision of any infected skin, followed by bandaging and ointment."
	examine_desc = "appears seriously charred, with aggressive red splotches"
	occur_text = "chars rapidly, exposing ruined tissue and spreading angry red burns"
	severity = WOUND_SEVERITY_SEVERE
	viable_zones = ALL_BODYPARTS
	damage_multiplier_penalty = 1.2
	threshold_minimum = 80
	threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/burn/severe
	treatable_by = list(/obj/item/flashlight/pen/paramedic, /obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	flesh_damage = 12.5
	scarring_descriptions = list("a large, jagged patch of faded skin", "random spots of shiny, smooth skin", "spots of taut, leathery skin")
	pain_amount = 10 //Burns are awful
	infection_chance = 60
	infection_rate = 2

/datum/wound/burn/critical
	name = "Catastrophic Burns"
	desc = "Patient is suffering near complete loss of tissue and significantly charred muscle and bone, creating life-threatening risk of infection and negligible limb integrity."
	treat_text = "Immediate surgical debriding of any infected skin, followed by potent tissue regeneration formula and bandaging."
	examine_desc = "is a ruined mess of blanched bone, melted fat, and charred tissue"
	occur_text = "vaporizes as flesh, bone, and fat melt together in a horrifying mess"
	severity = WOUND_SEVERITY_CRITICAL
	viable_zones = ALL_BODYPARTS
	damage_multiplier_penalty = 1.3
	sound_effect = 'modular_skyrat/sound/effects/sizzle2.ogg'
	threshold_minimum = 140
	threshold_penalty = 80
	status_effect_type = /datum/status_effect/wound/burn/critical
	treatable_by = list(/obj/item/flashlight/pen/paramedic, /obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh)
	flesh_damage = 20
	scarring_descriptions = list("massive, disfiguring keloid scars", "several long streaks of badly discolored and malformed skin", "unmistakeable splotches of dead tissue from serious burns")
	pain_amount = 16 //Burns are awful
	infection_chance = 80
	infection_rate = 3
