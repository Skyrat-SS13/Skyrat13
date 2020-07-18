#define SIPHONING	0
#define SCRUBBING	1

#define MINIMUM_CONTAMINANTS_MOLES	0.05

/obj/machinery/atmospherics/components/unary/vent_scrubber/process_atmos()
	..()
	if(welded || !is_operational())
		return FALSE
	if(!nodes[1] || !on)
		on = FALSE
		return FALSE
	if(widenet)
		return aoe_scrub(loc)
	else
		return scrub(loc)

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/aoe_scrub(var/turf/tile)
	if(!istype(tile))
		return FALSE
	//Self
	var/datum/gas_mixture/air_contents = airs[1]
	var/list/self_gases = air_contents.gases
	var/self_heat_capacity = 0
	var/cached_float = 0
	var/list/cached_gasheats = GLOB.meta_gas_specific_heats
	for(var/id in self_gases)
		self_heat_capacity += self_gases[id] * cached_gasheats[id]
		cached_float += self_gases[id]
	if(cached_float * air_contents.temperature * 0.04155 >= 50*ONE_ATMOSPHERE)
		return FALSE

	var/list/affected_turfs = list()
	affected_turfs[tile] = TRUE
	for(var/t in adjacent_turfs)
		affected_turfs[t] = TRUE

	var/recieved_thermal_energy = 0
	var/recieved_heat_capacity = 0
	//Env
	var/env_moles
	var/datum/gas_mixture/environment
	var/list/env_gases
	var/env_temp

	var/transfer_moles
	var/transfer_unit

	var/turf/open/cur_turf

	if(scrubbing & SCRUBBING)
		for(var/t in affected_turfs)
			cur_turf = t
			environment = cur_turf.air
			env_gases = environment.gases
			env_moles = 0
			TOTAL_MOLES(env_gases, env_moles)
			if(length(env_gases & filter_types))
				transfer_moles = 0.08*env_moles
				env_temp = environment.temperature
				for(var/gas in filter_types & env_gases)
					if(env_gases[gas] && env_gases[gas] > MINIMUM_CONTAMINANTS_MOLES)
						transfer_unit = (env_gases[gas] / env_moles) * transfer_moles
						env_gases[gas] -= transfer_unit
						if(!self_gases[gas])
							self_gases[gas] = 0
						self_gases[gas] += transfer_unit
						cached_float = cached_gasheats[gas] * transfer_unit
						recieved_heat_capacity += cached_float
						recieved_thermal_energy += cached_float * env_temp

	else //Just siphoning all air
		for(var/t in affected_turfs)
			cur_turf = t
			environment = cur_turf.air
			env_gases = environment.gases
			env_temp = environment.temperature
			env_moles = 0
			TOTAL_MOLES(env_gases, env_moles)
			transfer_moles = 0.08*env_moles
			transfer_unit = env_moles * transfer_moles
			for(var/gas in env_gases)
				if(env_gases[gas])
					transfer_unit = (env_gases[gas] / env_moles) * transfer_moles
					env_gases[gas] -= transfer_unit
					if(!self_gases[gas])
						self_gases[gas] = 0
					self_gases[gas] += transfer_unit
					cached_float = cached_gasheats[gas] * transfer_unit
					recieved_heat_capacity += cached_float
					recieved_thermal_energy += cached_float * env_temp

	if(!recieved_heat_capacity)
		return FALSE

	air_contents.temperature = (((self_heat_capacity * air_contents.temperature)+recieved_thermal_energy)/(self_heat_capacity+recieved_heat_capacity))
	if(recieved_heat_capacity>1)
		tile.air_update_turf()
		update_parents()

	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/scrub(var/turf/tile)
	if(!istype(tile))
		return FALSE
	//Self
	var/datum/gas_mixture/air_contents = airs[1]
	var/list/self_gases = air_contents.gases
	var/self_heat_capacity = 0
	var/cached_float = 0
	var/list/cached_gasheats = GLOB.meta_gas_specific_heats
	for(var/id in self_gases)
		self_heat_capacity += self_gases[id] * cached_gasheats[id]
		cached_float += self_gases[id]
	if(cached_float * air_contents.temperature * 0.04155 >= 50*ONE_ATMOSPHERE)
		return FALSE
	var/datum/gas_mixture/environment = tile.return_air()
	var/list/env_gases = environment.gases
	var/env_moles = 0
	TOTAL_MOLES(env_gases, env_moles)
	var/env_temp = environment.temperature
	var/transfer_moles = 0.08*env_moles
	var/transfer_unit
	var/recieved_thermal_energy = 0
	var/recieved_heat_capacity = 0

	if(scrubbing & SCRUBBING)
		if(length(env_gases & filter_types))

			for(var/gas in filter_types & env_gases)
				if(env_gases[gas] && env_gases[gas] > MINIMUM_CONTAMINANTS_MOLES)
					transfer_unit = (env_gases[gas] / env_moles) * transfer_moles
					env_gases[gas] -= transfer_unit
					if(!self_gases[gas])
						self_gases[gas] = 0
					self_gases[gas] += transfer_unit
					cached_float = cached_gasheats[gas] * transfer_unit
					recieved_heat_capacity += cached_float
					recieved_thermal_energy += cached_float * env_temp

	else //Just siphoning all air
		transfer_unit = env_moles * transfer_moles
		for(var/gas in env_gases)
			if(env_gases[gas])
				transfer_unit = (env_gases[gas] / env_moles) * transfer_moles
				env_gases[gas] -= transfer_unit
				if(!self_gases[gas])
					self_gases[gas] = 0
				self_gases[gas] += transfer_unit
				cached_float = cached_gasheats[gas] * transfer_unit
				recieved_heat_capacity += cached_float
				recieved_thermal_energy += cached_float * env_temp

	if(!recieved_heat_capacity)
		return FALSE

	air_contents.temperature = (((self_heat_capacity * air_contents.temperature)+recieved_thermal_energy)/(self_heat_capacity+recieved_heat_capacity))
	
	if(recieved_heat_capacity>10)
		tile.air_update_turf()
		update_parents()

	return TRUE

#undef MINIMUM_CONTAMINANTS_MOLES

#undef SIPHONING
#undef SCRUBBING

