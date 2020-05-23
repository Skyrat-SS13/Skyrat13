/datum/action/vampire/stamina
	name = "Undying Stamina"
	desc = "Your heart pumps faster and your rushes, making you regenerate stamina. This will not drain blood if no stamina is regenerated."
	button_icon_state = "power_stamina"
	warn_constant_cost = TRUE
	amToggle = TRUE
	purchasable = TRUE
	bloodcost = 0
	required_bloodlevel = 450
	cooldown = 0

/datum/action/vampire/stamina/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if (owner.stat >= DEAD)
		return FALSE
	return TRUE

/datum/action/vampire/stamina/ActivatePower()
	to_chat(owner, "<span class='notice'>You feel your heart beat faster and your blood rush.</span>")
	var/mob/living/carbon/C = owner
	while(ContinueActive(owner))
		if(C.getStaminaLoss())
			var/effectiveness = 1
			if(C.getStaminaLoss() > 100)
				effectiveness = 2
				C.Jitter(5)
			C.blood_volume -= 0.6 * effectiveness
			C.adjustStaminaLoss(-3 * effectiveness)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/vampire/stamina/ContinueActive(mob/living/user, mob/living/target)
	return ..() && user.stat <= DEAD && user.blood_volume > required_bloodlevel

/*
/obj/effect/proc_holder/vampire/vitality
	panel = "Supernatural Vitality"
	name = "Enhance your body with regenerative properties, quickly regenerating brute, oxygen and some burn damage. This will drain blood over time, but only if it actually heals you. Fire halts the regeneration"
	desc = "" // Fluff
	var/helptext = "" // Details
	var/power_cost = 0 //Cost of power to use the ability
	var/blood_cost = 0 //Cost of blood to use the ability
	var/blood_req = 0 //Requirement in blood to use the ability, in percentages

/obj/effect/proc_holder/vampire/vitality/Trigger(mob/user)
*/

/datum/action/vampire/vitality
	name = "Supernatural Vitality"
	desc = "Enhance your body with regenerative properties, quickly regenerating brute damage aswell as some burn damage. Being set on fire halts the regeneration. This wont drain your blood if it's not healing you."
	button_icon_state = "power_vitality"
	warn_constant_cost = TRUE
	amToggle = TRUE
	purchasable = TRUE
	bloodcost = 0
	required_bloodlevel = 450
	cooldown = 0

/datum/action/vampire/vitality/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if (owner.stat >= DEAD)
		return FALSE
	return TRUE

/datum/action/vampire/vitality/ActivatePower()
	to_chat(owner, "<span class='notice'>You feel your wounds mending.</span>")
	var/mob/living/carbon/C = owner
	var/mob/living/carbon/human/H
	if(ishuman(owner))
		H = owner
	while(ContinueActive(owner))
		if(!(C.fire_stacks) && (C.getFireLoss() || C.getBruteLoss() || C.getToxLoss()))
			var/effectiveness = 1
			if(C.health < 30)
				effectiveness = 2
			C.adjustBruteLoss(-1.5 * effectiveness)
			C.adjustFireLoss(-0.5 * effectiveness)
			C.adjustToxLoss(-0.5 * effectiveness, forced = TRUE)
			C.blood_volume -= 0.3 * effectiveness
			//C.adjustStaminaLoss(-15)
			// Stop Bleeding
			if(istype(H) && H.bleed_rate > 0 && rand(20) == 0)
				H.bleed_rate --
			//C.Jitter(5)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/vampire/vitality/ContinueActive(mob/living/user, mob/living/target)
	return ..() && user.stat <= DEAD && user.blood_volume > required_bloodlevel


/datum/action/vampire/cloak
	name = "Cloak of Darkness"
	desc = "Blend into the shadows and become invisible to the untrained eye. Movement is slowed in brightly lit areas, and you cannot dissapear while mortals watch you."
	button_icon_state = "power_cloak"
	bloodcost = 5
	cooldown = 50
	purchasable = TRUE
	amToggle = TRUE
	warn_constant_cost = TRUE
	var/moveintent_was_run
	var/runintent
	var/walk_threshold = 0.4 // arbitrary number, to be changed. edit in last commit: this is fine after testing on box station for a bit
	var/lum

