/turf/open/floor
	icon = 'modular_skyrat/icons/eris/turf/floors.dmi'

/turf/open/floor/material
	icon = 'modular_skyrat/icons/eris/turf/floors.dmi'

/turf/open/floor/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 20, "cost" = 16)
		if(RCD_AIRLOCK)
			if(the_rcd.airlock_glass)
				return list("mode" = RCD_AIRLOCK, "delay" = 50, "cost" = 20)
			else
				return list("mode" = RCD_AIRLOCK, "delay" = 50, "cost" = 16)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 50, "cost" = 33)
		if(RCD_WINDOWGRILLE)
			return list("mode" = RCD_WINDOWGRILLE, "delay" = 10, "cost" = 4)
		if(RCD_LOWWALL)
			return list("mode" = RCD_LOWWALL, "delay" = 20, "cost" = 6)
		if(RCD_MACHINE)
			return list("mode" = RCD_MACHINE, "delay" = 20, "cost" = 25)
		if(RCD_COMPUTER)
			return list("mode" = RCD_COMPUTER, "delay" = 20, "cost" = 25)
	return FALSE

/turf/open/floor/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, "<span class='notice'>You build a wall.</span>")
			PlaceOnTop(/turf/closed/wall)
			return TRUE
		if(RCD_AIRLOCK)
			if(locate(/obj/machinery/door/airlock) in src)
				return FALSE
			to_chat(user, "<span class='notice'>You build an airlock.</span>")
			var/obj/machinery/door/airlock/A = new the_rcd.airlock_type(src)

			A.electronics = new/obj/item/electronics/airlock(A)

			if(the_rcd.conf_access)
				A.electronics.accesses = the_rcd.conf_access.Copy()
			A.electronics.one_access = the_rcd.use_one_access

			if(A.electronics.one_access)
				A.req_one_access = A.electronics.accesses
			else
				A.req_access = A.electronics.accesses
			A.autoclose = TRUE
			return TRUE
		if(RCD_DECONSTRUCT)
			if(!ScrapeAway(flags = CHANGETURF_INHERIT_AIR))
				return FALSE
			to_chat(user, "<span class='notice'>You deconstruct [src].</span>")
			return TRUE
		if(RCD_WINDOWGRILLE)
			if(locate(/obj/structure/grille) in src)
				return FALSE
			to_chat(user, "<span class='notice'>You construct the grille.</span>")
			var/obj/structure/grille/G = new(src)
			G.anchored = TRUE
			return TRUE
		if(RCD_LOWWALL)
			if(RCD_LOWWALL)
			if(locate(/obj/structure/table/low_wall) in src)
				return FALSE
			var/obj/structure/table/low_wall/metal/L = new the_rcd.lowwalltype(src)
			L.anchored = TRUE
			to_chat(user, "<span class='notice'>You construct \the [L].</span>")
			return TRUE
		if(RCD_MACHINE)
			if(locate(/obj/structure/frame/machine) in src)
				return FALSE
			var/obj/structure/frame/machine/M = new(src)
			M.state = 2
			M.icon_state = "box_1"
			M.anchored = TRUE
			return TRUE
		if(RCD_COMPUTER)
			if(locate(/obj/structure/frame/computer) in src)
				return FALSE
			var/obj/structure/frame/computer/C = new(src)
			C.anchored = TRUE
			C.setDir(the_rcd.computer_dir)
			return TRUE

	return FALSE
