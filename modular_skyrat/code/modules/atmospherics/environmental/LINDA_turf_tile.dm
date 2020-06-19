//TODO:
//Better space tiles handling
//Planetary atmos
//High pressure pushes
//Check if thermal energy is behaving properly
//Calculate pressure more efficiently by using the group, not the individual tiles

/turf/proc/process_cell(fire_count)
	SSair.remove_from_active(src)

/turf/open/process_cell(fire_count)
	var/list/affected_turfs = list()
	var/datum/gas_mixture/current_gasmix
	affected_turfs[src] = TRUE
	for(var/turfloop in 1 to 3)
		for(var/t in affected_turfs) //Adjacent turfs handles multi-z too
			var/turf/open/aff_turf = t
			for(var/AdjTurf in aff_turf.atmos_adjacent_turfs)
				if(!SSair_turfs.exempt_currentrun[AdjTurf])
					affected_turfs[AdjTurf] = TRUE

	var/list/final_gas_mix = list()
	var/list/final_temp = 0
	var/mulitplier = 1/affected_turfs.len
	for(var/turf/open/aff_turf in affected_turfs)
		current_gasmix = aff_turf.air
		for(var/gas_datum in current_gasmix.gases)
			if(!final_gas_mix[gas_datum])
				final_gas_mix[gas_datum] = 0
			final_gas_mix[gas_datum] += current_gasmix.gases[gas_datum]
		final_temp += current_gasmix.temperature

	for(var/gas_datum in final_gas_mix)
		final_gas_mix[gas_datum] *= mulitplier
	final_temp *= mulitplier

	for(var/turf/open/aff_turf in affected_turfs)
		current_gasmix = aff_turf.air
		for(var/gas_datum in final_gas_mix)
			current_gasmix.gases[gas_datum] = final_gas_mix[gas_datum]
		current_gasmix.temperature = final_temp
		aff_turf.update_visuals()
		if(current_gasmix.similar_pressure())
			SSair.remove_from_active(aff_turf)
		else
			SSair.add_to_active(aff_turf)
		SSair_turfs.currentrun -= aff_turf
		SSair_turfs.exempt_currentrun[aff_turf] = TRUE


/turf/open/space/process_cell(fire_count) //dumb hack to prevent space pollution
	. = ..()
	var/datum/gas_mixture/immutable/I = space_gas
	I.after_process_cell()

/datum/gas_mixture
	var/cached_pressure = 101.3 //Doesn't matter much if it's wrong initially

/datum/gas_mixture/proc/similar_pressure()
	var/epic = cached_pressure
	var/leisure = 1
	if(epic>500) //Higher pressure similarity when on fire/high pressure. Done this way for speed?
		if(epic>4000)
			leisure = 800
		else if(epic>1100)
			leisure = 100
		else
			leisure = 25
	//var/percent = cached * 0.015
	cached_pressure = return_pressure()
	if(cached_pressure < epic+leisure && cached_pressure > epic-leisure)
		return TRUE
	return FALSE
