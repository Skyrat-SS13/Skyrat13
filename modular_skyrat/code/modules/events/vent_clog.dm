/datum/round_event/vent_clog/setup()
	endWhen = rand(120, 180)
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/temp_vent in GLOB.machines)
		var/turf/T = get_turf(temp_vent)
		var/area/A = T.loc
		if(T && is_station_level(T.z) && !A.safe)
			vents += temp_vent

	if(!vents.len)
		return kill()

/datum/round_event/vent_clog/tick()

	if(!vents.len)
		return kill()

	CHECK_TICK

	var/obj/machinery/atmospherics/components/unary/vent_scrubber/vent = pick(vents)
	vents -= vent

	if(!vent || vent.welded || !vent.on)
		return

	var/turf/T = get_turf(vent)
	if(!T)
		return

	var/scrubber_radius = 4

	var/datum/gas_mixture/int_air = vent.return_air()
	if(!int_air)
		return

	var/pressure = int_air.return_pressure()
	if(pressure)
		scrubber_radius += (pressure/100)
		scrubber_radius = min(scrubber_radius,32)

	var/datum/reagents/R = new/datum/reagents(reagentsAmount)
	R.my_atom = vent
	if (prob(randomProbability))
		R.add_reagent(get_random_reagent_id(), reagentsAmount)
	else
		R.add_reagent(pick(saferChems), reagentsAmount)

	var/datum/effect_system/smoke_spread/chem/smoke_machine/C = new
	C.set_up(R,6,1,T)
	C.start()
	playsound(T, 'sound/effects/smoke.ogg', 50, 1, -3)