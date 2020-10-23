//this file is a skyrat edit
/*
	Wounds are specific medical complications that can arise and be applied to (currently) carbons, with a focus on humans. All of the code for and related to this is heavily WIP,
	and the documentation will be slanted towards explaining what each part/piece is leading up to, until such a time as I finish the core implementations. The original design doc
	can be found at https://hackmd.io/@Ryll/r1lb4SOwU

	Wounds are datums that operate like a mix of diseases, brain traumas, and components, and are applied to a /obj/item/bodypart (preferably attached to a carbon) when they take large spikes of damage
	or under other certain conditions (thrown hard against a wall, sustained exposure to plasma fire, etc). Wounds are categorized by the three following criteria:
		1. Severity: Either MODERATE, SEVERE, or CRITICAL. See the hackmd for more details
		2. Viable zones: What body parts the wound is applicable to. Generic wounds like broken bones and severe burns can apply to every zone, but you may want to add special wounds for certain limbs
			like a twisted ankle for legs only, or open air exposure of the organs for particularly gruesome chest wounds. Wounds should be able to function for every zone they are marked viable for.
		3. Damage type: Currently either BRUTE or BURN. Again, see the hackmd for a breakdown of my plans for each type.

	When a body part suffers enough damage to get a wound, the severity (determined by a roll or something, worse damage leading to worse wounds), affected limb, and damage type sustained are factored into
	deciding what specific wound will be applied. I'd like to have a few different types of wounds for at least some of the choices, but I'm just doing rough generals for now. Expect polishing
*/

