/datum/round_event_control/scp294
	name = "Unassuming Coffee Vendor"
	typepath = /datum/round_event/scp294
	max_occurrences = 1
	weight = 5

/datum/round_event/scp294
	announceWhen = 10
	endWhen = 10

/datum/round_event/scp294/start()
	var/obj/machinery/vending/replaced
	var/list/can_replace = list()
	for(var/obj/machinery/vending/vendor in world)
		if(is_station_level(vendor.z))
			can_replace += vendor
	if(length(can_replace))
		replaced = pick(can_replace)
		new /obj/machinery/scp294(get_turf(replaced))
		qdel(replaced)

/datum/round_event/scp294/announce(fake)
	priority_announce("According to CentCom's anomalous research team, their coffee vending machine has suddenly gone missing. A quick scan of [station_name()] suggests it might have landed there.", "Anomalous Machinery")