/datum/action/vampire/cloak/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	// must have nobody around to see the cloak
	for(var/mob/living/M in viewers(9, owner))
		if(M != owner)
			to_chat(owner, "<span class='warning'>You may only vanish into the shadows unseen.</span>")
			return FALSE
	return TRUE

/datum/action/vampire/cloak/ActivatePower()
	var/datum/antagonist/vampire/vamp_datum = owner.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
	var/mob/living/user = owner

	moveintent_was_run = (user.m_intent == MOVE_INTENT_RUN)

	while(vamp_datum && ContinueActive(user))
		// Pay Blood Toll (if awake)
		owner.alpha = max(35, owner.alpha - min(75, 10 + 5 * level_current))
		vamp_datum.AddBloodVolume(-0.2)

		runintent = (user.m_intent == MOVE_INTENT_RUN)
		var/turf/T = get_turf(user)
		lum = T.get_lumcount()

		if(istype(owner.loc))
			if(lum > walk_threshold)
				if(runintent)
					user.toggle_move_intent()
					ADD_TRAIT(user, TRAIT_NORUNNING, "cloak of darkness")

			if(lum < walk_threshold)
				if(!runintent)
					user.toggle_move_intent()
					REMOVE_TRAIT(user, TRAIT_NORUNNING, "cloak of darkness")

		sleep(5) // Check every few ticks

/datum/action/vampire/cloak/ContinueActive(mob/living/user, mob/living/target)
	if (!..())
		return FALSE
	if(user.stat == !CONSCIOUS) // Must be CONSCIOUS
		to_chat(owner, "<span class='warning'>Your cloak failed due to you falling unconcious! </span>")
		return FALSE
	return TRUE

/datum/action/vampire/cloak/DeactivatePower(mob/living/user = owner, mob/living/target)
	..()
	REMOVE_TRAIT(user, TRAIT_NORUNNING, "cloak of darkness")
	user.alpha = 255

	runintent = (user.m_intent == MOVE_INTENT_RUN)

	if(!runintent && moveintent_was_run)
		user.toggle_move_intent()

/datum/action/vampire/feed
	name = "Feed"
	desc = "Sink your teeth into the neck of your victim and drink their blood! You need to aggressively grab them. This will make mortals unconscious"
	button_icon_state = "power_feed"

	bloodcost = 0
	cooldown = 900
	amToggle = TRUE
	purchasable = TRUE

	var/mob/living/feed_target 	// So we can validate more than just the guy we're grappling.
	var/target_grappled = FALSE // If you started grappled, then ending it will end your Feed.

/datum/action/vampire/feed/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	// Wearing mask
	var/mob/living/L = owner
	if(L.is_mouth_covered())
		if(display_error)
			to_chat(owner, "<span class='warning'>You cannot feed with your mouth covered! Remove your mask.</span>")
		return FALSE
	// Find my Target!
	if(!FindMyTarget(display_error)) // Sets feed_target within after Validating
		return FALSE
		// Not in correct state
	// DONE!
	return TRUE

/datum/action/vampire/feed/proc/ValidateTarget(mob/living/target, display_error) // Called twice: validating a subtle victim, or validating your grapple victim.
	// Must have Target
	if(!target)	 //  || !ismob(target)
		if(display_error)
			to_chat(owner, "<span class='warning'>You must be next to or grabbing a victim to feed from them.</span>")
		return FALSE
	// Not even living!
	if(!isliving(target) || issilicon(target) || target.isRobotic())
		if(display_error)
			to_chat(owner, "<span class='warning'>You may only feed from living beings.</span>")
		return FALSE
	var/victim_blood_percent = (target.blood_volume / (BLOOD_VOLUME_NORMAL * target.blood_ratio))
	if(victim_blood_percent <= 0.70)
		if(display_error)
			to_chat(owner, "<span class='warning'>Your victim has too little blood.</span>")
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(NOBLOOD in H.dna.species.species_traits)// || owner.get_blood_id() != target.get_blood_id())
			if(display_error)
				to_chat(owner, "<span class='warning'>Your victim's blood is not suitable for you to take.</span>")
			return FALSE
	return TRUE