/datum/wound
	/// What it's named
	var/name = "ouchie"
	/// The description shown on the scanners
	var/desc = ""
	/// The basic treatment suggested by health analyzers
	var/treat_text = ""
	/// What the limb looks like on a cursory examine
	var/examine_desc = "is badly hurt"

	/// needed for "your arm has a compound fracture" vs "your arm has some third degree burns"
	var/a_or_from = "a"
	/// The visible message when this happens
	var/occur_text = ""
	/// This sound will be played upon the wound being applied
	var/sound_effect

	/// See the defines to get a full list of severities.
	var/severity = WOUND_SEVERITY_MODERATE
	/// The list of wounds it belongs in, WOUND_LIST_BLUNT, WOUND_LIST_SLASH, or WOUND_LIST_BURN
	var/wound_type

	/// What bodyparts can we affect
	var/list/viable_zones = ALL_BODYPARTS
	/// Who owns the body part that we're wounding
	var/mob/living/carbon/victim = null
	/// What species traits we need in order to be applicable (HAS_SKIN, HAS_FLESH and HAS_BONE) ((monkeys and carbons are assumed to have all))
	var/biology_required = list(HAS_SKIN, HAS_FLESH, HAS_BONE)
	/// What kind of limb statuses we can apply on
	var/required_status = BODYPART_ORGANIC
	/// The bodypart we're parented to
	var/obj/item/bodypart/limb = null
	/// A string, used to represent a limb that we're not attached to but want the examine text to tell us we are
	/// Used for dismemberment wounds, where applying the wound to the lost limb isn't possible, so we
	/// attach the wound to the parent body zone instead
	var/fake_limb = null
	/// The body zone of the phantom limb
	var/fake_body_zone = null
	/// Wound flags, mostly used to handle mangling
	var/wound_flags = 0

	/// Specific items such as bandages or sutures that can try directly treating this wound
	var/list/treatable_by
	/// Specific items such as bandages or sutures that can try directly treating this wound only if the user has the victim in an aggressive grab or higher
	var/list/treatable_by_grabbed
	/// Tools with the specified tool flag will also be able to try directly treating this wound
	var/treatable_tool
	/// Set to TRUE if we don't give a shit about the patient's comfort and are allowed to just use any random sharp thing on this wound. Will require an aggressive grab or more to perform
	var/treatable_sharp
	/// Can we use a bandage/gauze on this wound in some kind of way?
	var/accepts_gauze = TRUE
	/// How long it will take to treat this wound with a standard effective tool, assuming it doesn't need surgery
	var/base_treat_time = 5 SECONDS

	/// Using this limb in a do_after interaction will multiply the length by this duration (arms)
	var/interaction_efficiency_penalty = 1
	/// Incoming damage on this limb will be multiplied by this, to simulate tenderness and vulnerability (mostly burns).
	var/damage_multiplier_penalty = 1
	/// If set and this wound is applied to a leg, we take this many deciseconds extra per step on this leg
	var/limp_slowdown
	/// How much we're contributing to this limb's bleed_rate
	var/blood_flow

	/// List of alerts we can throw, of category associated with type
	var/list/associated_alerts = list()

	/// The minimum we need to roll on [/obj/item/bodypart/proc/check_wounding()] to begin suffering this wound, see check_wounding_mods() for more
	var/threshold_minimum
	/// How much having this wound will add to all future check_wounding() rolls on this limb, to allow progression to worse injuries with repeated damage
	var/threshold_penalty
	/// If we need to process each life tick
	/// By default, all wounds have to process infections
	var/processes = TRUE

	/// If TRUE and an item that can treat multiple different types of coexisting wounds (gauze can be used to splint broken bones, staunch bleeding, and cover burns), we get first dibs if we come up first for it, then become nonpriority.
	/// Otherwise, if no untreated wound claims the item, we cycle through the non priority wounds and pick a random one who can use that item.
	var/treat_priority = FALSE

	/// Should we just ignore pre-existing wounds and apply anyways?
	var/ignore_preexisting = FALSE

	/// If having this wound makes currently makes the parent bodypart unusable
	var/disabling

	/// How much this wound reduces organ_damage_threshold in /obj/item/bodypart/damage_organs() (organ_threshold_reduction * organ_damage_hit_minimum)
	var/organ_threshold_reduction = 0.1
	/// How much this wound reduces organ_damage_required in /obj/item/bodypart/damage_organs() (organ_required_reduction* organ_damage_requirement)
	var/organ_required_reduction = 0.1
	/// How much pain this wound causes
	var/pain_amount = 5
	/// How much this wound increases the damage on organ damage rolls, multiplier
	var/damage_roll_increase = 0.1
	/// How much this wound increases the damage on organ damage rolls, flat
	var/flat_damage_roll_increase = 2.5

	/// What status effect we assign on application
	var/status_effect_type
	/// The status effect we're linked to
	var/datum/status_effect/linked_status_effect
	/// If we're operating on this wound and it gets healed, we'll nix the surgery too
	var/datum/surgery/attached_surgery
	/// if you're a lazy git and just throw them in cryo, the wound will go away after accumulating severity * 25 power
	var/cryo_progress

	/// What kind of scars this wound will create description wise once healed
	var/list/scarring_descriptions = list("general disfigurement")
	/// If we've already tried scarring while removing (since remove_wound calls qdel, and qdel calls remove wound, .....) TODO: make this cleaner
	var/already_scarred = FALSE
	/// If we forced this wound through badmin smite, we won't count it towards the round totals
	var/from_smite
	/// Can we do a far cry and treat this wound just by clicking some text on the check self stuff?
	var/can_self_treat = FALSE

	/// Chance of this wound getting infected
	var/infection_chance = 0
	/// How many germs we add once we pass the infection check
	var/infection_rate = 1
	/// Germ level of the wound
	var/germ_level = 0
	/// Our current level of sanitization/anti-infection, from disinfectants/alcohol/UV lights. While positive, totally pauses and slowly reverses germ_level effects each tick
	var/sanitization = 0
	/// Once we reach germ_level beyond WOUND_germ_level_SEPSIS, we get this many warnings before the limb is completely paralyzed (you'd have to ignore a really bad burn for a really long time for this to happen)
	var/strikes_to_lose_limb = 3
	/// Should we display a sound hint on being acquired?
	var/do_sound_hint = TRUE
	/// What we add to the carbon mob's descriptive wound string once acquired
	var/descriptive = ""

/datum/wound/Topic(href, href_list)
	if(!victim)
		return
	if(usr.canUseTopic(victim, BE_CLOSE, FALSE))
		if(href_list["self_treat"])
			if(INTERACTING_WITH(usr, victim))
				to_chat(usr, "<span class='warning'>You're already interacting with [victim]!</span>")
				return FALSE
			self_treat(usr, TRUE)

