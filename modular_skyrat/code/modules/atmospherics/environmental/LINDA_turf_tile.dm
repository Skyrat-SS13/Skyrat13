//TODO:
//Flow noise
//High pressure pushes

//Range at which cell process will try and share air with, the more the faster and less accurately things will be processed
//Try and have this between 1 and 3
#define ATMOS_CELL_PROCESS_EXPLOSIVENESS 2
#define VACCUUM_CELL_HEAT_CAPACITY 50 //Different from HEAT_CAPACITY_VACUUM to give away effect of a radiating heat transfer instead of conductive one

/turf/proc/process_cell()
	SSair.remove_from_active(src)

/turf/open/process_cell()
	var/list/affected_turfs = list()
	var/datum/gas_mixture/current_gasmix
	var/turf/open/current_turf 
	var/list/cached_gasheats = GLOB.meta_gas_specific_heats
	var/list/exempt_list = SSair_turfs.exempt_currentrun
	affected_turfs[src] = TRUE
	for(var/turfloop in 1 to ATMOS_CELL_PROCESS_EXPLOSIVENESS)
		for(var/t in affected_turfs) //Adjacent turfs handles multi-z too
			current_turf = t
			for(var/AdjTurf in current_turf.atmos_adjacent_turfs)
				if(!exempt_list[AdjTurf])
					affected_turfs[AdjTurf] = TRUE

	var/list/final_gas_mix = list()
	var/final_therm = 0
	var/moles_for_pressure = 0
	var/mulitplier = 1/affected_turfs.len
	var/heat_capacity = 0
	var/inloop_gas_count = 0
	var/inloop_heat_cap = 0
	for(var/t in affected_turfs)
		current_turf = t
		current_gasmix = current_turf.air
		/*if(!current_gasmix) //This small statement exists purely because there's some bug somewhere causing open turfs to not have air
			affected_turfs -= current_turf
			continue*/
		inloop_heat_cap = 0
		for(var/gas_datum in current_gasmix.gases)
			if(!final_gas_mix[gas_datum])
				final_gas_mix[gas_datum] = 0
			inloop_gas_count = current_gasmix.gases[gas_datum]
			final_gas_mix[gas_datum] += inloop_gas_count
			moles_for_pressure += inloop_gas_count
			inloop_heat_cap += inloop_gas_count * cached_gasheats[gas_datum]
		final_therm += inloop_heat_cap * current_gasmix.temperature
		if(inloop_heat_cap)
			heat_capacity += inloop_heat_cap
		else
			heat_capacity += VACCUUM_CELL_HEAT_CAPACITY

	if(!heat_capacity) //If you havent gotten any heat capacity at this point - no point going further
		SSair.remove_from_active(src)
		return
	//Visual cache
	var/static/list/nonoverlaying_gases = typecache_of_gases_with_no_overlays()
	var/list/new_overlay_types = list()
	var/list/gas_overlays_cache = GLOB.meta_gas_overlays
	var/list/gas_overlays_vis_cache = GLOB.meta_gas_visibility
	var/list/atmos_overlay_types 
	var/cached_float
	//
	for(var/gas_datum in final_gas_mix)
		cached_float = final_gas_mix[gas_datum] * mulitplier
		final_gas_mix[gas_datum] = cached_float
		if (nonoverlaying_gases[gas_datum])
			continue
		var/gas_overlay = gas_overlays_cache[gas_datum]
		if(gas_overlay && cached_float > gas_overlays_vis_cache[gas_datum])
			new_overlay_types += gas_overlay[min(FACTOR_GAS_VISIBLE_MAX, CEILING(cached_float / MOLES_GAS_VISIBLE_STEP, 1))]

	final_therm *= mulitplier
	moles_for_pressure *= mulitplier
	heat_capacity *= mulitplier
	var/final_temp = final_therm / heat_capacity
	//Pressure
	moles_for_pressure *= final_temp * 0.003324
	//
	for(var/t in affected_turfs)
		current_turf = t
		current_gasmix = current_turf.air
		if(current_gasmix.type != /datum/gas_mixture/immutable/space)
			for(var/gas_datum in final_gas_mix)
				current_gasmix.gases[gas_datum] = final_gas_mix[gas_datum]
			current_gasmix.temperature = final_temp
			//VISUALS
			//current_turf.update_visuals()
			atmos_overlay_types = current_turf.atmos_overlay_types
			if (atmos_overlay_types)
				for(var/overlay in atmos_overlay_types-new_overlay_types) //doesn't remove overlays that would only be added
					current_turf.vis_contents -= overlay
			if (length(new_overlay_types))
				if (atmos_overlay_types)
					current_turf.vis_contents += new_overlay_types - atmos_overlay_types //don't add overlays that already exist
				else
					current_turf.vis_contents += new_overlay_types
			current_turf.atmos_overlay_types = new_overlay_types
			//
			current_gasmix.prev_pressure = current_gasmix.cur_pressure
			current_gasmix.cur_pressure = moles_for_pressure
			/*if(current_gasmix.cur_pressure>500) //Higher pressure similarity when on fire/high pressure. Done this way for speed?
				if(current_gasmix.cur_pressure>4000)
					leisure = 100
				else if(current_gasmix.cur_pressure>1100)
					leisure = 20
				else
					leisure = 2*/
			if(current_gasmix.cur_pressure < current_gasmix.prev_pressure+0.8 && current_gasmix.cur_pressure > current_gasmix.prev_pressure-0.8)
				SSair.active_turfs -= current_turf
			else
				SSair.add_to_active(current_turf)
			//SSair.add_to_react_queue(current_turf) //Yes? No? maybe?
			if(current_turf.planetary_atmos)
				SSplanetatmos.currentrun[current_turf] = TRUE
				//current_turf.handle_planet_atmos()
		else
			SSair.active_turfs -= current_turf
		SSair_turfs.currentrun -= current_turf
		SSair_turfs.exempt_currentrun[current_turf] = TRUE


