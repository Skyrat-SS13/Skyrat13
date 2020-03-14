SUBSYSTEM_DEF(planet_light)
	name = "Planet Light"
	wait = 600
	flags = SS_NO_TICK_CHECK

	var/active = FALSE
	var/overriden = FALSE
	var/light_active = ""
	var/morning_start_time = 234000		//6:30 station time
	var/day_start_time = 450000		//12:30 station time
	var/evening_start_time = 630000		//17:30 station time
	var/night_start_time = 738000		//20:30 station time
	var/planet_light_first_check = 30 SECONDS

/datum/controller/subsystem/planet_light/Initialize()
	if(SSmapping.config.map_name != "Snow Box Station")
		can_fire = FALSE
	return ..()

/datum/controller/subsystem/planet_light/fire(resumed = FALSE)
	if(world.time - SSticker.round_start_time < planet_light_first_check)
		return
	check_planet_light()

/datum/controller/subsystem/planet_light/proc/check_planet_light()
	if(overriden)
		return
	if(!active)
		active = TRUE
	var/det_light = ""
	var/time = STATION_TIME(FALSE, world.time)

	if (time >= morning_start_time && time < day_start_time)
		//Morning
		det_light = PLANET_LIGHT_MORNING
	else if (time >= day_start_time && time < evening_start_time)
		//Mid-day
		det_light = PLANET_LIGHT_DAY
	else if (time >= evening_start_time && time < night_start_time)
		//Evening
		det_light = PLANET_LIGHT_EVENING
	else
		//Night
		det_light = PLANET_LIGHT_NIGHT

	if(det_light != light_active)
		light_active = det_light
		set_planet_light(det_light)

/datum/controller/subsystem/planet_light/proc/set_planet_light(light_string)
	var/list/params = params2list(light_string)
	for(var/turf/open/floor/plating/T in world)
		if(T.z == 2)
			var/area/ar = get_area(T)
			if (ar.outdoors == TRUE && ((T.planet_light == TRUE || (T.light_range == 0 && T.planet_light == FALSE))))
				T.planet_light = TRUE
				T.light_power = text2num(params["power"])
				T.light_range = text2num(params["range"])
				T.light_color = params["color"]
				T.update_light() //Maybe run another loop to update the light once it's all set?

/datum/controller/subsystem/planet_light/proc/update_turf(var/turf/open/floor/plating/T)
	if(!active) //This is so random terrain generation doesn't chuck this system on roundstart
		return
	if(!can_fire)
		return
	if(light_active == "")
		return
	var/list/params = params2list(light_active)
	if(T.z == 2)
		var/area/ar = get_area(T)
		if(ar.outdoors == TRUE && ((T.planet_light == TRUE || (T.light_range == 0 && T.planet_light == FALSE))))
			T.planet_light = TRUE
			T.light_power = text2num(params["power"])
			T.light_range = text2num(params["range"])
			T.light_color = params["color"]
			T.update_light()