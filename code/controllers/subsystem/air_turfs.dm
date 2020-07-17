//WHAT IF WE TAKE THE ACTIVE TURF PROCESSING AND PUSH IT SOMEWHERE ELSE!!!

SUBSYSTEM_DEF(air_turfs)
	name = "Atmospherics - Turfs"
	init_order = INIT_ORDER_AIR_TURFS
	priority = FIRE_PRIORITY_AIR_TURFS
	wait = 2
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/currentrun = list()
	var/list/exempt_currentrun = list()

/datum/controller/subsystem/air_turfs/fire(resumed = 0)
	if (!resumed)
		src.currentrun = SSair.active_turfs.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	exempt_currentrun = list()
	while(currentrun.len)
		var/turf/open/T = currentrun[currentrun.len]
		currentrun.len--
		if (T)
			T.process_cell()
		if (MC_TICK_CHECK_LOW_PRIORITY)
			return
	resumed = 0
	return