// If I'm not grabbing someone, find me someone nearby.
/datum/action/vampire/feed/proc/FindMyTarget(display_error)
	// Default
	feed_target = null
	target_grappled = FALSE
	// If you are pulling a mob, that's your target. If you don't like it, then release them.
	if(owner.pulling && ismob(owner.pulling) && owner.grab_state >= GRAB_AGGRESSIVE)
		// Check grapple target Valid
		if(!ValidateTarget(owner.pulling, display_error)) // Grabbed targets display error.
			return FALSE
		target_grappled = TRUE
		feed_target = owner.pulling
		return TRUE

	to_chat(owner, "<span class='warning'>You must aggressively grab your victim!</span>")
	return FALSE

/datum/action/vampire/feed/ActivatePower()
	// set waitfor = FALSE   <---- DONT DO THIS!We WANT this power to hold up Activate(), so Deactivate() can happen after.
	var/mob/living/target = feed_target // Stored during CheckCanUse(). Can be a grabbed OR adjecent character.
	var/mob/living/user = owner
	var/datum/antagonist/vampire/vampiredatum = user.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
	// Initial Wait
	var/feed_time = (25) - (2.5 * level_current)
	feed_time = max(15, feed_time)
	to_chat(user, "<span class='warning'>You pull [target] close to you and draw out your fangs...</span>")
	if(!do_mob(user, target, feed_time, 0, 1, extra_checks = CALLBACK(src, .proc/ContinueActive, user, target)))//sleep(10)
		to_chat(user, "<span class='warning'>Your feeding was interrupted.</span>")
		//DeactivatePower(user,target)
		return
	ApplyVictimEffects(target)	// Sleep, paralysis, immobile, unconscious, and mute
	if(target.stat <= UNCONSCIOUS)
		sleep(1)
		// Wait, then Cancel if Invalid
		if(!ContinueActive(user,target)) // Cancel. They're gone.
			//DeactivatePower(user,target)
			return
	// Pull Target Close
	if(!target.density) // Pull target to you if they don't take up space.
		target.Move(user.loc)

	user.visible_message("<span class='warning'>[user] closes [user.p_their()] mouth around [target]'s neck!</span>", \
						 "<span class='warning'>You sink your fangs into [target]'s neck.</span>")
	// My mouth is full!
	ADD_TRAIT(user, TRAIT_MUTE, "bloodsucker_feed")

	// Begin Feed Loop
	var/warning_target_inhuman = FALSE
	var/warning_target_dead = FALSE
	var/warning_target_bloodvol = 99999
	var/amount_taken = 0
	var/blood_take_mult =  1 
	var/was_alive = target.stat < DEAD && ishuman(target)
	// Activate Effects
	//target.add_trait(TRAIT_MUTE, "bloodsucker_victim")  // <----- Make mute a power you buy?

	// FEEEEEEEEED!!! //
	vampiredatum.poweron_feed = TRUE
	while(vampiredatum && target && active)
	//user.mobility_flags &= ~MOBILITY_MOVE // user.canmove = 0 // Prevents spilling blood accidentally.

		// Abort? A bloody mistake.
		if(!do_mob(user, target, 20, 0, 0, extra_checks=CALLBACK(src, .proc/ContinueActive, user, target)))
			// May have disabled Feed during do_mob
			if(!active || !ContinueActive(user, target))
				break

			to_chat(user, "<span class='warning'>Your feeding has been interrupted!</span>")
			user.visible_message("<span class='danger'>[user] is ripped from [target]'s throat. [target.p_their(TRUE)] blood sprays everywhere!</span>", \
						 			 "<span class='userdanger'>Your teeth are ripped from [target]'s throat. [target.p_their(TRUE)] blood sprays everywhere!</span>")

			// Deal Damage to Target (should have been more careful!)
			if(iscarbon(target))
				var/mob/living/carbon/C = target
				C.bleed(15)
			playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.bleed_rate += 5
			target.add_splatter_floor(get_turf(target))
			user.add_mob_blood(target) // Put target's blood on us. The donor goes in the ( )
			target.add_mob_blood(target)
			target.take_overall_damage(10,0)
			target.emote("scream")

			// Killed Target?
			if(was_alive)
				CheckKilledTarget(user,target)

			return

		///////////////////////////////////////////////////////////
		// 		Handle Feeding! User & Victim Effects (per tick)
		vampiredatum.HandleFeeding(target, blood_take_mult)
		amount_taken += 1
		ApplyVictimEffects(target)	// Sleep, paralysis, immobile, unconscious, and mute
		if(amount_taken > 5 && target.stat < DEAD && ishuman(target))
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood) // GOOD // in bloodsucker_life.dm

		///////////////////////////////////////////////////////////
		// Not Human?
		if(!ishuman(target))
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood_bad) // BAD // in bloodsucker_life.dm
			if(!warning_target_inhuman)
				to_chat(user, "<span class='notice'>You recoil at the taste of a lesser lifeform.</span>")
				warning_target_inhuman = TRUE
		// Dead Blood?
		if(target.stat >= DEAD)
			if(ishuman(target))
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood_dead) // BAD // in bloodsucker_life.dm
			if(!warning_target_dead)
				to_chat(user, "<span class='notice'>Your victim is dead. [target.p_their(TRUE)] blood barely nourishes you.</span>")
				warning_target_dead = TRUE
		// Blood Remaining? (Carbons/Humans only)
		if(iscarbon(target) && !AmBloodsucker(target, TRUE))
			if(target.blood_volume <= BLOOD_VOLUME_BAD && warning_target_bloodvol > BLOOD_VOLUME_BAD)
				to_chat(user, "<span class='warning'>Your victim's blood volume is fatally low!</span>")
			else if(target.blood_volume <= BLOOD_VOLUME_OKAY && warning_target_bloodvol > BLOOD_VOLUME_OKAY)
				to_chat(user, "<span class='warning'>Your victim's blood volume is dangerously low.</span>")
			else if(target.blood_volume <= BLOOD_VOLUME_SAFE && warning_target_bloodvol > BLOOD_VOLUME_SAFE)
				to_chat(user, "<span class='notice'>Your victim's blood is at an unsafe level.</span>")
			warning_target_bloodvol = target.blood_volume // If we had a warning to give, it's been given by now.
		// Done?
		// Full?
		if(user.blood_volume >= vampiredatum.max_blood_volume)
			to_chat(user, "<span class='notice'>You are fully sated, you can't drink any more.</span>")
			break
		var/victim_blood_percent = (target.blood_volume / (BLOOD_VOLUME_NORMAL * target.blood_ratio))
		if(victim_blood_percent <= 0.65)
			to_chat(user, "<span class='notice'>You have bled your victim dry.</span>")
			break

		// Blood Gulp Sound
		owner.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
		target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
	// DONE!
	//DeactivatePower(user,target)
	user.visible_message("<span class='warning'>[user] unclenches their teeth from [target]'s neck.</span>", \
							 "<span class='warning'>You retract your fangs and release [target] from your bite.</span>")

	// /proc/log_combat(atom/user, atom/target, what_done, atom/object=null, addition=null)
	log_combat(owner, target, "fed on blood", addition="(and took [amount_taken] blood)")

	// Killed Target?
	if(was_alive)
		CheckKilledTarget(user,target)


