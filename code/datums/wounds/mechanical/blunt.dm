// "Bones"
/datum/wound/mechanical/blunt
	sound_effect = 'sound/effects/clang1.ogg'
	a_or_from = "from"
	wound_type = WOUND_LIST_BLUNT_MECHANICAL

	associated_alerts = list("bone" = /obj/screen/alert/status_effect/wound/blunt)

	/// Have we been taped?
	var/taped
	/// Have we been wrenched?
	var/wrenched
	/// If we did the tape + slurry healing method for "fractures", how many regen points we need
	var/regen_points_needed
	/// Our current counter for wrench + slurry regeneration
	var/regen_points_current
	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	/// If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	/// How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown
	/// Chance to shock and stun the owner when hit
	var/shock_chance = 0

	base_treat_time = 6 SECONDS

/*
	Overwriting of base procs
*/

/datum/wound/mechanical/blunt/wound_injury(datum/wound/old_wound = null)
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	//RegisterSignal(victim, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, .proc/attack_with_hurt_hand)
	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/twohanded/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message("<span class='danger'>[victim] drops [I] in shock!</span>", "<span class='warning'><b>The force on your [limb.name] causes you to drop [I]!</b></span>", vision_distance=COMBAT_MESSAGE_RANGE)

	update_inefficiencies()

/datum/wound/mechanical/blunt/remove_wound(ignore_limb, replaced)
	limp_slowdown = 0
	QDEL_NULL(active_trauma)
	/*
	if(victim)
		UnregisterSignal(victim, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)
	*/
	return ..()

/datum/wound/mechanical/blunt/handle_process()
	. = ..()
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	if(!regen_points_needed)
		return

	regen_points_current++
	if(prob(severity * 2))
		victim.take_bodypart_damage(rand(2, severity * 2), stamina=rand(2, severity * 2.5), wound_bonus=CANT_WOUND)
		if(prob(33))
			to_chat(victim, "<span class='danger'>You feel a sharp pain in your body as your metallic skeleton bends back into place!</span>")

	if(regen_points_current > regen_points_needed)
		if(!victim || !limb)
			qdel(src)
			return
		to_chat(victim, "<span class='green'>Your [limb.name] has recovered from the bending!</span>")
		remove_wound()