/datum/wound/proc/self_treat(mob/living/carbon/user, first_time = FALSE) //used so you can far cry up wounds to fix them
	return FALSE

/datum/wound/Destroy()
	if(attached_surgery)
		QDEL_NULL(attached_surgery)
	if(src in victim?.all_wounds)
		victim.all_wounds -= src
	if(limb?.wounds && (src in limb.wounds)) // destroy can call remove_wound() and remove_wound() calls qdel, so we check to make sure there's anything to remove first
		remove_wound()
	limb = null
	victim = null
	return ..()

/datum/wound/proc/wound_alert(clear = FALSE)
	if(HAS_TRAIT(src, TRAIT_SCREWY_CHECKSELF) && !clear)
		return FALSE
	. = TRUE
	if(!clear)
		if(victim)
			for(var/i in associated_alerts)
				victim.throw_alert(i, associated_alerts[i])
	else
		if(victim)
			for(var/i in associated_alerts)
				victim.clear_alert(i)

/**
  * apply_wound() is used once a wound type is instantiated to assign it to a bodypart, and actually come into play.
  *
  *
  * Arguments:
  * * L: The bodypart we're wounding, we don't care about the person, we can get them through the limb
  * * silent: Not actually necessary I don't think, was originally used for demoting wounds so they wouldn't make new messages, but I believe old_wound took over that, I may remove this shortly
  * * old_wound: If our new wound is a replacement for one of the same time (promotion or demotion), we can reference the old one just before it's removed to copy over necessary vars
  * * smited- If this is a smite, we don't care about this wound for stat tracking purposes (not yet implemented)
  */
/datum/wound/proc/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE)
	if(!istype(L) || !L.owner || !(L.body_zone in viable_zones) || isalien(L.owner))
		qdel(src)
		return

	if(ishuman(L.owner))
		var/mob/living/carbon/human/H = L.owner

		if((required_status & BODYPART_ORGANIC) && !L.is_organic_limb())
			qdel(src)
			return
		else if((required_status & BODYPART_ROBOTIC) && !L.is_robotic_limb())
			qdel(src)
			return
		
		for(var/biology_flag in biology_required)
			if(!(biology_flag in H.dna.species.species_traits))
				qdel(src)
				return

	// we accept promotions and demotions, but no point in redundancy. This should have already been checked wherever the wound was rolled and applied for (see: bodypart damage code), but we do an extra check
	// in case we ever directly add wounds
	// only dismemberment and disembowelment wounds will ignore preexisting ones at the moment
	if(!ignore_preexisting)
		for(var/datum/wound/preexisting_wound in L.wounds)
			if((preexisting_wound.type == type) && (preexisting_wound != old_wound))
				qdel(src)
				return

	victim = L.owner
	limb = L
	LAZYADD(victim.all_wounds, src)
	LAZYADD(limb.wounds, src)
	limb.update_wounds()
	if(status_effect_type && victim)
		linked_status_effect = victim.apply_status_effect(status_effect_type, src)
	SEND_SIGNAL(victim, COMSIG_CARBON_GAIN_WOUND, src, limb)
	var/demoted
	if(old_wound)
		demoted = (severity <= old_wound.severity)

	if(severity == WOUND_SEVERITY_TRIVIAL)
		return
	
	//Send the bad mood event
	if(severity >= WOUND_SEVERITY_SEVERE)
		SEND_SIGNAL(victim, COMSIG_ADD_MOOD_EVENT, "wounded", /datum/mood_event/injured)

	if(!(silent || demoted))
		var/msg = "<span class='danger'>[victim]'s [limb.name] [occur_text]!</span>"
		var/vis_dist = COMBAT_MESSAGE_RANGE

		if(severity > WOUND_SEVERITY_MODERATE)
			msg = "<b>[msg]</b>"
			vis_dist = DEFAULT_MESSAGE_RANGE
		var/list/ignore =list()
		for(var/mob/Y in view(vis_dist, L.owner))
			if(Y != L.owner)
				if(Y.client?.prefs?.chat_toggles & CHAT_WOUNDS_OTHER)
					ignore |= Y
			else
				if(Y.client?.prefs?.chat_toggles & CHAT_WOUNDS_SELF)
					ignore |= Y
		victim.visible_message(msg, (L.owner?.client?.prefs?.chat_toggles & CHAT_WOUNDS_SELF ? null : "<span class='userdanger'>Your [limb.name] [occur_text]!</span>"), vision_distance = vis_dist, ignored_mobs = ignore)
		if(sound_effect)
			playsound(L.owner, sound_effect, 60 + 20 * severity, TRUE)
		if(do_sound_hint)
			sound_hint(L.owner, L.owner)

	if(!demoted)
		wound_injury(old_wound)
		second_wind()
	
	//Update the descriptive string for combat, if we were silent
	if(silent)
		victim.wound_message += " [descriptive]"

