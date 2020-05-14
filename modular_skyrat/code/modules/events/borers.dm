/datum/round_event_control/borers
	name = "Cortical Borers"
	typepath = /datum/round_event/borers
	weight = 15
	min_players = 15
	earliest_start = 30 MINUTES
	max_occurrences = 1
	gamemode_blacklist = list()
	var/successSpawn = FALSE //we only make an announcement if borers actually spawn

/datum/round_event/borers
	announceWhen = 400
	startWhen = 25
	var/spawncount = 5

/datum/round_event/borers/announce(fake)
	if(successSpawn)
		if(prob(65))
			priority_announce("Scanners have detected an influx of parasitic lifeforms near [station_name()], please stand-by.", "Lifesign Alert")
		else
			print_command_report("Parasitic entities have been migrating to [station_name()]. Cooperation with medical staff is advised.", "Biological entities")

/datum/round_event/borers/start()
	var/list/possiblevents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrub in world)
		if(is_station_level(scrub.z) && !scrub.welded)
			//Prevents borers from being stuck in small and closed networks
			if(scrub.parent.other_atmosmch.len > 50)
				vents += scrub
	while(spawncount > 0)
		var/obj/vent = pick_n_take(vents)
		new /mob/living/simple_animal/borer(vent.loc)
		successSpawn = TRUE