/datum/action/vampire/feed/proc/CheckKilledTarget(mob/living/user, mob/living/target)
	// Bad Bloodsucker. You shouldn't do that.
	if(target && target.stat >= DEAD && ishuman(target))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankkilled", /datum/mood_event/drankkilled) // BAD // in bloodsucker_life.dm

/datum/action/vampire/feed/ContinueActive(mob/living/user, mob/living/target)
	return ..()  && target && (!target_grappled || user.pulling == target) && blood_sucking_checks(target, TRUE, TRUE) // Active, and still antag,
	// NOTE: We only care about pulling if target started off that way. Mostly only important for Aggressive feed.

/datum/action/vampire/feed/proc/ApplyVictimEffects(mob/living/target)
	// Bloodsuckers not affected by "the Kiss" of another vampire
	if(!target.mind || !target.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE))
		target.Unconscious(200)
		target.DefaultCombatKnockdown(40 + 5 * level_current,1)
		// NOTE: THis is based on level of power!
		if(ishuman(target))
			target.adjustStaminaLoss(5, forced = TRUE)// Base Stamina Damage

/datum/action/vampire/feed/DeactivatePower(mob/living/user = owner, mob/living/target)
	..() // activate = FALSE
	var/datum/antagonist/vampire/vampiredatum = user.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
	// No longer Feeding
	if(vampiredatum)
		vampiredatum.poweron_feed = FALSE
	feed_target = null
	// My mouth is no longer full
	REMOVE_TRAIT(owner, TRAIT_MUTE, "bloodsucker_feed")
	// Let me move immediately
	user.update_mobility()

