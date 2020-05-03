// Medibots are afraid of apples
/mob/living/simple_animal/bot
	var/spookedcooldown = 0
	var/spookedcooldowntime = 50
	var/spookedlocationset = FALSE
	var/spooked

/mob/living/simple_animal/bot/medbot/handle_automated_action()
	if(!..())
		return

	if(mode == BOT_HEALING)
		return
	for(var/atom/A in view(7, src))
		if(findtext(lowertext(A.name), "apple"))
			return bot_patrol()

	if(IsStun())
		oldpatient = patient
		patient = null
		mode = BOT_IDLE
		return

	if(frustration > 8)
		oldpatient = patient
		soft_reset()

	if(QDELETED(patient))
		if(!shut_up && prob(1))
			var/list/messagevoice = list("Radar, put a mask on!" = 'sound/voice/medbot/radar.ogg',"There's always a catch, and I'm the best there is." = 'sound/voice/medbot/catch.ogg',"I knew it, I should've been a plastic surgeon." = 'sound/voice/medbot/surgeon.ogg',"What kind of medbay is this? Everyone's dropping like flies." = 'sound/voice/medbot/flies.ogg',"Delicious!" = 'sound/voice/medbot/delicious.ogg')
			var/message = pick(messagevoice)
			speak(message)
			playsound(loc, messagevoice[message], 50, 0)
		var/scan_range = (stationary_mode ? 1 : DEFAULT_SCAN_RANGE) //If in stationary mode, scan range is limited to adjacent patients.
		patient = scan(/mob/living/carbon/human, oldpatient, scan_range)
		oldpatient = patient

	if(patient && (get_dist(src,patient) <= 1)) //Patient is next to us, begin treatment!
		if(mode != BOT_HEALING)
			mode = BOT_HEALING
			update_icon()
			frustration = 0
			medicate_patient(patient)
		return

	//Patient has moved away from us!
	else if(patient && path.len && (get_dist(patient,path[path.len]) > 2))
		path = list()
		mode = BOT_IDLE
		last_found = world.time

	else if(stationary_mode && patient) //Since we cannot move in this mode, ignore the patient and wait for another.
		soft_reset()
		return

	if(patient && path.len == 0 && (get_dist(src,patient) > 1))
		path = get_path_to(src, get_turf(patient), /turf/proc/Distance_cardinal, 0, 30,id=access_card)
		mode = BOT_MOVING
		if(!path.len) //try to get closer if you can't reach the patient directly
			path = get_path_to(src, get_turf(patient), /turf/proc/Distance_cardinal, 0, 30,1,id=access_card)
			if(!path.len) //Do not chase a patient we cannot reach.
				soft_reset()

	if(path.len > 0 && patient)
		if(!bot_move(path[path.len]))
			oldpatient = patient
			soft_reset()
		return

	if(path.len > 8 && patient)
		frustration++

	if(auto_patrol && !stationary_mode && !patient)
		if(mode == BOT_IDLE || mode == BOT_START_PATROL)
			start_patrol()

		if(mode == BOT_PATROL)
			bot_patrol()

	return

/mob/living/simple_animal/bot/medbot/bot_patrol()
	. = ..()
	for(var/atom/A in view(7, src))
		if(findtext(lowertext(A.name), "apple"))
			spooked = TRUE
		else 
			spooked = FALSE
	if(spooked)
		var/message = "An apple a day keeps me away."
		if(world.time > spookedcooldown)
			speak(message)
			spookedcooldown = world.time + spookedcooldowntime
		if(!spookedlocationset)
			mode = BOT_PATROL
			var/list/validturfs = (view(10, src) - view(7, src))
			for(var/turf/T in validturfs)
				if(T.density)
					validturfs -= T
			patrol_target = pick(validturfs)
			spookedlocationset = TRUE
			base_speed = 4
	else
		spookedlocationset = FALSE
		base_speed = 2

