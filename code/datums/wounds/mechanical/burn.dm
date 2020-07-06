//the skyrat edit this is
/datum/wound/mechanical/burn
	a_or_from = "from"
	wound_type = WOUND_LIST_BURN_MECHANICAL
	processes = TRUE
	sound_effect = 'modular_skyrat/sound/effects/sizzle1.ogg'

	treatable_by = list(/obj/item/stack/cable_coil)

	associated_alerts = list()

	// Heat warping
	/// How warped our metal is. Once this reaches 0, the wound is considered healed
	var/heat_warping = 5
	/// Our current counter for how much warping decrements on each process tick
	var/heat_warpingnt = 0
	/// Our current counter for how much warping increments on each process tick
	var/heat_warping_rate = 0.3
	/// The maximum heat warping this wound can achieve
	/// Going above this value will set it back to this value,
	/// if we are not promotable
	var/heat_roof = 40

	/// The wound that this will evolve into if left untreated
	/// (keep null so the wound doesn't get promoted at all)
	var/promotes_to
	/// How much heat warping we need to get promoted
	var/promote_threshold = 10

	/// The chance on processing for the affected limb to "malfunction"
	/// Malfunctions either completely disable the limb
	/// or make it inefficient at some tasks for a brief period of time
	/// Using prob() here would not work because we need to use chances
	/// lesser than 1%, so always remember than the malfunction chance is
	/// malf_chance/malf_roof
	var/malf_chance = 70
	var/malf_roof = 1000
	/// The duration of a limb malfunction, in deciseconds
	/// or you know use macros
	var/malf_duration = 10 SECONDS
	/// The time our last malfunction happened on
	var/last_malf = 0
	/// The type of our last malfunction
	var/last_malf_type = ""
	/// The severity of malfunctions
	/// (disable malfunctions do not change by severity)
	/// Any number from 1 to 3
	var/malf_severity = 1
	/// List of types of malfunctions possible
	/// associated with their weight
	var/list/malf_possible = list("disable" = 1,"intent" = 5, "damage" = 4)
	/// Disable: Completely disables the limb for the duration of the malfunction
	/// Intent: The limb will switch the victims intent and interact with something random on the victim's surroundings or inventory
	/// (cannot be the victim's current intent)
	/// Damage: The limb will suffer burn damage for the duration of the malfunction (malf_severity * 2 on each process)

	/// Boolean to track when the limb is malfunctioning to avoid stacking
	var/is_malf = FALSE
	/// Boolean used by the damage malfunction to burn on being processed
	var/damaging = FALSE

	base_treat_time = 6 SECONDS

/datum/wound/mechanical/burn/remove_wound(ignore_limb, replaced, forced)
	. = ..()
	demalfunction("disable")
	demalfunction("intent")
	demalfunction("damage")

/datum/wound/mechanical/burn/handle_process()
	. = ..()
	
	if(world.time > (last_malf + malf_duration))
		for(var/i in malf_possible)
			demalfunction(i)
	
	if(victim.reagents && (severity < WOUND_SEVERITY_CRITICAL))
		if(victim.reagents.has_reagent(/datum/reagent/medicine/liquid_solder))
			heat_warpingnt += 0.3
		if(victim.reagents.has_reagent(/datum/reagent/medicine/nanite_slurry))
			heat_warpingnt += 0.2
		if(victim.reagents.has_reagent(/datum/reagent/medicine/system_cleaner))
			heat_warpingnt += 0.1
	
	if(heat_warpingnt) //treating the wound fully halts progress
		heat_warping_rate = 0
	else
		heat_warping_rate = initial(heat_warping_rate)

	if(damaging)
		victim.apply_damage(damage = malf_severity * 2, damagetype = BURN, def_zone = limb.body_zone, wound_bonus = CANT_WOUND)

	// here's the check to see if we're cleared up
	if(heat_warping <= 0)
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return
	
	// Untreated heat warping will evolve into something worse
	else if(promotes_to && (heat_warping >= promote_threshold))
		to_chat(victim, "<span class='warning'>The deformed metal on your [limb.name] seems to have gotten worse...</span>")
		replace_wound(promotes_to)
		return

	heat_warping = max(min(heat_warping + heat_warping_rate - heat_warpingnt, heat_roof), 0)
	heat_warpingnt = max(heat_warpingnt - 0.2, 0) //if we don't have at least one type of medicine applied, the heat warpingn't will steadily decrease

	var/randumb = rand(1, malf_roof)
	if((randumb <= malf_chance) && !is_malf && !(victim.stat in list(DEAD, UNCONSCIOUS)))
		malfunction(malf_severity, pickweight(malf_possible))