/// Remove the wound from whatever it's afflicting, and cleans up whateverstatus effects it had or modifiers it had on interaction times. ignore_limb is used for detachments where we only want to forget the victim
/datum/wound/proc/remove_wound(ignore_limb, replaced = FALSE, forced = FALSE)
	if(severity == WOUND_SEVERITY_PERMANENT && !forced)
		return FALSE
	//TODO: have better way to tell if we're getting removed without replacement (full heal) scar stuff
	if(limb && !already_scarred && !replaced)
		already_scarred = TRUE
		if(limb.is_organic_limb())
			if(CAN_SCAR in victim.dna?.species?.species_traits)
				var/datum/scar/new_scar = new
				new_scar.generate(limb, src)
	if(victim)
		LAZYREMOVE(victim.all_wounds, src)
		SEND_SIGNAL(victim, COMSIG_CARBON_LOSE_WOUND, src, limb)
	if(limb && !ignore_limb)
		LAZYREMOVE(limb.wounds, src)
		limb.update_wounds(replaced)

/**
  * replace_wound() is used when you want to replace the current wound with a new wound, presumably of the same category, just of a different severity (either up or down counts)
  *
  * This proc actually instantiates the new wound based off the specific type path passed, then returns the new instantiated wound datum.
  *
  * Arguments:
  * * new_type- The TYPE PATH of the wound you want to replace this, like /datum/wound/slash/severe
  * * smited- If this is a smite, we don't care about this wound for stat tracking purposes (not yet implemented)
  * * transfer_vars - Whether or not we should transfer our germ_level and sanitization
  */
/datum/wound/proc/replace_wound(new_type, smited = FALSE, transfer_vars = FALSE, silent = FALSE)
	var/datum/wound/new_wound = new new_type
	already_scarred = TRUE
	var/infected = germ_level
	var/disinfected = sanitization
	remove_wound(replaced=TRUE)
	new_wound.apply_wound(limb, old_wound = src, smited = smited, silent = silent)
	if(transfer_vars)
		new_wound.germ_level = infected
		new_wound.sanitization = disinfected
	qdel(src)
	return new_wound

/// The immediate negative effects faced as a result of the wound
/datum/wound/proc/wound_injury(datum/wound/old_wound = null)
	return

/// Additional beneficial effects when the wound is gained, in case you want to give a temporary boost to allow the victim to try an escape or last stand
/datum/wound/proc/second_wind()
	if(!victim)
		return
	if(HAS_TRAIT(victim, TRAIT_NODETERMINATION)) //toby is gone
		return
	//Kidneys regulate the production of adrenaline (determination)
	var/obj/item/organ/kidneys/kidneys = victim.getorganslot(ORGAN_SLOT_KIDNEYS)
	if(kidneys && kidneys.get_adrenaline_multiplier())
		switch(severity)	
			if(WOUND_SEVERITY_MODERATE)
				victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_MODERATE * kidneys.get_adrenaline_multiplier())
			if(WOUND_SEVERITY_SEVERE)
				victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_SEVERE * kidneys.get_adrenaline_multiplier())
			if(WOUND_SEVERITY_CRITICAL)
				victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_CRITICAL * kidneys.get_adrenaline_multiplier())
			if(WOUND_SEVERITY_LOSS)
				victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_LOSS * kidneys.get_adrenaline_multiplier())
			if(WOUND_SEVERITY_PERMANENT)
				victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_PERMANENT * kidneys.get_adrenaline_multiplier())

