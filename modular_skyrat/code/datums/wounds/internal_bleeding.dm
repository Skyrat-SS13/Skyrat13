//skyrat edit obviously
/*
	Internal bleeding
*/

/datum/wound/internalbleed
	sound_effect = 'modular_skyrat/sound/effects/flesh.ogg'
	processes = TRUE
	wound_type = WOUND_LIST_INTERNAL_BLEEDING
	treatable_by = list(/obj/item/stack/medical/fixovein,
						/obj/item/reagent_containers)
	treatable_tool = TOOL_CAUTERY
	treatable_sharp = TRUE
	///Any sharp item can cut the limb open, and then we apply fix o' vein or fibrin
	accepts_gauze = TRUE

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// When processed, we have this chance to damage internal organs on the associated bodypart
	/// (Pretty much to represent hypoxemia)
	var/organ_damage_chance
	/// The minimum and maximum damage we can roll for an organ
	var/organ_damage_min
	var/organ_damage_max
	/// Fix o' vein and fibrin start a mild regeneration process on the arteries, once the incision is closed
	var/regeneration = 0
	/// Chance to puke blood if it's on the chest or groin
	var/puke_chance = 0
	/// Amount of blood expelled on puking
	var/puke_severity = 0
	/// Chance to go unconscious (have a stroke) if it's on the head
	var/unconscious_chance = 0
	/// Duration of the stroke
	var/unconscious_duration = 10 SECONDS

	base_treat_time = 6 SECONDS
	biology_required = list(HAS_FLESH)
	required_status = BODYPART_ORGANIC
	can_self_treat = TRUE //We can grab ourselves to slow bleeding down, but we can't treat it most of the time

/datum/wound/internalbleed/self_treat(mob/living/carbon/user, first_time = FALSE)
	. = ..()
	if(.)
		return TRUE
	
	if(victim && limb?.body_zone)
		var/obj/screen/zone_sel/sel = victim.hud_used?.zone_select
		if(istype(sel))
			sel.set_selected_zone(limb?.body_zone)
			victim.grabbedby(victim)
		return

/datum/wound/internalbleed/wound_injury(datum/wound/old_wound)
	blood_flow = initial_flow

/datum/wound/internalbleed/handle_process()
	blood_flow = min(blood_flow, WOUND_INTERNAL_MAX_BLOODFLOW)

	var/organ_damage_roll_chance = organ_damage_chance
	var/organ_damage_roll_min = organ_damage_min
	var/organ_damage_roll_max = organ_damage_max
	if(victim?.reagents?.has_reagent(/datum/reagent/toxin/heparin))
		blood_flow += 0.5 // heparin causes you to lose even more blood, and increases organ damage chance
		organ_damage_roll_chance *= 2
	else if(victim?.reagents?.has_reagent(/datum/reagent/medicine/coagulant) || victim?.reagents?.has_reagent(/datum/reagent/medicine/fibrin))
		blood_flow -= 0.25 // does the inverse of heparin, less effectively
		organ_damage_roll_chance *= 0.7
	
	if(blood_flow <= 0)
		qdel(src)
	
	if(regeneration)
		blood_flow -= regeneration
	
	//No need to fuck up the victim if they are already dead
	if(victim.stat != DEAD)
		//RNGesus giveth, but also taketh
		if(prob(organ_damage_roll_chance))
			for(var/obj/item/organ/O in victim?.internal_organs)
				if(O.zone == limb?.body_zone)
					O.applyOrganDamage(rand(organ_damage_roll_min, organ_damage_roll_max))
		
		if(limb?.body_zone in list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN) && prob(puke_chance))
			to_chat(victim, "<span class='danger'>You violently expel some blood!</span>")
			victim?.vomit(3, puke_severity, 10)
		else if(limb?.body_zone == BODY_ZONE_HEAD && prob(unconscious_chance))
			to_chat(victim, "<span class='danger'>You feel weak...</span>")
			victim?.Unconscious(unconscious_duration)
			//Having a stroke always causes brain damage.
			victim?.apply_damage(10, BRAIN)