/datum/wound/mechanical/burn/proc/malfunction(power = 1, malf_type = "disable")
	if((last_malf + malf_duration) < world.time && !is_malf)
		switch(malf_type)
			if("disable")
				to_chat(victim, "<span class='deadsay'>Your [limb.name] seems to have gone completely limp...</span>")
				disabling = TRUE
			if("intent")
				go_kooky(power)
			if("damage")
				to_chat(victim, "<span class='userdanger'>Your [limb.name] quickly heats up to a dangerous degree!</span>")
				damaging = TRUE
		last_malf_type = malf_type
		last_malf = world.time
		limb.update_wounds()
		is_malf = TRUE
		return TRUE
	else
		return FALSE

/datum/wound/mechanical/burn/proc/go_kooky(power = 1)
	//1 power means you interact with something on your inventory
	//2 power means you interact with something adjacent to your view
	//3 power means you interact with yourself
	var/chosen_intent = pick(list(INTENT_DISARM, INTENT_HELP, INTENT_GRAB, INTENT_HARM) - victim.a_intent)
	var/chosen_zone = pick(ALL_BODYPARTS - victim.zone_selected)
	var/obj/screen/zone_sel/sel = victim.hud_used?.zone_select
	victim.a_intent_change(chosen_intent)
	if(limb.held_index)
		victim.swap_hand(limb.held_index)
		if(istype(sel))
			sel.set_selected_zone(chosen_zone)
	var/mob/living/carbon/human/H = victim
	if(!istype(H))
		return
	switch(power)
		if(1)
			if(limb.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND))
				to_chat(H, "<span class='danger'>Your [limb.name] flops around wildly!</span>")
				var/list/targets = list(H.shoes, H.gloves, H.ears,
										H.glasses, H.w_uniform, H.wear_suit,
										H.wear_mask, H.wear_neck, H.head,
										H.r_store, H.l_store, H.back)
				var/atom/A
				var/failsafe = 0
				while(!A)
					failsafe++
					if((failsafe >= 15) || (targets.len))
						last_malf = 0
						return malfunction(power, "disable")
					A = pick_n_take(targets)
				if(istype(A))
					if(H.get_active_held_item())
						H.drop_all_held_items()
					H.ClickOn(A)
					if(H.back == A)
						A.storage_contents_dump_act(get_turf(H), H)
					var/atom/B
					while(!B)
						failsafe++
						if((failsafe >= 15) || (targets.len))
							last_malf = 0
							return malfunction(power, "disable")
						B = pick_n_take(targets)
					if(prob(33))
						H.a_intent_change(INTENT_HARM)
					H.ClickOn(A)
					H.ClickOn(B)
			else if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_GROIN))
				to_chat(H, "<span class='danger'>Your [limb.name] moves on it's own!</span>")
				H.Move(get_step(H, pick(GLOB.alldirs)))
			else if(limb.body_zone == BODY_ZONE_CHEST)
				to_chat(H, "<span class='danger'>Your [limb.name] fails to receive input!</span>")
				H.Paralyze(10, TRUE)
			else if(limb.body_zone == BODY_ZONE_HEAD)
				to_chat(H, "<span class='danger'>Your [limb.name] runs out of memory!</span>")
				H.adjust_blindness(50)
		if(2)
			if(limb.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND))
				to_chat(H, "<span class='userdanger'>You lose control of your [limb.name]!</span>")
				var/list/targets = list()
				var/list/mobs = list()
				var/list/objs = list()
				var/list/turfs = list()
				for(var/atom/A in (view(1, H) - H))
					if(!isarea(A))
						targets += A
					if(ismob(A))
						mobs += A
					if(isobj(A))
						objs += A
					if(isturf(A))
						turfs += A
				var/atom/B
				// The priority for interaction is:
				// Mob, obj, turf
				// If we somehow fail all of these, we pick from targets
				// If there are no targets somehow, we return this proc
				// but attempt a full disable instead
				if(length(mobs))
					B = pick(mobs)
				else if(length(objs))
					B = pick(objs)
				else if(length(turfs))
					B = pick(objs)
				else if(length(targets))
					B = pick(targets)
				else
					last_malf = 0
					return malfunction(power, "disable")
				if(prob(33))
					H.a_intent_change(INTENT_HARM)
				if(H.get_active_held_item())
					H.ClickOn(H.get_active_held_item())
				if(istype(B))
					H.ClickOn(B)
			else if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_GROIN))
				to_chat(H, "<span class='userdanger'>Your [limb.name] gets stuck in a while loop!</span>")
				var/list/turfs = list()
				for(var/turf/T in (view(5, H) - H.loc))
					if(length(get_path_to(H, T)))
						turfs += T
				var/turf/walkie = pick(turfs)
				if(istype(walkie))
					walk_to(H, walkie, 0, 3, 0)
			else if(limb.body_zone == BODY_ZONE_CHEST)
				to_chat(H, "<span class='warning'>Your [limb.name] runtimes at line [rand(1,1000)] of [pick("life.dm", "bodypart.dm", "mob_defense.dm", "AI.dm", "[lowertext(H.dna.species.name)].dm")]!</span>")
				H.DefaultCombatKnockdown(35)
			else
				to_chat(H, "<span class='warning'>Your [limb.name] loses it's connection!</span>")
				H.Sleeping(60)
		if(3)
			if(limb.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND))
				to_chat(H, "<span class='warning'>Your [limb.name] fails to compile!</span>")
				H.a_intent_change(INTENT_HARM)
				H.ClickOn(H)
				var/continue_hitting_yourself = TRUE
				while(continue_hitting_yourself)
					if(prob(35))
						H.changeNext_move(0)
						H.ClickOn(H)
					else
						continue_hitting_yourself = FALSE
				H.changeNext_move(CLICK_CD_MELEE * 5)
			else if(limb.body_zone in list(BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_GROIN))
				to_chat(H, "<span class='warning'>Your [limb.name] locks up!</span>")
				H.lay_down()
				H.Paralyze(30)
				H.adjustStaminaLoss(30)
				H.adjustStaminaLossBuffered(50)
			else if(limb.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_CHEST))
				to_chat(H, "<span class='warning'>Your [limb.name] divides by zero!</span>")
				H.Unconscious(150)

