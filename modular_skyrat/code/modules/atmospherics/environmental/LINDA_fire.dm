/turf/open/hotspot_expose(exposed_temperature, exposed_volume, soh)
	var/datum/gas_mixture/air_contents = return_air()
	if(!air_contents)
		return 0

	var/oxy = air_contents.gases[/datum/gas/oxygen]
	if(oxy < 0.5)
		return 0
	var/tox = air_contents.gases[/datum/gas/plasma]
	var/trit = air_contents.gases[/datum/gas/tritium]
	if(active_hotspot)
		if(soh)
			if(tox > 0.5 || trit > 0.5)
				if(active_hotspot.temperature < exposed_temperature*35)
					active_hotspot.temperature = exposed_temperature*35
				if(active_hotspot.volume < exposed_volume)
					active_hotspot.volume = exposed_volume
		return 1

	if((exposed_temperature > PLASMA_MINIMUM_BURN_TEMPERATURE) && (tox > 0.5 || trit > 0.5))
		active_hotspot = new /obj/effect/hotspot(src)
		active_hotspot.temperature = exposed_temperature*35
		active_hotspot.volume = exposed_volume*25

		active_hotspot.just_spawned = (current_cycle < SSair.times_fired)
			//remove just_spawned protection if no longer processing this cell
		SSair.add_to_active(src, 0)
		return 1
	return 0