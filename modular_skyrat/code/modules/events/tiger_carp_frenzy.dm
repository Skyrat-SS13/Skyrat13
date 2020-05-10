/datum/round_event_control/tiger_carp_frenzy
	name = "Tiger Carp Frenzy"
	typepath = /datum/round_event/tiger_carp_frenzy
	weight = 10
	min_players = 15
	earliest_start = 20 MINUTES
	max_occurrences = 6
	gamemode_blacklist = list("dynamic")

/datum/round_event/tiger_carp_frenzy
	announceWhen	= 3
	startWhen = 50

/datum/round_event/tiger_carp_frenzy/setup()
	startWhen = rand(40, 60)

/datum/round_event/tiger_carp_frenzy/announce(fake)
	if(prob(50))
		priority_announce("Scanners have detected an influx of hostile entities near [station_name()], please stand-by.", "Lifesign Alert")
	else
		print_command_report("A pod of frenzied carp have been detected near [station_name()], you may wish to break out arms.", "Biological entities")


/datum/round_event/tiger_carp_frenzy/start()
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(99))
			new /mob/living/simple_animal/hostile/carp/tigercarp(C.loc)
		else
			new /mob/living/simple_animal/hostile/carp/megacarp(C.loc)

