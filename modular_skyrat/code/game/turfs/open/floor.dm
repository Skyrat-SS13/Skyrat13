/turf/open/floor
	var/dirtiness = 0
	var/dirtiness_updating = 0
	var/update_dirt_steps = 15
	var/max_dirtiness = 150

//Dirtiness.
/turf/open/floor/Entered(atom/movable/AM)
	. = ..()
	if(istype(AM, /mob/living))
		dirtiness_updating++
		if(dirtiness_updating >= update_dirt_steps)
			update_dirtiness()
			dirtiness_updating = 0

/turf/open/floor/proc/update_dirtiness()
	dirtiness = 0
	for(var/obj/effect/decal/cleanable/cleanable)
		dirtiness += cleanable.dirtiness
		dirtiness += (cleanable.bloodiness/2)
	dirtiness = min(max_dirtiness, dirtiness)
