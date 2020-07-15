#define EXT_BOUND	1
#define INT_BOUND	2
#define NO_BOUND	3

#define SIPHONING	0
#define RELEASING	1


/obj/machinery/atmospherics/components/unary/vent_pump/process_atmos()
	..()
	if(!is_operational())
		return
	if(!nodes[1])
		on = FALSE
	if(!on || welded)
		return

	var/datum/gas_mixture/air_contents = airs[1]
	var/datum/gas_mixture/environment = loc.return_air()
	var/environment_pressure = environment.return_pressure()

	if(pump_direction & RELEASING) // internal -> external
		var/pressure_delta = 10000

		if(pressure_checks&EXT_BOUND)
			pressure_delta = min(pressure_delta, (external_pressure_bound - environment_pressure))
		if(pressure_checks&INT_BOUND)
			pressure_delta = min(pressure_delta, (air_contents.return_pressure() - internal_pressure_bound))

		if(pressure_delta > 0)
			if(air_contents.temperature > 0)
				var/transfer_moles = pressure_delta*environment.volume/(air_contents.temperature * R_IDEAL_GAS_EQUATION)

				var/datum/gas_mixture/removed = air_contents.remove(transfer_moles)

				loc.assume_air(removed)
				air_update_turf()
				update_parents()

	else // external -> internal
		var/pressure_delta = 10000
		if(pressure_checks&EXT_BOUND)
			pressure_delta = min(pressure_delta, (environment_pressure - external_pressure_bound))
		if(pressure_checks&INT_BOUND)
			pressure_delta = min(pressure_delta, (internal_pressure_bound - air_contents.return_pressure()))

		if(pressure_delta > 0 && environment.temperature > 0)
			var/transfer_moles = pressure_delta * air_contents.volume / (environment.temperature * R_IDEAL_GAS_EQUATION)

			var/datum/gas_mixture/removed = loc.remove_air(transfer_moles)
			if (isnull(removed)) // in space
				return

			air_contents.merge(removed)
			air_update_turf()
			update_parents()

#undef INT_BOUND
#undef EXT_BOUND
#undef NO_BOUND

#undef SIPHONING
#undef RELEASING
