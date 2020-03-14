/turf/open/floor/plating/
	var/planet_light = FALSE

/turf/open/floor/plating/Initialize()
	. = ..()
	//planet light
	SSplanet_light.update_turf(src)