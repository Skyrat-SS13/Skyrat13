//skyrat change start
/datum/round_event_control/terror_spider
	name = "Terror Spiders"
	typepath = /datum/round_event/terror_spider
	weight = 5
	gamemode_blacklist = list("dynamic")
	max_occurrences = 1
	min_players = 40

/datum/round_event/terror_spider
	announceWhen = 240
	var/spawncount = 1

/datum/round_event/terror_spider/setup()
	announceWhen = rand(announceWhen, announceWhen + 30)
	spawncount = 1

/datum/round_event/terror_spider/announce()
	priority_announce("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", "outbreak5")

/datum/round_event/terror_spider/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue

		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(temp_vent_parent.other_atmosmch.len > 50)
				vents += temp_vent

	var/spider_type
	var/infestation_type = pick(1, 2, 3, 4, 5)
	switch(infestation_type)
		if(1)
			spider_type = /mob/living/simple_animal/hostile/poison/terror_spider/green
			spawncount = 5
		if(2)
			spider_type = /mob/living/simple_animal/hostile/poison/terror_spider/white
			spawncount = 2
		if(3)
			spider_type = /mob/living/simple_animal/hostile/poison/terror_spider/prince
			spawncount = 1
		if(4)
			spider_type = /mob/living/simple_animal/hostile/poison/terror_spider/queen
			spawncount = 1
		if(5)
			spider_type = /mob/living/simple_animal/hostile/poison/terror_spider/princess
			spawncount = 2
	while(spawncount >= 1 && vents.len)
		var/obj/machinery/atmospherics/components/unary/vent_pump/vent = pick(vents)
		if(vent.welded)
			vents -= vent
			continue

		// If the vent we picked has any living mob nearby, just remove it from the list, loop again, and pick something else.

		var/turf/T = get_turf(vent)
		var/hostiles_present = FALSE
		for(var/mob/living/L in viewers(T))
			if(L.stat != DEAD)
				hostiles_present = TRUE
				break

		vents -= vent
		if(!hostiles_present)
			new spider_type(vent.loc)
			spawncount--
//skyrat change stop