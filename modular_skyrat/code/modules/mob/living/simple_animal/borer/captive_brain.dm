/mob/living/captive_brain
	name = "host brain"
	real_name = "host brain"

/mob/living/captive_brain/say(message)
	if(istype(loc,/mob/living/simple_animal/borer))
		message = sanitize(copytext(message, 0, message.len))
		if(!message || (message.len > MAX_MESSAGE_LEN))
			return
		log_say(message, src)
		if(stat == DEAD)
			return say_dead(message)
		var/mob/living/simple_animal/borer/B = loc
		to_chat(src, "You whisper silently, \"[message]\"")
		to_chat(B.host, "<i><span class='alien'>The captive mind of [src] whispers, \"[message]\"</span></i>")
		for(var/mob/M in GLOB.mob_list)
			if(M.mind && isobserver(M))
				to_chat(M, "<i>Thought-speech, <b>[src]</b> -> <b>[B.truename]:</b> [message]</i>")

/mob/living/captive_brain/emote(act, m_type = 1, message = null, force)
	return

/mob/living/captive_brain/resist()
	var/mob/living/simple_animal/borer/B = loc

	to_chat(src, "<span class='danger'>You begin doggedly resisting the parasite's control (this will take approximately 45 seconds).</span>")
	to_chat(B.host, "<span class='danger'>You feel the captive mind of [src] begin to resist your control.</span>")

	var/delay = (rand(300,400) + B.host.getBrainLoss())
	addtimer(CALLBACK(src, .proc/return_control, B), delay)


/mob/living/captive_brain/proc/return_control(mob/living/simple_animal/borer/B)
	if(!B || !B.controlling)
		return

	B.host.adjustOrganLoss(ORGAN_SLOT_BRAIN,rand(5,10))
	to_chat(src, "<span class='danger'>With an immense exertion of will, you regain control of your body!</span>")
	to_chat(B.host, "<span class='danger'>You feel control of the host brain ripped from your grasp, and retract your probosci before the wild neural impulses can damage you.</span>")

	B.detach()