/**
  * try_treating() is an intercept run from [/mob/living/carbon/attackby()] right after surgeries but before anything else. Return TRUE here if the item is something that is relevant to treatment to take over the interaction.
  *
  * This proc leads into [/datum/wound/proc/treat()] and probably shouldn't be added onto in children types. You can specify what items or tools you want to be intercepted
  * with var/list/treatable_by and var/treatable_tool, then if an item fulfills one of those requirements and our wound claims it first, it goes over to treat() and treat_self().
  *
  * Arguments:
  * * I: The item we're trying to use
  * * user: The mob trying to use it on us
  */

/// Called when the patient is undergoing stasis, so that having fully treated a wound doesn't make you sit there helplessly until you think to unbuckle them
/datum/wound/proc/try_treating(obj/item/I, mob/user)
	// first we weed out if we're not dealing with our wound's bodypart, or if it might be an attack
	if(!victim || !I || limb.body_zone != user.zone_selected || (I.force && user.a_intent != INTENT_HELP))
		return FALSE

	var/allowed = FALSE

	// check if we have a valid treatable tool (or, if cauteries are allowed, if we have something hot)
	if((I.tool_behaviour == treatable_tool) || (treatable_tool == TOOL_CAUTERY && I.get_temperature()) || (treatable_sharp && I.sharpness))
		allowed = TRUE
	// failing that, see if we're aggro grabbing them and if we have an item that works for aggro grabs only
	else if(user.pulling == victim && user.grab_state >= GRAB_AGGRESSIVE && check_grab_treatments(I, user))
		allowed = TRUE
	// failing THAT, we check if we have a generally allowed item
	else
		for(var/allowed_type in treatable_by)
			if(istype(I, allowed_type))
				allowed = TRUE
				break

	// if none of those apply, we return false to avoid interrupting
	if(!allowed)
		return FALSE
	// now that we've determined we have a valid attempt at treating, we can stomp on their dreams if we're already interacting with the patient or if their part is obscured
	if(INTERACTING_WITH(user, victim))
		to_chat(user, "<span class='warning'>You're already interacting with [victim]!</span>")
		return TRUE

	if(!victim.can_inject(user, FALSE))
		to_chat(user, "<span class='warning'>\The [src.name] can't be treated if it is not exposed!</span>")
		return TRUE
	
	// lastly, treat them
	if(treat_infection(I, user))
		return
	treat(I, user)
	return TRUE

/// Return TRUE if we have an item that can only be used while aggro grabbed (unhanded aggro grab treatments go in [/datum/wound/proc/try_handling()]). Treatment is still is handled in [/datum/wound/proc/treat()]
/datum/wound/proc/check_grab_treatments(obj/item/I, mob/user)
	return FALSE

/// Like try_treating() but for unhanded interactions from humans, used by joint dislocations for manual bodypart chiropractice for example.  Ignores thick material checks since you can pop an arm into place through a thick suit unlike using sutures.
/datum/wound/proc/try_handling(mob/living/carbon/human/user)
	return FALSE

/// Someone is using something that might be used for treating the wound on this limb
/datum/wound/proc/treat(obj/item/I, mob/user)
	return

/// Someone is using something that might be used for treating the infection on this limb
/datum/wound/proc/treat_infection(obj/item/I, mob/user)
	if(germ_level < WOUND_INFECTION_SANITIZATION_RATE)
		return FALSE
	else if(istype(I, /obj/item/stack/medical/ointment))
		ointment(I, user)
		return TRUE
	else if(istype(I, /obj/item/stack/medical/mesh))
		mesh(I, user)
		return TRUE
	else if(istype(I, /obj/item/flashlight/pen/paramedic))
		uv(I, user)
		return TRUE

/// If var/processing is TRUE, this is run on each life tick
/datum/wound/proc/handle_process()
	handle_germs()
	return

