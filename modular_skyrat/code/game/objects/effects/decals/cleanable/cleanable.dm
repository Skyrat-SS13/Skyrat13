//Decals handle updating the dirtiness on a floor
/obj/effect/decal/cleanable/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	var/turf/open/floor/floor = get_turf(src)
	if(istype(floor))
		floor.update_dirtiness()

/obj/effect/decal/cleanable/Destroy(force)
	. = ..()
	var/turf/open/floor/floor = get_turf(src)
	if(istype(floor))
		floor.update_dirtiness()
