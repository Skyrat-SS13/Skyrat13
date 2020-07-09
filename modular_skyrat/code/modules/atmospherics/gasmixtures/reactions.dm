/datum/gas_reaction/tritfire/react(datum/gas_mixture/air, datum/holder)
	var/old_heat_capacity = air.heat_capacity()
	var/list/cached_gases = air.gases //this speeds things up because accessing datum vars is slow
	var/temperature = air.temperature
	var/list/cached_results = air.reaction_results
	cached_results["fire"] = 0
	var/turf/open/location = isturf(holder) ? holder : null

	var/burned_fuel = 0
	if(cached_gases[/datum/gas/oxygen] < cached_gases[/datum/gas/tritium])
		burned_fuel = cached_gases[/datum/gas/oxygen]/TRITIUM_BURN_OXY_FACTOR
		cached_gases[/datum/gas/tritium] -= burned_fuel
	else
		burned_fuel = cached_gases[/datum/gas/tritium]*TRITIUM_BURN_TRIT_FACTOR
		cached_gases[/datum/gas/tritium] -= cached_gases[/datum/gas/tritium]/TRITIUM_BURN_TRIT_FACTOR
		cached_gases[/datum/gas/oxygen] -= cached_gases[/datum/gas/tritium]

	if(burned_fuel)
		var/thermal_energy = old_heat_capacity * temperature
		var/radiation_energy = burned_fuel*TRITIUM_RELEASE_ENERGY
		if(location && prob(10) && burned_fuel > TRITIUM_MINIMUM_RADIATION_ENERGY) //woah there let's not crash the server
			radiation_pulse(location, radiation_energy/TRITIUM_RADIOACTIVE_PULSE_COEFF)

		cached_gases[/datum/gas/water_vapor] += burned_fuel/TRITIUM_BURN_OXY_FACTOR

		cached_results["fire"] += burned_fuel

		var/new_heat_capacity = air.heat_capacity()
		air.temperature = (thermal_energy+radiation_energy)/new_heat_capacity

	//let the floor know a fire is happening
	if(istype(location))
		temperature = air.temperature
		if(temperature > FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
			location.hotspot_expose(temperature, CELL_VOLUME)
			for(var/I in location)
				var/atom/movable/item = I
				item.temperature_expose(air, temperature, CELL_VOLUME)
			location.temperature_expose(air, temperature, CELL_VOLUME)

	return cached_results["fire"] ? REACTING : NO_REACTION

/datum/gas_reaction/plasmafire/react(datum/gas_mixture/air, datum/holder)
	var/old_heat_capacity = air.heat_capacity()
	var/list/cached_gases = air.gases //this speeds things up because accessing datum vars is slow
	var/temperature = air.temperature
	var/list/cached_results = air.reaction_results
	cached_results["fire"] = 0
	var/turf/open/location = isturf(holder) ? holder : null

	//Handle plasma burning
	var/plasma_burn_rate = 0
	var/oxygen_burn_rate = 0
	//more plasma released at higher temperatures
	var/temperature_scale = 0
	//to make tritium
	var/super_saturation = FALSE

	if(temperature > PLASMA_UPPER_TEMPERATURE)
		temperature_scale = 1
	else
		temperature_scale = (temperature-PLASMA_MINIMUM_BURN_TEMPERATURE)/(PLASMA_UPPER_TEMPERATURE-PLASMA_MINIMUM_BURN_TEMPERATURE)
	if(temperature_scale > 0)
		oxygen_burn_rate = OXYGEN_BURN_RATE_BASE - temperature_scale
		if(cached_gases[/datum/gas/oxygen] / cached_gases[/datum/gas/plasma] > SUPER_SATURATION_THRESHOLD) //supersaturation. Form Tritium.
			super_saturation = TRUE
		if(cached_gases[/datum/gas/oxygen] > cached_gases[/datum/gas/plasma]*PLASMA_OXYGEN_FULLBURN)
			plasma_burn_rate = (cached_gases[/datum/gas/plasma]*temperature_scale)/PLASMA_BURN_RATE_DELTA
		else
			plasma_burn_rate = (temperature_scale*(cached_gases[/datum/gas/oxygen]/PLASMA_OXYGEN_FULLBURN))/PLASMA_BURN_RATE_DELTA

		if(plasma_burn_rate > MINIMUM_HEAT_CAPACITY)
			var/thermal_energy = air.temperature * old_heat_capacity

			plasma_burn_rate = min(plasma_burn_rate,cached_gases[/datum/gas/plasma],cached_gases[/datum/gas/oxygen]/oxygen_burn_rate) //Ensures matter is conserved properly
			cached_gases[/datum/gas/plasma] = QUANTIZE(cached_gases[/datum/gas/plasma] - plasma_burn_rate)
			cached_gases[/datum/gas/oxygen] = QUANTIZE(cached_gases[/datum/gas/oxygen] - (plasma_burn_rate * oxygen_burn_rate))
			if (super_saturation)
				cached_gases[/datum/gas/tritium] += plasma_burn_rate
			else
				cached_gases[/datum/gas/carbon_dioxide] += plasma_burn_rate

			//energy_released += FIRE_PLASMA_ENERGY_RELEASED * (plasma_burn_rate)

			cached_results["fire"] += (plasma_burn_rate)*(1+oxygen_burn_rate)

			var/new_heat_capacity = air.heat_capacity()
			if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
				air.temperature = (thermal_energy+(PLASMA_RELEASE_ENERGY*plasma_burn_rate))/new_heat_capacity

	//let the floor know a fire is happening
	if(istype(location))
		temperature = air.temperature
		if(temperature > FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
			location.hotspot_expose(temperature, CELL_VOLUME)
			for(var/I in location)
				var/atom/movable/item = I
				item.temperature_expose(air, temperature, CELL_VOLUME)
			location.temperature_expose(air, temperature, CELL_VOLUME)

	return cached_results["fire"] ? REACTING : NO_REACTION