/datum/wound/mechanical/burn/proc/demalfunction(malf_type = "disable")
	switch(malf_type)
		if("disable")
			disabling = initial(disabling)
		if("intent")
			walk_to(victim, 0)
		if("damage")
			damaging = FALSE
	is_malf = FALSE
	limb.update_wounds()
	return TRUE

/datum/wound/mechanical/burn/get_scanner_description(mob/victim)
	. = ..()
	. += "<div class='ml-3'>"
	. += "Alternative treatment: Apply synthetic repair chemicals to the patient (liquid solder, nanite slurry or system cleaner). While these chemicals are in the patient's system, the wound will gradually diminish - apply all of these reagents for best results."
	. += "</div>"

/datum/wound/mechanical/burn/treat(obj/item/I, mob/victim)
	if(istype(I, /obj/item/stack/cable_coil))
		cable(I, victim)

/*
	new mechanical burn common procs
*/

/// if someone is using cable on the wound
/datum/wound/mechanical/burn/proc/cable(obj/item/stack/cable_coil/I, mob/victim)
	victim.visible_message("<span class='notice'>[victim] begins repairing [victim]'s [limb.name]'s damaged wires with [I]...</span>", "<span class='notice'>You begin begin repairing [victim]'s [limb.name]'s damaged wires with [I]...</span>")
	if(!do_after(victim, (victim == victim ? 4 SECONDS : 1 SECONDS), extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	limb.heal_damage(0, 5)
	victim.visible_message("<span class='green'>[victim] repairs some of the wiring on [victim]'s [limb.name].</span>", "<span class='green'>You repair some of the wiring on [victim]'s [limb.name].</span>")
	I.use(10)
	heat_warpingnt += 1.25

	if(heat_warping <= 0 || heat_warpingnt >= 10)
		to_chat(victim, "<span class='notice'>You've done all you can with [I], now you must wait for the BIOS on [victim]'s [limb.name] to recover.</span>")
	else
		try_treating(I, victim)

/*
	the actual fucking wounds
*/

/datum/wound/mechanical/burn/moderate
	name = "Molten Wires"
	desc = "Patient's limb has suffered considerable damage to it's wiring, occasionally causing malfunctions and leaving the limb more susceptible to internal damage."
	treat_text = "Recommended full internal repair, although cable coil may suffice."
	examine_desc = "has visible pools of molten cable sleeving"
	occur_text = "sparks and pops audibly"
	severity = WOUND_SEVERITY_MODERATE
	damage_multiplier_penalty = 1.1
	threshold_minimum = 40
	threshold_penalty = 30 // burns cause significant decrease in limb integrity compared to other wounds
	status_effect_type = /datum/status_effect/wound/burn/moderate
	malf_chance = 16
	malf_roof = 1000
	malf_duration = 10 SECONDS
	heat_warping = 6
	heat_warping_rate = 0.05 // takes about 8 minutes completely untreated to progress
	promotes_to = /datum/wound/mechanical/burn/severe
	promote_threshold = 18
	malf_possible = list("disable" = 1,"intent" = 7, "damage" = 2)
	scarring_descriptions = list("small amoeba-shaped skinmarks", "a faded streak of depressed skin")

/datum/wound/mechanical/burn/severe
	name = "Burnt Transistors"
	desc = "Patient's limb has suffered considerable damage to it's wiring and internals, causing frequent malfunctions and leaving the limb quite vulnerable to damage."
	treat_text = "Recommended full internal repair."
	treatable_by = list()
	examine_desc = "appears mildly warped, with partially charred internal components"
	occur_text = "flares up with a small flame, noxious smoke coming out of it"
	severity = WOUND_SEVERITY_SEVERE
	damage_multiplier_penalty = 1.25
	threshold_minimum = 80
	threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/burn/severe
	malf_chance = 15
	malf_roof = 1000
	malf_duration = 20 SECONDS
	heat_warping = 18
	heat_warping_rate = 0.1 // about 4 minutes to progress
	promotes_to = /datum/wound/mechanical/burn/critical
	promote_threshold = 20
	malf_possible = list("disable" = 3,"intent" = 4, "damage" = 3)
	scarring_descriptions = list("a large, jagged patch of faded skin", "random spots of shiny, smooth skin", "spots of taut, leathery skin")

/datum/wound/mechanical/burn/critical
	name = "Catastrophic Melting"
	desc = "Patient's limb has been severely deformed by high heat, along with complete charring of many internal components, causing extreme malfunctioning and leaving the limb extremely frail."
	treat_text = "Full reconstruction or replacement of the affected limb."
	treatable_by = list()
	examine_desc = "is completely deformed, constantly sparking and smoking from it's charred components"
	occur_text = "melts and pools around itself"
	severity = WOUND_SEVERITY_CRITICAL
	damage_multiplier_penalty = 1.4
	sound_effect = 'modular_skyrat/sound/effects/sizzle2.ogg'
	threshold_minimum = 140
	threshold_penalty = 80
	malf_chance = 40
	malf_roof = 1000
	malf_duration = 30 SECONDS
	status_effect_type = /datum/status_effect/wound/burn/critical
	heat_warping = 20
	heat_warping_rate = 0.15 // although it cannot progress, it will get increasingly harder to fully treat until it reaches heat_roof
	malf_possible = list("disable" = 5, "intent" = 2, "damage" = 3)
	scarring_descriptions = list("massive, disfiguring keloid scars", "several long streaks of badly discolored and malformed skin", "unmistakeable splotches of dead tissue from serious burns")
