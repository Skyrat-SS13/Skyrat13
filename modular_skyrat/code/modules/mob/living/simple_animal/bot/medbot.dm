// Medibots are afraid of apples
/mob/living/simple_animal/bot
	var/spookedcooldown = 0
	var/spookedcooldowntime = 50
	var/spookedlocationset = FALSE
	var/spooked = FALSE
	var/screamcooldowntime = 10
	var/screamcooldown = 0

/mob/living/simple_animal/bot/medbot/handle_automated_action()
	if(!..())
		return
	
	for(var/atom/A in view(12, src))
		if(findtext(lowertext(A.name), "apple"))
			mode = BOT_PATROL
			return bot_patrol()

	if(mode == BOT_HEALING)
		return

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

/mob/living/simple_animal/bot/medbot/patrol_step()
	if(client)		// In use by player, don't actually move.
		return

	for(var/atom/A in view(12, src))
		if(findtext(lowertext(A.name), "apple"))
			spooked = TRUE
	if(spooked)
		var/message = "An apple a day keeps me away."
		if(world.time > spookedcooldown || !spookedcooldown)
			speak(message)
			spookedcooldown = world.time + spookedcooldowntime
		if(!spookedlocationset)
			mode = BOT_PATROL
			find_patrol_target()
			base_speed = 4
			spookedlocationset = TRUE
	else
		spookedlocationset = FALSE
		base_speed = 2

	if(loc == patrol_target)		// reached target
		//Find the next beacon matching the target.
		if(!get_next_patrol_target())
			find_patrol_target() //If it fails, look for the nearest one instead.
		return

	else if(path.len > 0 && patrol_target)		// valid path
		if(path[1] == loc)
			increment_path()
			return


		var/moved = bot_move(patrol_target)//step_towards(src, next)	// attempt to move
		if(!moved) //Couldn't proceed the next step of the path BOT_STEP_MAX_RETRIES times
			spawn(2)
				calc_path()
				if(path.len == 0)
					find_patrol_target()
				tries = 0

	else	// no path, so calculate new one
		mode = BOT_START_PATROL
	spooked = FALSE

/mob/living/simple_animal/bot/medbot/find_nearest_beacon()
	for(var/obj/machinery/navbeacon/NB in GLOB.navbeacons["[z]"])
		var/dist = get_dist(src, NB)
		if(nearest_beacon) //Loop though the beacon net to find the true closest beacon.
			//Ignore the beacon if were are located on it.
			if(dist>1 && dist<get_dist(src,nearest_beacon_loc))
				var/spooky = FALSE
				for(var/atom/A in view(14, NB))
					if(findtext(lowertext(A.name), "apple"))
						spooky = TRUE 
				if(spooky)
					continue
				nearest_beacon = NB.location
				nearest_beacon_loc = NB.loc
				next_destination = NB.codes["next_patrol"]
			else
				continue
		else if(dist > 1) //Begin the search, save this one for comparison on the next loop.
			nearest_beacon = NB.location
			nearest_beacon_loc = NB.loc
	patrol_target = nearest_beacon_loc
	destination = nearest_beacon

/mob/living/simple_animal/bot/medbot/Move(NewLoc,Dir=0,step_x=0,step_y=0)
	if(client)
		return ..()
	var/findNewLoc = FALSE
	for(var/atom/A in NewLoc)
		if(findtext(lowertext(A.name), "apple"))
			if(world.time > screamcooldown)
				speak("*scream")
				screamcooldown = world.time + screamcooldowntime
			findNewLoc = TRUE
	if(findNewLoc)
		var/list/possiblelocs = list()
		switch(Dir)
			if(NORTH)
				possiblelocs += locate(x +1, y + 1, z)
				possiblelocs += locate(x -1, y + 1, z)
			if(EAST)
				possiblelocs += locate(x + 1, y + 1, z)
				possiblelocs += locate(x + 1, y - 1, z)
			if(WEST)
				possiblelocs += locate(x - 1, y + 1, z)
				possiblelocs += locate(x - 1, y - 1, z)
			if(SOUTH)
				possiblelocs += locate(x - 1, y - 1, z)
				possiblelocs += locate(x + 1, y - 1, z)
			if(SOUTHEAST)
				possiblelocs += locate(x + 1, y, z)
				possiblelocs += locate(x + 1, y + 1, z)
			if(SOUTHWEST)
				possiblelocs += locate(x - 1, y, z)
				possiblelocs += locate(x - 1, y + 1, z)
			if(NORTHWEST)
				possiblelocs += locate(x - 1, y, z)
				possiblelocs += locate(x - 1, y - 1, z)
			if(NORTHEAST)
				possiblelocs += locate(x + 1, y - 1, z)
				possiblelocs += locate(x + 1, y, z)
		for(var/turf/T in possiblelocs)
			for(var/atom/A in T)
				if(findtext(lowertext(A.name), "apple"))
					possiblelocs -= T 
		if(possiblelocs.len)
			var/turf/validloc = pick(possiblelocs)
			return ..(validloc)
		else 
			return FALSE
	return ..()
