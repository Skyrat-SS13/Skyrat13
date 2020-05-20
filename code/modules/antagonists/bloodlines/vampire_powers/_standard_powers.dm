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