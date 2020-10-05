
/mob/living/simple_animal/parrot/proc/check_command() // Skyrat - Poly listens to some of the CE's commands!
	return FALSE // Simply return false for non-Poly parrots

/mob/living/simple_animal/parrot/Poly/check_command(message, speaker) // Skyrat - Poly listens to some of the CE's commands!
	var/mob/living/carbon/human/H = speaker
	if(!istype(H))
		return FALSE
	if(!H.mind || H.mind.assigned_role != "Chief Engineer")
		return FALSE // Not CE, Poly don't care!
	
	if(findtext(message, "poly"))
		if(findtext(message, "perch") || findtext(message, "hop"))
			if(findtext(message, "me") || findtext(message, "shoulder")) // putting an && in a single if() didn't work properly
				// Variations of the message "Poly, hop/perch on me/my shoulder"
				command_perch(H)
				return TRUE

		if(findtext(message, "off"))
			if(findtext(message, "me") || findtext(message, "shoulder") || findtext(message, "hop"))
				// Variations of "Poly, get/hop off of me/my shoulder."
				command_hop_off(H)
				return TRUE
			
		if(findtext(message, "shut") && speak_chance)
			if(prob(90))
				emote("me", EMOTE_VISIBLE, "lets out a soft bawk and lowers their head, remaining silent afterwards.")
				addtimer(CALLBACK(src, .proc/command_resume_speech, speak_chance), 5 MINUTES)
				speak_chance = 0
			return TRUE

	return FALSE // Wasn't a command.

/mob/living/simple_animal/parrot/Poly/proc/command_perch(var/mob/living/carbon/human/H) // Skyrat proc
	check_state()
	if(H.has_buckled_mobs() && H.buckled_mobs.len >= H.max_buckled_mobs)
		return
	if(buckled_to_human)
		emote("me", EMOTE_VISIBLE, "gives [H] a confused look, squawking softly.")
		return
	if(get_dist(src, H) > 1 || buckled) // Only adjacent
		emote("me", EMOTE_VISIBLE, "tilts their head at [H], before bawking loudly and staying put.")
		return
	emote("me", EMOTE_VISIBLE, "obediently hops up onto [H]'s shoulder, spreading their wings for a moment before settling down.")
	perch_on_human(H)

/mob/living/simple_animal/parrot/Poly/proc/command_hop_off(var/mob/living/carbon/human/H) // Skyrat proc
	check_state()
	if(!buckled_to_human || !buckled)
		emote("me", EMOTE_VISIBLE, "gives [H] a confused look, squawking softly.")
		return

	icon_state = icon_living
	parrot_state = PARROT_WANDER
	if(buckled)
		to_chat(src, "<span class='notice'>You are no longer sitting on [buckled].</span>")
		emote("me", EMOTE_VISIBLE, "squawks and hops off of [buckled], flying away.")
		buckled.unbuckle_mob(src, TRUE)
	buckled = null
	buckled_to_human = FALSE
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)

/mob/living/simple_animal/parrot/Poly/proc/command_resume_speech(var/initial_chance) // Skyrat proc
	speak_chance = initial_chance
	if(prob(40)) // Telling Poly to shut can have consequences.
		speak_chance += 1

/mob/living/simple_animal/parrot/Poly/proc/check_state() // Manually unbuckling without the command breaks things, and not a single proc is called on the mob being unbuckled. Gotta do it this way.
	if(buckled_to_human && !buckled)
		buckled_to_human = FALSE
		pixel_x = initial(pixel_x)
		pixel_y = initial(pixel_y)
		parrot_state = PARROT_WANDER