/////// EMBRACE DOWN BELOW ///////////
/datum/action/vampire/embrace
	name = "Embrace"
	desc = "Sink your teeth into the neck of your victim and drink their blood! You need to aggressively grab them. This will make mortals unconscious"
	button_icon_state = "power_feed"

	bloodcost = 40
	powercost = 50
	cooldown = 900
	amToggle = FALSE
	purchasable = TRUE

	var/mob/living/feed_target 	// So we can validate more than just the guy we're grappling.
	var/target_grappled = FALSE // If you started grappled, then ending it will end your Feed.

/datum/action/vampire/embrace/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	// Wearing mask
	var/mob/living/L = owner
	if(L.is_mouth_covered())
		if(display_error)
			to_chat(owner, "<span class='warning'>You cannot feed with your mouth covered! Remove your mask.</span>")
		return FALSE
	// Find my Target!
	if(!FindMyTarget(display_error)) // Sets feed_target within after Validating
		return FALSE
		// Not in correct state
	// DONE!
	return TRUE

/datum/action/vampire/embrace/proc/ValidateTarget(mob/living/target, display_error)
	if(!target)
		if(display_error)
			to_chat(owner, "<span class='warning'>You must be next to or grabbing a victim to embrace them.</span>")
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/victim_blood_percent = (H.blood_volume / (BLOOD_VOLUME_NORMAL * H.blood_ratio))
		if(!can_make_vampire(H.mind))
			if(display_error)
				to_chat(owner, "<span class='warning'>Your victim is not suitable to be embraced.</span>")
			return FALSE
		if(victim_blood_percent <= 0.80) //Dont suck off and then embrace people, alright
			if(display_error)
				to_chat(owner, "<span class='warning'>Your victim has too little blood to recieve your gifts.</span>")
			return FALSE
		return TRUE
	to_chat(owner, "<span class='warning'>Your victim needs to be a human.</span>")
	return FALSE

// If I'm not grabbing someone, find me someone nearby.
/datum/action/vampire/embrace/proc/FindMyTarget(display_error)
	// Default
	feed_target = null
	target_grappled = FALSE
	// If you are pulling a mob, that's your target. If you don't like it, then release them.
	if(owner.pulling && ismob(owner.pulling) && owner.grab_state >= GRAB_AGGRESSIVE)
		// Check grapple target Valid
		if(!ValidateTarget(owner.pulling, display_error)) // Grabbed targets display error.
			return FALSE
		target_grappled = TRUE
		feed_target = owner.pulling
		return TRUE

	to_chat(owner, "<span class='warning'>You must aggressively grab your victim!</span>")
	return FALSE