/// Handle the effects of infections
/datum/wound/proc/handle_germs()
	if(strikes_to_lose_limb <= 0)
		limb.receive_damage(toxin = 1)
		if(prob(1))
			victim.visible_message("<span class='danger'>The infection on the remnants of [victim]'s [limb.name] shift and bubble nauseatingly!</span>", "<span class='warning'>You can feel the infection on the remnants of your [limb.name] coursing through your veins!</span>")
		disabling = TRUE
		return
	
	var/antibiotics = victim.get_antibiotics()
	sanitization += (antibiotics * WOUND_SANITIZATION_PER_ANTIBIOTIC)

	if(limb.current_gauze)
		limb.seep_gauze(WOUND_INFECTION_SEEP_RATE)

	// sanitization is checked after the clearing check but before the rest, because we freeze the effects of infection while we have sanitization
	if(sanitization > 0)
		var/bandage_factor = (limb.current_gauze ? limb.current_gauze.splint_factor : 1)
		germ_level = max(0, germ_level - WOUND_INFECTION_SANITIZATION_RATE)
		sanitization = max(0, sanitization - (WOUND_INFECTION_SANITIZATION_RATE * bandage_factor))
		return

	switch(germ_level)
		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			if(prob(30))
				victim.adjustToxLoss(0.2)
				if(prob(6))
					to_chat(victim, "<span class='warning'>The [src.name] on your [limb.name] oozes a strange pus...</span>")
		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			if(!disabling && prob(2))
				to_chat(victim, "<span class='warning'><b>Your [limb.name] completely locks up, as you struggle for control against the infection!</b></span>")
				disabling = TRUE
			else if(disabling && prob(8))
				to_chat(victim, "<span class='notice'>You regain sensation in your [limb.name], but it's still in terrible shape!</span>")
				disabling = FALSE
			else if(prob(20))
				victim.adjustToxLoss(0.5)
		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			if(!disabling && prob(3))
				to_chat(victim, "<span class='warning'><b>You suddenly lose all sensation of the festering infection in your [limb.name]!</b></span>")
				disabling = TRUE
				pain_amount += 2
			else if(disabling && prob(3))
				to_chat(victim, "<span class='notice'>You can barely feel your [limb.name] again, and you have to strain to retain motor control!</span>")
				disabling = FALSE
				pain_amount += 2
			else if(prob(1))
				to_chat(victim, "<span class='warning'>You contemplate life without your [limb.name]...</span>")
				victim.adjustToxLoss(0.75)
				pain_amount += 2
			else if(prob(4))
				victim.adjustToxLoss(1)
		if(WOUND_INFECTION_SEPTIC to INFINITY)
			if(prob((germ_level)/(WOUND_INFECTION_MODERATE * 10)))
				switch(strikes_to_lose_limb)
					if(3 to INFINITY)
						to_chat(victim, "<span class='deadsay'>The skin on your [limb.name] is literally dripping off, you feel awful!</span>")
					if(2)
						to_chat(victim, "<span class='deadsay'><b>The infection in your [limb.name] is literally dripping off, you feel horrible!</b></span>")
					if(1)
						to_chat(victim, "<span class='deadsay'><b>Infection has just about completely claimed your [limb.name]!</b></span>")
					if(0)
						to_chat(victim, "<span class='deadsay'><b>The last of the nerve endings in your [limb.name] wither away, as the infection completely paralyzes your joint connector.</b></span>")
						threshold_penalty = 120 // piss easy to destroy
						var/datum/brain_trauma/severe/paralysis/sepsis = new (limb.body_zone)
						victim.gain_trauma(sepsis)
				pain_amount += 4
				strikes_to_lose_limb--

/// For use in do_after callback checks
/datum/wound/proc/still_exists()
	return (!QDELETED(src) && limb)

/// When our parent bodypart is hurt
/datum/wound/proc/receive_damage(wounding_type, wounding_dmg, wound_bonus, pain_dmg)
	return

/// Called from cryoxadone and pyroxadone when they're proc'ing. Wounds will slowly be fixed separately from other methods when these are in effect. crappy name but eh
/datum/wound/proc/on_xadone(power)
	cryo_progress += power
	if(cryo_progress > 66 * severity)
		switch(severity)
			if(WOUND_SEVERITY_TRIVIAL)
				if(prob(3))
					remove_wound()
			if(WOUND_SEVERITY_MODERATE)
				if(prob(1) && prob(20))
					remove_wound()