/// If we're a synth who's punching something with a broken arm, we might hurt ourselves doing so
/datum/wound/mechanical/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	if(victim.get_active_hand() != limb || victim.a_intent == INTENT_HELP || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return

	// With a severe or critical wound, you have a 15% or 30% chance to proc pain on hit
	if(prob((severity - 1) * 15))
		// And you have a 70% or 50% chance to actually land the blow, respectively
		if(prob(70 - 20 * (severity - 1)))
			to_chat(victim, "<span class='userdanger'>Your [limb.name] malfunctions as you strike [target]!</span>")
			limb.receive_damage(brute=rand(1,5))
		else
			victim.visible_message("<span class='danger'>[victim] weakly strikes [target] with [victim.p_their()] bent [limb.name]!</span>", \
			"<span class='userdanger'>You fail to strike [target] as the frictioning metal in your [limb.name] causes it to spark!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
			victim.Stun(0.5 SECONDS)
			limb.receive_damage(brute=rand(3,7))
			return COMPONENT_NO_ATTACK_HAND

/datum/wound/mechanical/blunt/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim)
		return

	var/modifier = 1
	if(wounding_type == WOUND_LIST_BLUNT_MECHANICAL)
		modifier = 1.4
	else if(wounding_type == WOUND_LIST_PIERCE_MECHANICAL)
		modifier = 1.2
	else if(wounding_type == WOUND_LIST_SLASH_MECHANICAL)
		modifier = 0.8
	else if(wounding_type == WOUND_LIST_BURN_MECHANICAL)
		modifier = 0.5
	if((wounding_dmg * modifier >= 12/(severity - WOUND_SEVERITY_TRIVIAL)) && prob(wounding_dmg/2 * modifier))
		if(limb.body_zone == BODY_ZONE_CHEST && prob(shock_chance + (wounding_dmg * 2)))
			var/stun_amt = rand(10, wounding_dmg/10 * (severity == WOUND_SEVERITY_CRITICAL ? 20 : 15))
			if(stun_amt)
				victim.visible_message("<span class='smalldanger'>[victim] gets stunned as [victim.p_their()] [limb.name] sparks!</span>", "<span class='danger'>You get stunned by the impact on your damaged [limb.name] internals!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.Paralyze(stun_amt)
				do_sparks(clamp(round(stun_amt/10, 1), 1, 6), GLOB.alldirs, victim)
		
		else if(limb.body_zone == BODY_ZONE_PRECISE_GROIN && prob(shock_chance + (wounding_dmg * 2)))
			var/stun_amt = rand(10, wounding_dmg/10 * (severity == WOUND_SEVERITY_CRITICAL ? 20 : 15))
			if(stun_amt)
				victim.visible_message("<span class='smalldanger'>[victim] gets knocked down as [victim.p_their()] [limb.name] sparks!</span>", "<span class='danger'>You get knocked down by the impact on your damaged [limb.name] internals!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.DefaultCombatKnockdown(stun_amt)
				do_sparks(clamp(round(stun_amt/10, 1), 1, 6), GLOB.alldirs, victim)

/datum/wound/mechanical/blunt/get_examine_description(mob/user)
	if(!limb.current_gauze && !wrenched && !taped)
		return ..()

	var/msg = ""
	if(!limb.current_gauze)
		msg = "[victim.p_their(TRUE)] [limb.name] [examine_desc]"
	else
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

	if(taped)
		msg += ", <span class='notice'>and the joints appear to be held together with sticky tape!</span>"
	else if(wrenched)
		msg += ", <span class='notice'>and it appears to be tightly secured to avoid further damage!</span>"
	else
		msg +=  "!"
	return "<B>[msg]</B>"

/*
	New common procs for /datum/wound/mechanical/blunt/
*/

/datum/wound/mechanical/blunt/proc/update_inefficiencies()
	if(limb.body_zone in list(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_GROIN))
		if(limb.current_gauze)
			limp_slowdown = initial(limp_slowdown) * limb.current_gauze.splint_factor
		else
			limp_slowdown = initial(limp_slowdown)
		if(limb.body_zone == BODY_ZONE_PRECISE_GROIN)
			limp_slowdown *= 2
		victim.apply_status_effect(STATUS_EFFECT_LIMP)
	else if(limb.body_zone in list(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM))
		if(limb.current_gauze)
			interaction_efficiency_penalty = 1 + ((interaction_efficiency_penalty - 1) * limb.current_gauze.splint_factor)
		else
			interaction_efficiency_penalty = interaction_efficiency_penalty
	else if(limb.body_zone == BODY_ZONE_HEAD)
		victim.adjust_blurriness(30)
		if(prob(20))
			victim.emote("scream")

	if(initial(disabling))
		disabling = !limb.current_gauze

	limb.update_wounds()

/*
	Moderate (Joint Desynchronization)
*/

/datum/wound/mechanical/blunt/moderate
	name = "Joint Desynchronization"
	desc = "Parts of the patient's actuators have forcefully disconnected from each other, causing delayed and inefficient limb movement."
	treat_text = "Recommended wrenching of the affected limb, though manual synchronization by applying an aggressive grab to the patient and helpfully interacting with afflicted limb may suffice."
	examine_desc = "has visibly disconnected rotors"
	occur_text = "snaps and becomes unseated"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = ALL_BODYPARTS
	interaction_efficiency_penalty = 1.5
	limp_slowdown = 3
	threshold_minimum = 35
	threshold_penalty = 15
	treatable_tool = TOOL_WRENCH
	status_effect_type = /datum/status_effect/wound/blunt/moderate
	scarring_descriptions = list("light discoloring", "a slight blue tint")
	associated_alerts = list()

/datum/wound/mechanical/blunt/moderate/crush()
	if(prob(33))
		victim.visible_message("<span class='danger'>[victim]'s unsynchronized [limb.name] actuators snaps back into place!</span>", "<span class='userdanger'>Your unsynchronized [limb.name] actuators snaps back into place!</span>")
		remove_wound()

/datum/wound/mechanical/blunt/moderate/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone || user.a_intent == INTENT_GRAB)
		return FALSE

	if(user.grab_state == GRAB_PASSIVE)
		to_chat(user, "<span class='warning'>You must have [victim] in an aggressive grab to manipulate [victim.p_their()] [lowertext(name)]!</span>")
		return TRUE

	if(user.grab_state >= GRAB_AGGRESSIVE)
		user.visible_message("<span class='danger'>[user] begins forcing [victim]'s disconnected [limb.name] actuators!</span>", "<span class='notice'>You begin forcing [victim]'s disconnected [limb.name]'s actuators...</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] begins forcing your [limb.name]'s actuators!</span>")
		if(user.a_intent == INTENT_HELP)
			chiropractice(user)
		else
			malpractice(user)
		return TRUE

/// If someone is snapping our servos into place by hand with an aggro grab and help intent
/datum/wound/mechanical/blunt/moderate/proc/chiropractice(mob/living/carbon/human/user)
	var/time = base_treat_time
	var/time_mod = 1
	var/prob_mod = 10
	if(time_mod)
		time *= time_mod

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	if(prob(65 + prob_mod))
		user.visible_message("<span class='danger'>[user] forcefully connects [victim]'s disconnected [limb.name] actuators!</span>", "<span class='notice'>You forcefully connect [victim]'s disconnected [limb.name] actuators!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] snaps your desynchronized [limb.name] actuators back into place!</span>")
		victim.emote("scream")
		limb.receive_damage(brute=20, wound_bonus=CANT_WOUND)
		qdel(src)
	else
		user.visible_message("<span class='danger'>[user] torques and grinds [victim]'s disconnected [limb.name] actuators!</span>", "<span class='danger'>You torque and grind [victim]'s disconnected [limb.name] actuators!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] torques and grings your [limb.name]'s disconnected actuators!</span>")
		limb.receive_damage(brute=10, wound_bonus=CANT_WOUND)
		chiropractice(user)

/// If someone is snapping our dislocated joint into a fracture by hand with an aggro grab and harm or disarm intent
/datum/wound/mechanical/blunt/moderate/proc/malpractice(mob/living/carbon/human/user)
	var/time = base_treat_time
	var/time_mod = 1
	var/prob_mod = 10
	if(time_mod)
		time *= time_mod
	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	if(prob(65 + prob_mod))
		user.visible_message("<span class='danger'>[user] torques [victim]'s disconnected [limb.name] actuators with a loud pop!</span>", "<span class='danger'>You torque [victim]'s disconnected [limb.name] actuators with a loud pop!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] snaps your dislocated [limb.name] with a sickening crack!</span>")
		victim.emote("scream")
		limb.receive_damage(brute=25, wound_bonus=30 + prob_mod * 3)
	else
		user.visible_message("<span class='danger'>[user] grinds [victim]'s disconnected [limb.name] actuators around!</span>", "<span class='danger'>You grind [victim]'s disconnected [limb.name] actuators around painfully!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] grinds your dislocated [limb.name] actuators around!</span>")
		limb.receive_damage(brute=10, wound_bonus=CANT_WOUND)
		malpractice(user)


/datum/wound/mechanical/blunt/moderate/treat(obj/item/I, mob/user)
	if(victim == user)
		victim.visible_message("<span class='danger'>[user] begins resetting [victim.p_their()] [limb.name] with [I].</span>", "<span class='warning'>You begin resetting your [limb.name] with [I]...</span>")
	else
		user.visible_message("<span class='danger'>[user] begins resetting [victim]'s [limb.name] with [I].</span>", "<span class='notice'>You begin resetting [victim]'s [limb.name] with [I]...</span>")

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return

	if(victim == user)
		limb.receive_damage(brute=15, wound_bonus=CANT_WOUND)
		victim.visible_message("<span class='danger'>[user] finishes resetting [victim.p_their()] [limb.name]!</span>", "<span class='userdanger'>You reset your [limb.name]!</span>")
	else
		limb.receive_damage(brute=10, wound_bonus=CANT_WOUND)
		user.visible_message("<span class='danger'>[user] finishes resetting [victim]'s [limb.name]!</span>", "<span class='nicegreen'>You finish resetting [victim]'s [limb.name]!</span>", victim)
		to_chat(victim, "<span class='userdanger'>[user] resets your [limb.name]!</span>")

	victim.emote("scream")
	qdel(src)

/*
	Severe (Malfunctioning Actuators)
*/

/datum/wound/mechanical/blunt/severe
	name = "Malfunctioning Actuators"
	desc = "Patient's actuators are malfunctioning, causing reduced limb functionality and performance."
	treat_text = "Recommended internal repair of the limb, though sticky tape will prevent a worsening situation."
	examine_desc = "has loose and disconnected bits of metal"

	occur_text = "loudly hums as some loose nuts and bolts fall out"

	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	threshold_minimum = 60
	threshold_penalty = 30
	status_effect_type = /datum/status_effect/wound/blunt/severe
	treat_priority = TRUE
	treatable_by = list(/obj/item/stack/sticky_tape, /obj/item/reagent_containers)
	scarring_descriptions = list("a faded, fist-sized bruise", "a vaguely triangular peel scar")
	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES
	shock_chance = 30

/datum/wound/mechanical/blunt/critical
	name = "Broken Actuators"
	desc = "Patient's actuators have suffered severe dents and component losses, causing a severe decrease in limb functionality and performance."
	treat_text = "Complete internal component repair and replacement."
	examine_desc = "is damaged at several spots, with protuding bits of metal"
	occur_text = "loudly hums as it's rotors scrapes away bits of metal"
	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 4
	limp_slowdown = 9
	sound_effect = 'sound/effects/clang2.ogg'
	threshold_minimum = 115
	threshold_penalty = 50
	disabling = TRUE
	status_effect_type = /datum/status_effect/wound/blunt/critical
	treat_priority = TRUE
	treatable_by = list(/obj/item/stack/sticky_tape, /obj/item/reagent_containers)
	scarring_descriptions = list("a section of janky skin lines and badly healed scars", "a large patch of uneven skin tone", "a cluster of calluses")
	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES
	shock_chance = 45

/// if someone is using a reagent container
/datum/wound/mechanical/blunt/proc/wrench(obj/item/I, mob/user)
	if(wrenched)
		to_chat(user, "<span class='warning'>[user == victim ? "Your" : "[victim]'s"] [limb.name] is already secured in place!</span>")
		return

	user.visible_message("<span class='danger'>[user] begins fastening [limb.name]...</span>", "<span class='warning'>You begin fastening [user == victim ? "your" : "[victim]'s"] [limb.name]...</span>")

	if(!do_after(user, base_treat_time * 1.5 * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return
	
	if(user != victim)
		user.visible_message("<span class='notice'>[user] finishes fastening [victim]'s [limb.name], emitting a cranking noise!</span>", "<span class='notice'>You finish fastening [victim]'s [limb.name]!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='userdanger'>[user] finishes fastening your [limb.name]!</span>")
	else
		var/painkiller_bonus = 0
		if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/determination))
			painkiller_bonus += 5
		
		victim.visible_message("<span class='notice'>[victim] finishes fastening [victim.p_their()] [limb.name]!</span>", "<span class='notice'>You fastening your [limb.name]!</span>")

	limb.receive_damage(30, stamina=100, wound_bonus=CANT_WOUND)
	if(!wrenched)
		wrenched = TRUE

/// if someone is using sticky tape on our wound
/datum/wound/mechanical/blunt/tape(obj/item/stack/sticky_tape/I, mob/user)
	if(!wrenched)
		to_chat(user, "<span class='warning'>[user == victim ? "Your" : "[victim]'s"] [limb.name] must be secured to perform this emergency protocol!</span>")
		return
	
	if(taped)
		to_chat(user, "<span class='warning'>[user == victim ? "Your" : "[victim]'s"] [limb.name] is already wrapped in [I.name] and reforming!</span>")
		return

	user.visible_message("<span class='danger'>[user] begins applying [I] to [victim]'s' [limb.name]...</span>", "<span class='warning'>You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]...</span>")

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, .proc/still_exists)))
		return

	regen_points_current = 0
	regen_points_needed = 30 SECONDS * (user == victim ? 1.5 : 1) * (severity - 1)
	I.use(1)
	if(user != victim)
		user.visible_message("<span class='notice'>[user] finishes applying [I] to [victim]'s [limb.name]!</span>", "<span class='notice'>You finish applying [I] to [victim]'s [limb.name]!</span>", ignored_mobs=victim)
		to_chat(victim, "<span class='green'>[user] finishes applying [I] to your [limb.name], you can feel the repair processes booting up!</span>")
	else
		victim.visible_message("<span class='notice'>[victim] finishes applying [I] to [victim.p_their()] [limb.name]!</span>", "<span class='green'>You finish applying [I] to your [limb.name], and you immediately begin to feel the repair process boot up!</span>")

	taped = TRUE
	processes = TRUE

/datum/wound/mechanical/blunt/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/wrench))
		wrench(I, user)
	else if(istype(I, /obj/item/stack/sticky_tape) && user.a_intent != INTENT_HARM)
		tape(I, user)

/datum/wound/mechanical/blunt/get_scanner_description(mob/user)
	. = ..()

	. += "<div class='ml-3'>"

	if(severity >= WOUND_SEVERITY_SEVERE)
		if(!wrenched)
			. += "Alternative Treatment: Secure the injured limb with a wrench, then sticky tape to begin automatic repair. This is very ineffective and may damage internal components, and as such only recommended in dire need.</span>\n"
		else if(!taped)
			. += "<span class='notice'>Continue Alternative Treatment: Apply sticky tape directly to injured limb to begin automatic. This is very ineffective and may damage internal components, and as such only recommended in dire need.</span>\n"
		else
			. += "<span class='notice'>Note: Automatic repair in effect. Background tasks are [round(regen_points_current/regen_points_needed)]% operational.</span>\n"

	if(limb.body_zone == BODY_ZONE_HEAD)
		. += "Head Trauma Detected: Patient will suffer random bouts of [severity == WOUND_SEVERITY_SEVERE ? "mild" : "severe"] runtimes until damage is repaired."
	else if(limb.body_zone == BODY_ZONE_CHEST)
		. += "Chest Trauma Detected: Further trauma to chest is likely to stun or paralyze the victim momentarily."
	else if(limb.body_zone == BODY_ZONE_PRECISE_GROIN)
		. += "Groin Trauma Detected: Further trauma to groin is likely to knock them down momentarily."
	. += "</div>"