/datum/action/vampire/embrace/ActivatePower()
	// set waitfor = FALSE   <---- DONT DO THIS!We WANT this power to hold up Activate(), so Deactivate() can happen after.
	var/mob/living/target = feed_target // Stored during CheckCanUse(). Can be a grabbed OR adjecent character.
	var/mob/living/user = owner
	// Initial Wait
	var/feed_time = 60
	to_chat(user, "<span class='warning'>You pull [target] close to you and draw out your fangs...</span>")
	if(!do_mob(user, target, feed_time, 0, 1, extra_checks = CALLBACK(src, .proc/CheckEmbraceTarget, user, target)))//sleep(10)
		to_chat(user, "<span class='warning'>Your embrace was interrupted.</span>")
		//DeactivatePower(user,target)
		return

	// Bloodsuckers not affected by "the Kiss" of another vampire
	if(!target.mind || !target.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE))
		target.Unconscious(200)
		target.DefaultCombatKnockdown(40 + 5 * level_current,1)
		// NOTE: THis is based on level of power!
		if(ishuman(target))
			target.adjustStaminaLoss(5, forced = TRUE)// Base Stamina Damage

	// Pull Target Close
	if(!target.density) // Pull target to you if they don't take up space.
		target.Move(user.loc)

	user.visible_message("<span class='warning'>[user] closes [user.p_their()] mouth around [target]'s neck!</span>", \
						 "<span class='warning'>You sink your fangs into [target]'s neck.</span>")

	// Blood Gulp Sound
	owner.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
	target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)

	// /proc/log_combat(atom/user, atom/target, what_done, atom/object=null, addition=null)
	var/datum/mind/target_mind = target.mind
	if(can_make_vampire(target_mind))
		var/datum/antagonist/vampire/user_vamp_datum = user.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
		var/datum/antagonist/vampire/target_vamp_datum = target.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
		if(user_vamp_datum)
			var/action = ""
			var/question_string = ""
			var/target_vampire = FALSE
			var/same_clan = FALSE
			var/target_has_clan = FALSE
			var/user_has_clan = FALSE
			if(target_vamp_datum)
				target_vampire = TRUE
				if(target_vamp_datum.vampire_clan)
					target_has_clan = TRUE
			if(user_vamp_datum.vampire_clan)
				user_has_clan = TRUE
			if(user_has_clan && target_has_clan && target_vamp_datum.vampire_clan == user_vamp_datum.vampire_clan)
				same_clan = TRUE
			if(same_clan)
				to_chat(user, "<span class='warning'>You shouldn't be embracing your clan members.</span>")
				return

			if(target_vampire && !user_has_clan)
				to_chat(user, "<span class='warning'>You can't bestow them with anything more.</span>")
				return

			if(target_vampire)
				question_string = "Would you like to join [user.name]'s clan?"
			else if (user_has_clan)
				question_string = "Would you like to be converted into a vampire and join [user.name]'s clan?"
			else
				question_string = "Would you like to be converted into a vampire?"

			if(target.client)
				var/failed = TRUE
				var/time_thershold = world.time + 400
				action = alert(target.client, question_string, "", "Yes", "No")
				if(!(world.time > time_thershold))
					if(action == "Yes")
						failed = FALSE
						to_chat(target, "<span class='boldwarning'>You give into the invigorating power flowing through your veins, you have became a supernatural entity, a vampire.</span>")
						if(target_vampire)
							var/datum/vampire_clan/VC = user_vamp_datum.vampire_clan
							VC.add_member(target_mind, FALSE)
							to_chat(user, "<span class='notice'>[target.name] embraced our gift and joined the clan.</span>")
						else if (user_has_clan)
							var/datum/vampire_clan/VC = user_vamp_datum.vampire_clan
							target_mind.add_antag_datum(/datum/antagonist/vampire,)
							VC.add_member(target_mind, FALSE)
							to_chat(user, "<span class='notice'>[target.name] embraced our gift and joined the clan.</span>")
						else
							target_mind.add_antag_datum(/datum/antagonist/vampire)
							to_chat(user, "<span class='notice'>[target.name] embraced our gift and is now one of us.</span>")
						log_combat(owner, target, "converted to vampire")

				if(failed) //We refund
					if(user)
						to_chat(user, "<span class='warning'>[target.name] rejected your embrace. We feed on them instead!</span>")
						to_chat(user, "<span class='warning'>They will not remember this.</span>")
					if(user_vamp_datum)
						user_vamp_datum.AddBloodVolume(bloodcost + 40)
						user_vamp_datum.AddPower(powercost + 20)
					if(target)
						target.Unconscious(200)
						to_chat(target, "<span class='boldwarning'>You resisting against the corrupting force and succeed, however this leaves you drained and weakened. You do not remember this.</span>")


/datum/action/vampire/embrace/proc/CheckEmbraceTarget(mob/living/user, mob/living/target)
	return  target && (!target_grappled || user.pulling == target) && blood_sucking_checks(target, TRUE, TRUE)