/datum/wound/internalbleed/treat(obj/item/I, mob/user)
	if(I.sharpness)
		cut_open(I, user)
	else if(istype(I, /obj/item/stack/medical/fixovein))
		fixovein(I, user)
	else if(istype(I, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/R = I
		if(R.reagents?.reagent_list?.Find(/datum/reagent/medicine/fibrin))
			fibrin(R, user)

/datum/wound/internalbleed/on_xadone(power)
	. = ..()
	blood_flow -= 0.01 * power // not too bad considering this is harder to cure than piercing

/// If someone is cutting the affected limb open
/datum/wound/internalbleed/proc/cut_open(obj/item/I, mob/user)
	var/self_penalty_mult = (user == victim ? 2 : 1)
	if(locate(/datum/wound/slash/critical/incision) in limb?.wounds)
		to_chat(user, "<span class='danger'>[user == victim ? "Your " : ""][user == victim ? limb.name : capitalize(limb.name)] is already cut open!</span>")
		return
	user.visible_message("<span class='danger'>[user] begins cutting [victim]'s [limb.name] open with [I]!</span>", "<span class='danger'>You begin cutting [user == victim ? "your" : "[victim]'s"] [limb.name] open with [I]!</span>")
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	
	user.visible_message("<span class='danger'>[user] slices [victim]'s [limb] wide open!</span>", "<span class='danger'>You slice [user == victim ? "your" : "[victim]'s"] [limb.name] wide open!</span>")
	var/datum/wound/slash/critical/incision/inch = new() //cutting the limb open makes the situation a bit worse as you have to fix the incision, so don't do it unless you have supplies to fix it
	inch.apply_wound(limb, TRUE)
	limb.receive_damage(5)

/// If someone is using applying fix o' vein after cutting the limb open
/datum/wound/internalbleed/proc/fixovein(obj/item/stack/I, mob/user)
	if(!(locate(/datum/wound/slash/critical/incision) in limb?.wounds))
		to_chat(user, "<span class='danger'>[user == victim ? "Your " : ""][user == victim ? limb.name : capitalize(limb.name)] needs to be cut open to apply [I]!</span>")
		return
	var/self_penalty_mult = (user == victim ? 2 : 1)
	user.visible_message("<span class='danger'>[user] begins painfully applying \the [I] on [victim]'s incised [limb.name]...</span>", "<span class='danger'>You begin painfully applying \the [I] on [user == victim ? "your" : "[victim]'s"] incised [limb.name]...</span>")
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	if(!I.use(1))
		to_chat(user, "<span class='warning'>There aren't enough stacks of [I.name] to heal \the [src.name]!</span>")
		return

	if((user == victim) && prob(40) && !HAS_TRAIT(user, TRAIT_PAINKILLER))
		var/painkiller_bonus = 0
		if(victim.drunkenness)
			painkiller_bonus += 5
		if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/medicine/morphine))
			painkiller_bonus += 10
		if(victim.reagents && victim.reagents.has_reagent(/datum/reagent/determination))
			painkiller_bonus += 5

		if(prob(25 + (20 * severity - 2) - painkiller_bonus)) // 25%/45% chance to fail self-applying with severe and critical wounds, modded by painkillers
			victim.visible_message("<span class='danger'>[victim] fails to finish applying [I] to [victim.p_their()] [limb.name], passing out from the pain!</span>", "<span class='notice'>You black out from the pain of applying [I] to your [limb.name] before you can finish!</span>")
			victim.AdjustUnconscious(5 SECONDS)
			return
		victim.visible_message("<span class='notice'>[victim] finishes applying [I] to [victim.p_their()] [limb.name], grimacing from the pain!</span>", "<span class='notice'>You finish applying [I] to your [limb.name], and your bones explode in pain!</span>")

	user.visible_message("<span class='green'>[user] repairs some torn [pick("veins", "arteries")] on [victim]'s [limb.name].</span>", "<span class='green'>You repair some of the torn [pick("veins", "arteries")] on [victim == user ? "your" : "[victim]'s"] [limb.name].</span>")
	limb.receive_damage(brute = severity, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/bloodflow_stopped = (1.2 / max(1, self_penalty_mult))
	blood_flow -= bloodflow_stopped

	regeneration += (bloodflow_stopped/4) //we reduce the bloodflow by this on each process

	if(blood_flow > 0)
		try_treating(I, user)

/// If someone is applying fibrin after cutting the limb open
/datum/wound/internalbleed/proc/fibrin(obj/item/reagent_containers/I, mob/user)
	var/self_penalty_mult = (user == victim ? 2 : 1)
	user.visible_message("<span class='danger'>[user] begins applying fibrin on [victim]'s incised [limb.name]...</span>", "<span class='danger'>You begin applying fibrin on [user == victim ? "your" : "[victim]'s"] incised [limb.name]...</span>")
	var/time_mod = 1
	if(!do_after(user, base_treat_time * time_mod * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	if(!I.reagents.remove_reagent(/datum/reagent/medicine/fibrin, 10, ignore_pH = TRUE))
		to_chat(user, "<span class='warning'>There isn't enough fibrin in \the [I] to heal \the [src.name]!</span>")
		return

	user.visible_message("<span class='green'>[user] sprays some fibrin on [victim]'s torn [limb.name] [pick("veins", "arteries")].</span>", "<span class='green'>You spray some fibrin on [victim == user ? "your" : "[victim]'s"] torn [limb.name] [pick("veins", "arteries")].</span>")
	limb.heal_damage(3)
	if(prob(30))
		victim.emote("scream")
	var/bloodflow_stopped = (1.2 / max(1, self_penalty_mult))
	blood_flow -= bloodflow_stopped

	regeneration += (bloodflow_stopped/4) //we reduce the bloodflow by this on each process

	if(blood_flow > 0)
		try_treating(I, user)

/datum/wound/internalbleed/get_scanner_description(mob/user)
	. = ..()
	if(regeneration)
		. += "<div class='ml-3'>"
		. += "<span class='notice'>Note: Clotting of the affected blood vessels is in effect. Vessels are [100 - (100 * (initial_flow - blood_flow))]% repaired.</span>"
		. += "</div>"

//PS: Internal bleeding has no scars for obvious reasons.
/datum/wound/internalbleed/moderate
	name = "Minor Haematoma"
	desc = "Some of the patient's blood vessels have burst, and blood has started to pool on the affected region, causing minor hypoxemia and organ damage."
	treat_text = "Treat affected site by incising the limb and repairing damaged blood vessels with fix o' vein or fibrin."
	occur_text = "slowly starts to pool blood under it's skin"
	examine_desc = "looks unnaturally pale"
	sound_effect = 'modular_skyrat/sound/effects/blood1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = ALL_BODYPARTS
	initial_flow = 1
	organ_damage_chance = 4
	organ_damage_min = 1
	organ_damage_max = 5
	puke_chance = 0
	puke_severity = 0
	unconscious_chance = 0
	unconscious_duration = 0
	threshold_minimum = 35
	threshold_penalty = 15

/datum/wound/internalbleed/severe
	name = "Ruptured Arteries"
	desc = "Patient's blood vessels have been torn at several spots, causing severe organ damage and pooling of blood."
	treat_text = "Treat affected site by incising the limb and repairing damaged blood vessels with fix o' vein or fibrin."
	occur_text = "quickly develops deep purple bruises"
	examine_desc = "has several large, purple-colored spots"
	sound_effect = 'modular_skyrat/sound/effects/blood2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	viable_zones = ALL_BODYPARTS
	initial_flow = 1.5
	organ_damage_chance = 7
	organ_damage_min = 3
	organ_damage_max = 7
	puke_chance = 5
	puke_severity = 5
	unconscious_chance = 2
	unconscious_duration = 25
	threshold_minimum = 60
	threshold_penalty = 30

/datum/wound/internalbleed/critical
	name = "Hypovolemic Shock"
	desc = "Patient's arteries have been shredded and bursted at several spots, causing severe hypoxia on the affected limb and it's organs."
	treat_text = "Surgical repair of the damaged blood vessels and vaccuuming of the lost blood, followed by supervised resanguination."
	occur_text = "swells up in size, acquiring a deep blue color"
	examine_desc = "looks swollen, colored in a sickly blue hue"
	sound_effect = 'modular_skyrat/sound/effects/blood3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	viable_zones = ALL_BODYPARTS
	treatable_by = list()
	treatable_tool = null
	treatable_sharp = FALSE
	initial_flow = 2
	organ_damage_chance = 10
	organ_damage_min = 5
	organ_damage_max = 10
	puke_chance = 8
	puke_severity = 10
	unconscious_chance = 4
	unconscious_duration = 50
	threshold_minimum = 115
	threshold_penalty = 50
