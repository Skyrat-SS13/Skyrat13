/turf/open/floor/plastic
	name = "plastic floor"
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	icon_state = "white"
	floor_tile = /obj/item/stack/tile/plastic
/* Doesnt work dammit
/turf/open/floor/plastic/grate
	name = "plastic grate"
	icon_state = "grate"
	layer = ABOVE_PIPE_LAYER
	floor_tile = /obj/item/stack/tile/plasticgrate
*/
/turf/open/floor/plastic/plate
	name = "plastic plate"
	icon_state = "plate"
	floor_tile = /obj/item/stack/tile/plasticplate

/turf/open/floor/plating/plastic
	name = "plastic plating"
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	icon_state = "plating"

/turf/open/floor/engine/plastic
	name = "reinforced plastic floor"
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	icon_state = "whiteengine"
	thermal_conductivity = 1
	heat_capacity = 1
	floor_tile = /obj/item/stack/rods/plastic

/turf/open/floor/engine/plastic/wrench_act(mob/living/user, obj/item/I)
	to_chat(user, "<span class='notice'>You begin removing rods...</span>")
	if(I.use_tool(src, user, 30, volume=80))
		if(!istype(src, /turf/open/floor/engine))
			return TRUE
		if(floor_tile)
			new floor_tile(src, 2)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE

/turf/open/floor/plating/attackby(obj/item/C, mob/user, params)
	if(..())
		return
	if(istype(C, /obj/item/stack/rods) && attachment_holes)
		if(istype(C, /obj/item/stack/rods/plastic) && attachment_holes)
			if(broken || burnt)
				to_chat(user, "<span class='warning'>Repair the plating first!</span>")
				return
			var/obj/item/stack/rods/plastic/P = C
			if (P.get_amount() < 2)
				to_chat(user, "<span class='warning'>You need two sheets of plastic to make a reinforced plastic floor!</span>")
				return
			else
				to_chat(user, "<span class='notice'>You begin reinforcing the floor...</span>")
				if(do_after(user, 30, target = src))
					if (P.get_amount() >= 2 && !istype(src, /turf/open/floor/engine))
						PlaceOnTop(/turf/open/floor/engine/plastic, flags = CHANGETURF_INHERIT_AIR)
						playsound(src, 'sound/items/deconstruct.ogg', 80, 1)
						P.use(2)
						to_chat(user, "<span class='notice'>You reinforce the floor.</span>")
					return
		if(broken || burnt)
			to_chat(user, "<span class='warning'>Repair the plating first!</span>")
			return
		var/obj/item/stack/rods/R = C
		if (R.get_amount() < 2)
			to_chat(user, "<span class='warning'>You need two rods to make a reinforced floor!</span>")
			return
		else
			to_chat(user, "<span class='notice'>You begin reinforcing the floor...</span>")
			if(do_after(user, 30, target = src))
				if (R.get_amount() >= 2 && !istype(src, /turf/open/floor/engine))
					PlaceOnTop(/turf/open/floor/engine, flags = CHANGETURF_INHERIT_AIR)
					playsound(src, 'sound/items/deconstruct.ogg', 80, 1)
					R.use(2)
					to_chat(user, "<span class='notice'>You reinforce the floor.</span>")
				return
	else if(istype(C, /obj/item/stack/tile))
		if(!broken && !burnt)
			for(var/obj/O in src)
				if(O.level == 1) //ex. pipes laid underneath a tile
					for(var/M in O.buckled_mobs)
						to_chat(user, "<span class='warning'>Someone is buckled to \the [O]! Unbuckle [M] to move \him out of the way.</span>")
						return
			var/obj/item/stack/tile/W = C
			if(!W.use(1))
				return
			if(!istype(C, /obj/item/stack/plasticgrate)||!istype(C, /obj/item/stack/tile/plasticplate))
				var/turf/open/floor/T = PlaceOnTop(W.turf_type, flags = CHANGETURF_INHERIT_AIR)
				if(istype(W, /obj/item/stack/tile/light)) //TODO: get rid of this ugly check somehow
					var/obj/item/stack/tile/light/L = W
					var/turf/open/floor/light/F = T
					F.state = L.state
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
			else
		else
			to_chat(user, "<span class='warning'>This section is too damaged to support a tile! Use a welder to fix the damage.</span>")

	else if(istype(C, /obj/item/stack/plasticgrate))
		var/obj/structure/plasticgrate/GC = locate(/obj/structure/plasticgrate,src)
		var/obj/structure/plasticgrate/window/WC = locate(/obj/structure/plasticgrate/window,src)
		if(GC)
			to_chat(user, "<span class='warning'>This section already has something on it.</span>")
			return
		if(WC)
			to_chat(user, "<span class='warning'>This section already has something on it.</span>")
			return
		if(!broken && !burnt)
			for(var/obj/O in src)
				if(O.level == 1) //ex. pipes laid underneath a tile
					for(var/M in O.buckled_mobs)
						to_chat(user, "<span class='warning'>Someone is buckled to \the [O]! Unbuckle [M] to move \him out of the way.</span>")
						return
			var/obj/item/stack/plasticgrate/W = C
			if(!W.use(1))
				return
			if(!istype(W, /obj/item/stack/plasticgrate/windowfloor))
				new/obj/structure/plasticgrate(src)
			if(istype(W, /obj/item/stack/plasticgrate/windowfloor))
				new/obj/structure/plasticgrate/window(src)
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
		else
			to_chat(user, "<span class='warning'>This section is too damaged to support a tile! Use a welder to fix the damage.</span>")