/// Used for fibrin treatments atm
/datum/wound/proc/on_hemostatic(quantity)
	if((severity <= WOUND_SEVERITY_MODERATE) && (quantity >= 10))
		if(prob(75))
			remove_wound()
		else
			blood_flow = round(blood_flow/2, 0.1)
			if(victim)
				victim.visible_message("<span class='notice'>The [lowertext(src.name)] on [victim]'s [limb.name] seems to be bleeding considerably less.</span>")
	else if((severity == WOUND_SEVERITY_SEVERE) && (quantity >= 30))
		if(prob(25))
			remove_wound()
		else
			blood_flow = round(blood_flow/2, 0.1)
			if(victim)
				victim.visible_message("<span class='notice'>The [lowertext(src.name)] on [victim]'s [limb.name] seems to be bleeding considerably less.</span>")
	else if(quantity >= 5)
		blood_flow = max(round(blood_flow - (initial(blood_flow)/5), 0.1), 0)
		if(victim)
			victim.visible_message("<span class='notice'>The [lowertext(src.name)] on [victim]'s [limb.name] seems to be significantly eased.</span>")
	if(quantity >= 10)
		germ_level = max(round(germ_level - WOUND_INFECTION_MODERATE, 0.1), 0)
		if(victim)
			victim.visible_message("<span class='notice'>The [lowertext(src.name)] on [victim]'s [limb] seems significantly cleaner.</span>")

/// Used when put on a stasis bed
/datum/wound/proc/on_stasis()
	return

/// When synthflesh is applied to the victim, we call this. No sense in setting up an entire chem reaction system for wounds when we only care for a few chems. Probably will change in the future
/datum/wound/proc/on_synthflesh(power)
	return

/// Called when we're crushed in an airlock or firedoor, for one of the improvised joint dislocation fixes
/datum/wound/proc/crush()
	return

/datum/wound/proc/drag_bleed_amt()
	return

/**
  * get_examine_description() is used in carbon/examine and human/examine to show the status of this wound. Useful if you need to show some status like the wound being splinted or bandaged.
  *
  * Return the full string line you want to show, note that we're already dealing with the 'warning' span at this point, and that \n is already appended for you in the place this is called from
  *
  * Arguments:
  * * mob/user: The user examining the wound's owner, if that matters
  */
/datum/wound/proc/get_examine_description(mob/user)
	if(strikes_to_lose_limb <= 0)
		return "<span class='deadsay'><B>[victim.p_their(TRUE)] [limb.name] is completely dead and unrecognizable as organic.</B></span>"

	var/condition = ""
	if(limb.current_gauze)
		var/bandage_condition
		switch(limb.current_gauze.absorption_capacity)
			if(0 to 1.25)
				bandage_condition = "nearly ruined "
			if(1.25 to 2.75)
				bandage_condition = "badly worn "
			if(2.75 to 4)
				bandage_condition = "slightly bloodied "
			if(4 to INFINITY)
				bandage_condition = "clean "

		condition += " underneath a dressing of [bandage_condition] [limb.current_gauze.name]"
	else
		switch(germ_level)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				condition += ", <span class='deadsay'>with small spots of discoloration along the nearby veins</span>"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				condition += ", <span class='deadsay'>with dark clouds spreading outwards under the skin</span>"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				condition += ", <span class='deadsay'>with streaks of rotten infection pulsating outward</span>"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				return "<span class='deadsay'><B>[victim.p_their(TRUE)] [limb.name] is a mess of pus and rot, skin literally dripping off the bone with infection!</B></span>"

	. = "[victim.p_their(TRUE)] [fake_limb ? fake_limb : limb.name] [examine_desc][condition]"
	if(severity >= WOUND_SEVERITY_MODERATE)
		. = "<B>[.]!</B>"
	else
		. = "[.]."

/datum/wound/proc/get_scanner_description(mob/user)
	var/infection_level = "None"
	switch(germ_level)
		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			infection_level = "Moderate"
		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			infection_level = "Severe"
		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			infection_level = "<span class='deadsay'>CRITICAL</span>"
		if(WOUND_INFECTION_SEPTIC to INFINITY)
			infection_level = "<span class='deadsay'>LOSS IMMINENT</span>"
	if(strikes_to_lose_limb <= 0)
		infection_level = "<span class='deadsay'>The infection is total. The bodypart is lost. Amputate or augment limb immediately.</span>"
	. = "Type: [name]\nSeverity: [severity_text()]\nDescription: [desc]\nRecommended Treatment: [treat_text]\nInfection Level: [infection_level]\n"
	if((germ_level >= WOUND_INFECTION_MODERATE) && (sanitization < germ_level))
		. += "<div class='ml-3'>"
		. += "\tSurgical debridement, antiobiotics/sterilizers, or regenerative mesh will rid infection. Paramedic UV penlights are also effective.\n"
		. += "</div>"