/*/turf/open/space/process_cell(fire_count) //dumb hack to prevent space pollution
	. = ..()
	var/datum/gas_mixture/immutable/I = space_gas
	I.after_process_cell()*/

#undef ATMOS_CELL_PROCESS_EXPLOSIVENESS
#undef VACCUUM_CELL_HEAT_CAPACITY

/datum/gas_mixture
	var/prev_pressure = 101.3 //Doesn't matter much if it's wrong initially
	var/cur_pressure = 101.3

/turf/proc/handle_planet_atmos()
	return

/turf/open/handle_planet_atmos()
	var/list/cached_gasheats = GLOB.meta_gas_specific_heats //oh boy heat capacity here we go AGAIN
	var/datum/gas_mixture/cached_selfgas = air.gases
	var/target_temp = 293.15
	var/target_heat_cap = 0
	var/list/target_gas = params2list(initial_gas_mix)
	var/list/target_gases = list()

	var/list/target_gases_low = list()
	var/list/target_gases_high = list()
	if(target_gas["TEMP"])
		target_temp = text2num(target_gas["TEMP"])
		target_gas -= "TEMP"
	for(var/id in target_gas)
		var/path = id
		if(!ispath(path))
			path = gas_id2path(path)
		target_gases[path] = text2num(target_gas[id])
		target_heat_cap += target_gases[path] * cached_gasheats[path]
		target_gases_low[path] = target_gases[path] * 0.7
		target_gases_high[path] = target_gases[path] * 1.3

	var/target_thermal = target_heat_cap * target_temp
	var/target_thermal_low = target_thermal * 0.7
	var/target_thermal_high = target_thermal * 1.3
	var/list/final_gas_mix = list()
	var/final_heat_cap = 0
	for(var/id in target_gases)
		if(!final_gas_mix[id])
			final_gas_mix[id] = 0
		final_gas_mix[id] += target_gases[id]
		final_heat_cap += cached_selfgas[id] * cached_gasheats[id]
	for(var/id in cached_selfgas)
		if(!final_gas_mix[id])
			final_gas_mix[id] = 0
		final_gas_mix[id] += cached_selfgas[id]
		final_heat_cap += cached_selfgas[id] * cached_gasheats[id]

	if(final_heat_cap == 0)
		return
	var/final_thermal = ((final_heat_cap * air.temperature) + target_thermal)/2
	//var/final_temp = final_thermal/final_heat_cap

	for(var/id in final_gas_mix)
		final_gas_mix[id] = final_gas_mix[id]/2

	if(final_thermal < target_thermal_high && final_thermal > target_thermal_low)
		var/similar_gases = TRUE
		for(var/id in target_gases)
			if(!(final_gas_mix[id] < target_gases_high[id] && final_gas_mix[id] > target_gases_low[id]))
				similar_gases = FALSE
				break
		if(similar_gases)
			air.gases = target_gases
			air.temperature = target_temp
			return
	air.gases = final_gas_mix
	air.temperature = final_thermal/final_heat_cap
	SSplanetatmos.currentrun[src] = TRUE
	//SSair.add_to_active(src)

/turf/proc/process_cell_reaction()
	SSair.remove_from_react_queue(src)

/turf/open/process_cell_reaction()
	if(air.react(src))
		update_visuals()
	else
		SSair.remove_from_react_queue(src)
	return