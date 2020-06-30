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
	var/turf/open/current_turf 
	affected_turfs[src] = TRUE
	for(var/turfloop in 1 to 3)
		for(var/t in affected_turfs) //Adjacent turfs handles multi-z too
			current_turf = t
			for(var/AdjTurf in current_turf.atmos_adjacent_turfs)
				if(!SSair_turfs.exempt_currentrun[AdjTurf])
					affected_turfs[AdjTurf] = TRUE

	var/list/final_gas_mix = list()
	var/final_therm = 0
	var/moles_for_pressure = 0
	var/mulitplier = 1/affected_turfs.len
	for(var/t in affected_turfs)
		current_turf = t
		current_gasmix = current_turf.air
		for(var/gas_datum in current_gasmix.gases)
			if(!final_gas_mix[gas_datum])
				final_gas_mix[gas_datum] = 0
			final_gas_mix[gas_datum] += current_gasmix.gases[gas_datum]
			moles_for_pressure += current_gasmix.gases[gas_datum]
		final_therm += THERMAL_ENERGY(current_gasmix) //For some reason vaccuum makes thermal energy TODO fix

	for(var/gas_datum in final_gas_mix)
		final_gas_mix[gas_datum] *= mulitplier
	final_therm *= mulitplier
	moles_for_pressure *= mulitplier
	//Temperature
	var/heat_capacity = 0
	for(var/id in final_gas_mix)
		heat_capacity += final_gas_mix[id] * GLOB.meta_gas_specific_heats[id]
	if(!heat_capacity) //If you havent gotten any heat capacity at this point - no point going further
		SSair.remove_from_active(src)
		return
	var/final_temp = final_therm / heat_capacity
	//Pressure
	moles_for_pressure *= R_IDEAL_GAS_EQUATION * final_temp / CELL_VOLUME 
	//
	for(var/t in affected_turfs)
		current_turf = t
		current_gasmix = current_turf.air
		if(current_gasmix.type != /datum/gas_mixture/immutable/space)
			for(var/gas_datum in final_gas_mix)
				current_gasmix.gases[gas_datum] = final_gas_mix[gas_datum]
			current_gasmix.temperature = final_temp
			current_turf.update_visuals()
			if(current_gasmix.similar_pressure(moles_for_pressure))
				SSair.remove_from_active(current_turf)
			else
				SSair.add_to_active(current_turf)
		else
			SSair.remove_from_active(current_turf)
		SSair_turfs.currentrun -= current_turf
		SSair_turfs.exempt_currentrun[current_turf] = TRUE


/*/turf/open/space/process_cell(fire_count) //dumb hack to prevent space pollution
	. = ..()
	var/datum/gas_mixture/immutable/I = space_gas
	I.after_process_cell()*/

/datum/gas_mixture
	var/prev_pressure = 101.3 //Doesn't matter much if it's wrong initially
	var/cur_pressure = 101.3

/datum/gas_mixture/proc/similar_pressure(press)
	prev_pressure = cur_pressure
	cur_pressure = press
	var/leisure = 1
	if(cur_pressure>500) //Higher pressure similarity when on fire/high pressure. Done this way for speed?
		if(cur_pressure>4000)
			leisure = 800
		else if(cur_pressure>1100)
			leisure = 100
		else
			leisure = 25
	if(cur_pressure < prev_pressure+leisure && cur_pressure > prev_pressure-leisure)
		return TRUE
	return FALSE