/datum/wound/proc/severity_text()
	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return "Trivial"
		if(WOUND_SEVERITY_MODERATE)
			return "Moderate"
		if(WOUND_SEVERITY_SEVERE)
			return "Severe"
		if(WOUND_SEVERITY_CRITICAL)
			return "Critical"
		if(WOUND_SEVERITY_LOSS)
			return "Dismembered"
		if(WOUND_SEVERITY_PERMANENT)
			return "Permanent"

//Infections
/datum/wound/proc/infection_check()
	if(is_treated())
		return FALSE
	if(is_disinfected())
		return FALSE
	return prob(infection_chance)

/datum/wound/proc/is_treated()
	return FALSE

/datum/wound/proc/is_disinfected()
	return (sanitization > germ_level)

/// Paramedic UV penlight disinfection
/datum/wound/proc/uv(obj/item/flashlight/pen/paramedic/I, mob/user)
	if(I.uv_cooldown > world.time)
		to_chat(user, "<span class='notice'>[I] is still recharging!</span>")
		return
	if(germ_level <= WOUND_INFECTION_SANITIZATION_RATE || germ_level < sanitization)
		to_chat(user, "<span class='notice'>There's no infection to treat on [victim]'s [limb.name]!</span>")
		return

	user.visible_message("<span class='notice'>[user] flashes the infection on [victim]'s [limb] with [I].</span>", "<span class='notice'>You flash the infection on [user == victim ? "your" : "[victim]'s"] [limb.name] with [I].</span>", vision_distance=COMBAT_MESSAGE_RANGE)
	sanitization += I.uv_power
	I.uv_cooldown = world.time + I.uv_cooldown_length

/// If someone is using mesh on our infection
/datum/wound/proc/mesh(obj/item/stack/medical/mesh/I, mob/user)
	user.visible_message("<span class='notice'>[user] begins wrapping [victim]'s [limb.name] with [I]...</span>", "<span class='notice'>You begin wrapping [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]...</span>")
	var/time_mod =  1
	//Medical skill affects the speed of the do_mob
	if(user.mind)
		var/datum/skills/firstaid/firstaid = GET_SKILL(user, firstaid)
		if(firstaid)
			time_mod *= firstaid.get_medicalstack_mod()
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay) * time_mod, target = victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	if(!I.use(1))
		to_chat(user, "<span class='warning'>There aren't enough stacks of [I.name] to heal \the [src.name]!</span>")
		return
	
	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message("<span class='green'>[user] applies [I] to [victim].</span>", "<span class='green'>You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name].</span>")
	sanitization += I.sanitization

	if(sanitization >= germ_level)
		to_chat(user, "<span class='notice'>You've done all you can with [I], now you must wait for the infection on [victim]'s [limb.name] to go away.</span>")
	else
		try_treating(I, user)

/// If someone is using ointment on our infection
/datum/wound/proc/ointment(obj/item/stack/medical/ointment/I, mob/user)
	user.visible_message("<span class='notice'>[user] begins applying [I] to [victim]'s [limb.name]...</span>", "<span class='notice'>You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]...</span>")
	var/time_mod = 1
	//Medical skill affects the speed of the do_mob
	if(user.mind)
		var/datum/skills/firstaid/firstaid = GET_SKILL(user, firstaid)
		if(firstaid)
			time_mod *= firstaid.get_medicalstack_mod()
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay) * time_mod, target = victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	if(!I.use(1))
		to_chat(user, "<span class='warning'>There aren't enough stacks of [I.name] to heal \the [src.name]!</span>")
		return
	
	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message("<span class='green'>[user] applies [I] to [victim].</span>", "<span class='green'>You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name].</span>")
	sanitization += I.sanitization

	if((germ_level <= 0 || sanitization >= germ_level))
		to_chat(user, "<span class='notice'>You've done all you can with [I], now you must wait for the infection on [victim]'s [limb.name] to go away.</span>")
	else
		try_treating(I, user)
