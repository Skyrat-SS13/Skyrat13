/datum/pipeline/proc/reconcile_air()
	var/list/datum/gas_mixture/GL = list()
	var/PL = list()
	PL += src

	var/datum/gas_mixture/current_gasmix
	var/datum/pipeline/P
	var/obj/machinery/atmospherics/components/binary/valve/V
	var/obj/machinery/atmospherics/components/binary/relief_valve/RV
	var/obj/machinery/atmospherics/components/unary/portables_connector/C
	for(var/i = 1; i <= length(PL); i++) 
		P = PL[i]
		if(!P)
			continue
		GL += (P.other_airs + P.air)
		for(var/atmosmch in P.other_atmosmch)
			if (istype(atmosmch, /obj/machinery/atmospherics/components/binary/valve))
				V = atmosmch
				if(V.on)
					PL |= V.parents[1]
					PL |= V.parents[2]
			else if (istype(atmosmch,/obj/machinery/atmospherics/components/binary/relief_valve))
				RV = atmosmch
				if(RV.opened)
					PL |= RV.parents[1]
					PL |= RV.parents[2]
			else if (istype(atmosmch, /obj/machinery/atmospherics/components/unary/portables_connector))
				C = atmosmch
				if(C.connected_device)
					GL += C.portableConnectorReturnAir()

	var/total_thermal_energy = 0
	var/total_heat_capacity = 0
	var/total_volume = 0
	var/list/current_gases
	var/list/cached_gasheats = GLOB.meta_gas_specific_heats
	var/cached_float
	var/final_gases = list()

	for(var/i in GL)
		current_gasmix = i
		current_gases = current_gasmix.gases
		total_volume += current_gasmix.volume

		for(var/id in current_gases)
			cached_float = current_gases[id]
			final_gases[id] += cached_float
			cached_float *= cached_gasheats[id]
			total_heat_capacity += cached_float
			total_thermal_energy += cached_float * current_gasmix.temperature

	if(!total_heat_capacity)
		return
	var/final_temperature = total_thermal_energy/total_heat_capacity
	var/multiplier
	for(var/i in GL)
		current_gasmix = i
		current_gases = current_gasmix.gases
		multiplier = current_gasmix.volume/total_volume
		for(var/id in final_gases)
			current_gases[id] = final_gases[id] * multiplier
		current_gasmix.temperature = final_temperature
