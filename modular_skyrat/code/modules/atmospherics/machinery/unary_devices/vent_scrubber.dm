/obj/machinery/atmospherics/components/unary/vent_scrubber/process_atmos()
	..()
	if(welded || !is_operational())
		return FALSE
	if(!nodes[1] || !on)
		on = FALSE
		return FALSE
	if(airs[1].return_pressure() >= 50*ONE_ATMOSPHERE)
		return FALSE
	scrub(loc)
	if(widenet)
		for(var/turf/tile in adjacent_turfs)
			scrub(tile)
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/scrub(var/turf/tile)
	if(!istype(tile))
		return FALSE
	var/datum/gas_mixture/environment = tile.return_air()
	var/datum/gas_mixture/air_contents = airs[1]
	var/list/env_gases = environment.gases
	var/list/self_gases = air_contents.gases
	var/self_thermal_energy = THERMAL_ENERGY(air_contents)
	var/list/cached_gasheats = GLOB.meta_gas_specific_heats

	var/env_moles = 0
	TOTAL_MOLES(env_gases, env_moles)
	var/env_temp = environment.temperature
	var/transfer_moles = 0.08*env_moles
	var/transfer_unit
	var/recieved_thermal_energy = 0
	var/total_heat_capacity = 0

	if(scrubbing & SCRUBBING)
		if(length(env_gases & filter_types))

			for(var/gas in filter_types & env_gases)
				transfer_unit = (env_gases[gas] / env_moles) * transfer_moles
				env_gases[gas] -= transfer_unit
				if(!self_gases[gas])
					self_gases[gas] = 0
				self_gases[gas] += transfer_unit
				recieved_thermal_energy += (cached_gasheats[gas] * transfer_unit) * env_temp

	else //Just siphoning all air
		transfer_unit = env_moles * transfer_moles
		for(var/gas in env_gases)
			env_gases[gas] -= transfer_unit
			if(!self_gases[gas])
				self_gases[gas] = 0
			self_gases[gas] += transfer_unit
			recieved_thermal_energy += (cached_gasheats[gas] * transfer_unit) * env_temp

	if(!recieved_thermal_energy)
		return FALSE

	for(var/id in self_gases)
		total_heat_capacity += self_gases[id] * cached_gasheats[id]

	if(!total_heat_capacity)
		return FALSE

	air_contents.temperature = ((self_thermal_energy+recieved_thermal_energy)/total_heat_capacity)
	tile.air_update_turf()

	update_parents()

	return TRUE
