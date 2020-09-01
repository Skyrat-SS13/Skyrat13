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
	var/processes = FALSE

	/// If TRUE and an item that can treat multiple different types of coexisting wounds (gauze can be used to splint broken bones, staunch bleeding, and cover burns), we get first dibs if we come up first for it, then become nonpriority.
	/// Otherwise, if no untreated wound claims the item, we cycle through the non priority wounds and pick a random one who can use that item.
	var/treat_priority = FALSE

	/// Should we just ignore pre-existing wounds and apply anyways?
	var/ignore_preexisting = FALSE

	/// If having this wound makes currently makes the parent bodypart unusable
	var/disabling

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
	if(!victim.alerts["wound"]) // one alert is shared between all of the wounds
		victim.throw_alert("wound", /obj/screen/alert/status_effect/wound)

	var/demoted
	if(old_wound)
		demoted = (severity <= old_wound.severity)

	if(severity == WOUND_SEVERITY_TRIVIAL)
		return

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

	if(!demoted)
		wound_injury(old_wound)
		second_wind()

/// Remove the wound from whatever it's afflicting, and cleans up whateverstatus effects it had or modifiers it had on interaction times. ignore_limb is used for detachments where we only want to forget the victim
/datum/wound/proc/remove_wound(ignore_limb, replaced = FALSE, forced = FALSE)
	if(severity == WOUND_SEVERITY_PERMANENT && !forced)
		return FALSE
	//TODO: have better way to tell if we're getting removed without replacement (full heal) scar stuff
	wound_alert(TRUE)
	if(limb && !already_scarred && !replaced)
		already_scarred = TRUE
		if(limb.is_organic_limb())
			var/datum/scar/new_scar = new
			new_scar.generate(limb, src)
	if(victim)
		LAZYREMOVE(victim.all_wounds, src)
		if(!victim.all_wounds)
			victim.clear_alert("wound")
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
  */
/datum/wound/proc/replace_wound(new_type, smited = FALSE)
	var/datum/wound/new_wound = new new_type
	already_scarred = TRUE
	remove_wound(replaced=TRUE)
	new_wound.apply_wound(limb, old_wound = src, smited = smited)
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
	switch(severity)	
		if(WOUND_SEVERITY_MODERATE)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_MODERATE)
		if(WOUND_SEVERITY_SEVERE)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_SEVERE)
		if(WOUND_SEVERITY_CRITICAL)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_CRITICAL)
		if(WOUND_SEVERITY_LOSS)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_LOSS)
		if(WOUND_SEVERITY_PERMANENT)
			victim.reagents.add_reagent(/datum/reagent/determination, WOUND_DETERMINATION_PERMANENT)

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

/// If var/processing is TRUE, this is run on each life tick
/datum/wound/proc/handle_process()
	return

/// For use in do_after callback checks
/datum/wound/proc/still_exists()
	return (!QDELETED(src) && limb)

/// When our parent bodypart is hurt
/datum/wound/proc/receive_damage(wounding_type, wounding_dmg, wound_bonus)
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
/datum/wound/proc/get_examine_description(mob/user, check_victim = TRUE)
	if(check_victim && victim)
		. = "[victim.p_their(TRUE)] [fake_limb ? fake_limb : limb.name] [examine_desc]"
	else
		. = "[fake_limb ? fake_limb : limb.name] [examine_desc]"
		if(severity == WOUND_SEVERITY_LOSS)
			. = "It's [fake_limb ? fake_limb : limb.name] [examine_desc]"
	. = (severity <= WOUND_SEVERITY_MODERATE) ? "[.]." : "<B>[.]!</B>"

/datum/wound/proc/get_scanner_description(mob/user)
	return "Type: [name]\nSeverity: [severity_text()]\nDescription: [desc]\nRecommended Treatment: [treat_text]"

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
