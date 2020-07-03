SUBSYSTEM_DEF(planetatmos)
	name = "Atmospherics - Planetary"
	init_order = INIT_ORDER_AIR_TURFS_PLANETARY
	priority = FIRE_PRIORITY_AIR_TURFS_PLANETARY
	wait = 5
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/currentrun = list()

/datum/controller/subsystem/planetatmos/fire()
	//var/list/currentrun = src.currentrun.Copy()
	var/turf/open/current_turf
	while(currentrun.len)
		current_turf = currentrun[currentrun.len]
		currentrun.len--
		if(current_turf)
			current_turf.handle_planet_atmos()
		if (MC_TICK_CHECK)
			return
	return
