//directional airlock funnies
/obj/machinery/door
	var/static/list/directional_with = list(/turf/closed, /obj/machinery/door)

/obj/machinery/door/Initialize()
	. = ..()
	dir = find_dir()

//proc to find the dir we should face
/obj/machinery/door/proc/find_dir()
	//face south by default
	. = SOUTH

	//holy shit this is some real cumcode
	for(var/typepath in directional_with)
		//No need to check west and east, because we face south (which is the same as north) by default
		if(locate(typepath) in get_step(src, NORTH))
			return EAST
		else if(locate(typepath) in get_step(src, SOUTH))
			return WEST
