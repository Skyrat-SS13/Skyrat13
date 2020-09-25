// Pain. Ported from Baystation 12 and cleaned up a bit.
/mob/living
	var/last_pain_message = ""
	var/next_pain_time = 0
	var/next_pain_message_time = 0

//Called on Life()
/mob/living/proc/handle_pain()
	return

/mob/living/proc/can_feel_pain()
	return FALSE

/mob/living/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_MOB_DEATH, .proc/update_pain)

/mob/living/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MOB_DEATH)

// Message is the custom message to be displayed
// Power decides how much painkillers will stop the message
// Force means it ignores anti-spam timer
// Robo_message is the message that gets used if it's a robotic limb instead
/mob/living/proc/custom_pain(message, power, force, obj/item/bodypart/affecting, nopainloss, robo_mesage)
	if((!message && !robo_mesage) || (stat >= UNCONSCIOUS) || !can_feel_pain() || chem_effects[CE_PAINKILLER] > power)
		return FALSE
	
	if(affecting?.status & BODYPART_NOPAIN)
		return FALSE

	power -= chem_effects[CE_PAINKILLER]/2	//Take the edge off.

	// Excessive pain is horrible, just give them enough to make it visible.
	if(!nopainloss && power)
		if(affecting)
			affecting.receive_damage(pain = CEILING(power/2, 1))
		else
			adjustPainLoss(CEILING(power/2, 1))

	// Anti message spam checks
	if(force || (message != last_pain_message) || (world.time >= next_pain_time))
		last_pain_message = message
		if(world.time >= next_pain_message_time)
			switch(power)
				if(PAIN_LEVEL_4 to INFINITY)
					to_chat(src, "<span class='bigdanger'>[message]</span>")
				if(PAIN_LEVEL_3 to PAIN_LEVEL_4)
					to_chat(src, "<span class='mediumdanger'>[message]</span>")
				if(PAIN_LEVEL_2 to PAIN_LEVEL_3)
					to_chat(src, "<span class='danger'>[message]</span>")
				if(PAIN_LEVEL_1 to PAIN_LEVEL_2)
					to_chat(src, "<span class='warning'>[message]</span>")

		var/force_emote
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.dna?.species)
				force_emote = H.dna.species.get_pain_emote(power)
		else if(ismonkey(src))
			force_emote = "groan"
		if(force_emote && prob(power))
			emote(force_emote)
	next_pain_message_time = world.time + (rand(150, 250) - power)
	next_pain_time = world.time + (rand(100, 200) - power)
	return TRUE
