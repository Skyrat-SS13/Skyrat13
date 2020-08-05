/datum/round_event_control/terror_spider_infestation
	name = "Terror Spiders Infestation"
	typepath = /datum/round_event/ghost_role/terror_spider_infestation
	weight = 5
	gamemode_blacklist = list("dynamic")
	min_players = 40
	max_occurrences = 1

/datum/round_event/ghost_role/terror_spider_infestation
	announceWhen	= 400

	minimum_required = 1
	role_name = ROLE_TERROR_SPIDER

	// 50% chance of being incremented by one
	var/spawncount = 1
	var/successSpawn = 0	//So we don't make a command report if nothing gets spawned.


/datum/round_event/ghost_role/terror_spider_infestation/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)
	if(prob(50))
		spawncount++

/datum/round_event/ghost_role/terror_spider_infestation/kill()
	if(!successSpawn && control)
		control.occurrences--
	return ..()

/datum/round_event/ghost_role/terror_spider_infestation/announce(fake)
	if(successSpawn || fake)
		priority_announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", "aliens")


/datum/round_event/ghost_role/terror_spider_infestation/spawn_role()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(temp_vent_parent.other_atmosmch.len > 20)
				vents += temp_vent

	if(!vents.len)
		message_admins("An event attempted to spawn a terror spider but no suitable vents were found. Shutting down.")
		return MAP_ERROR

	var/list/candidates = get_candidates(ROLE_ALIEN, null, ROLE_ALIEN)

	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	while(spawncount > 0 && vents.len && candidates.len)
		var/obj/vent = pick_n_take(vents)
		var/client/C = pick_n_take(candidates)


		var/mob/living/simple_animal/hostile/poison/terror_spider/queen/new_spider = new(vent.loc)
		new_spider.key = C.key

		spawncount--
		successSpawn = TRUE
		message_admins("[ADMIN_LOOKUPFLW(new_spider)] has been made into a terror spider by an event.")
		log_game("[key_name(new_spider)] was spawned as a terror spider by an event.")
		spawned_mobs += new_spider

	if(successSpawn)
		return SUCCESSFUL_SPAWN
	else
		// Like how did we get here?
		return FALSE
