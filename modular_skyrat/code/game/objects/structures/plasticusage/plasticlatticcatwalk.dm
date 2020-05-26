/obj/structure/lattice/plastic
	name = "plastic lattice"
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticlattice.dmi'
	icon_state = "lattice"

/obj/structure/lattice/catwalk/plastic
	name = "plastic catwalk"
	desc = "A catwalk for easier EVA maneuvering and cable placement."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticcatwalk.dmi'
	icon_state = "catwalk"

/obj/structure/plasticgrate
	name = "plastic grate"
	desc = "A plastic grate, used for walking on."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	icon_state = "grate"
	plane = FLOOR_PLANE
	layer = GRATE_LAYER
	obj_flags = CAN_BE_HIT | BLOCK_Z_FALL
	density = FALSE
	anchored = TRUE

/obj/structure/plasticgrate/window
	name = "plastic window floor"
	desc = "A plastic window, used for walking on."
	icon_state = "windowfloor"

// DECONSTRUCT LATTICE
/obj/structure/lattice/plastic/attackby(obj/item/C, mob/user, params)
	if(resistance_flags & INDESTRUCTIBLE)
		return
	if(istype(C, /obj/item/wirecutters))
		to_chat(user, "<span class='notice'>Slicing [name] joints ...</span>")
		deconstruct()
	else
		var/turf/T = get_turf(src)
		return T.attackby(C, user) //hand this off to the turf instead (for building plating, catwalks, etc)

/obj/structure/lattice/plastic/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/rods/plastic(get_turf(src), number_of_rods)
	qdel(src)

// DECONSTRUCT CATWALKS
/obj/structure/lattice/catwalk/plastic/attackby(obj/item/C, mob/user, params)
	if(resistance_flags & INDESTRUCTIBLE)
		return
	if(istype(C, /obj/item/wirecutters))
		to_chat(user, "<span class='notice'>Slicing [name] joints ...</span>")
		deconstruct()
	else
		var/turf/T = get_turf(src)
		return T.attackby(C, user) //hand this off to the turf instead (for building plating, catwalks, etc)

/obj/structure/lattice/catwalk/plastic/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/rods/plastic(get_turf(src), number_of_rods)
	qdel(src)

// DECONSTRUCT GRATES
/obj/structure/plasticgrate/attackby(obj/item/C, mob/user, params)
	if(resistance_flags & INDESTRUCTIBLE)
		return
	if(istype(C, /obj/item/crowbar))
		to_chat(user, "<span class='notice'>Prying [name] joints ...</span>")
		deconstruct()
	else
		var/turf/T = get_turf(src)
		return T.attackby(C, user) //hand this off to the turf instead (for building plating, catwalks, etc)

/obj/structure/plasticgrate/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/plasticgrate(get_turf(src), 1)
	qdel(src)

// DECONSTRUCT WINDOWFLOORS
/obj/structure/plasticgrate/window/attackby(obj/item/C, mob/user, params)
	if(resistance_flags & INDESTRUCTIBLE)
		return
	if(istype(C, /obj/item/crowbar))
		to_chat(user, "<span class='notice'>Prying [name] joints ...</span>")
		deconstruct()
	else
		var/turf/T = get_turf(src)
		return T.attackby(C, user) //hand this off to the turf instead (for building plating, catwalks, etc)

/obj/structure/plasticgrate/window/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/plasticgrate/windowfloor(get_turf(src), 1)
	qdel(src)


/turf/open/space/attackby(obj/item/C, mob/user, params)
	..()
	if(!CanBuildHere())
		return
	if(istype(C, /obj/item/stack/rods/plastic))
		var/obj/item/stack/rods/plastic/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		var/obj/structure/lattice/catwalk/W = locate(/obj/structure/lattice/catwalk, src)
		if(W)
			to_chat(user, "<span class='warning'>There is already a catwalk here!</span>")
			return
		if(L)
			if(R.use(1))
				to_chat(user, "<span class='notice'>You construct a catwalk.</span>")
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				new/obj/structure/lattice/catwalk/plastic(src)
			else
				to_chat(user, "<span class='warning'>You need two rods to build a catwalk!</span>")
			return
		if(R.use(1))
			to_chat(user, "<span class='notice'>You construct a lattice.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
			ReplaceWithPLattice()
		else
			to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
		return
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		var/obj/structure/lattice/catwalk/W = locate(/obj/structure/lattice/catwalk, src)
		if(W)
			to_chat(user, "<span class='warning'>There is already a catwalk here!</span>")
			return
		if(L)
			if(R.use(1))
				to_chat(user, "<span class='notice'>You construct a catwalk.</span>")
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				new/obj/structure/lattice/catwalk(src)
			else
				to_chat(user, "<span class='warning'>You need two rods to build a catwalk!</span>")
			return
		if(R.use(1))
			to_chat(user, "<span class='notice'>You construct a lattice.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
			ReplaceWithLattice()
		else
			to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
		return
	if(istype(C, /obj/item/stack/tile/plasteel))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plasteel/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You build a floor.</span>")
				PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			else
				to_chat(user, "<span class='warning'>You need one floor tile to build a floor!</span>")
		else
			to_chat(user, "<span class='warning'>The plating is going to need some support! Place metal rods first.</span>")
	if(istype(C, /obj/item/stack/tile/plastic))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/plastic/S = C
			if(S.use(1))
				qdel(L)
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You build a floor.</span>")
				PlaceOnTop(/turf/open/floor/plating/plastic, flags = CHANGETURF_INHERIT_AIR)
			else
				to_chat(user, "<span class='warning'>You need one floor tile to build a floor!</span>")
		else
			to_chat(user, "<span class='warning'>The plating is going to need some support! Place metal rods first.</span>")
	if(istype(C, /obj/item/stack/plasticgrate))
		var/obj/item/stack/plasticgrate/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		var/obj/structure/lattice/catwalk/W = locate(/obj/structure/lattice/catwalk, src)
		var/obj/structure/plasticgrate/P = locate(/obj/structure/plasticgrate, src)
		if(P)
			to_chat(user, "<span class='warning'>There is already a grate here!</span>")
			return
		if(L)
			if(R.use(1))
				to_chat(user, "<span class='notice'>You construct a grate.</span>")
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				if(istype(C, /obj/item/stack/plasticgrate && !istype(C, /obj/item/stack/plasticgrate/windowfloor)))
					new/obj/structure/plasticgrate(src)
				if(istype(C, /obj/item/stack/plasticgrate/windowfloor))
					new/obj/structure/plasticgrate/window(src)
			else
				to_chat(user, "<span class='warning'>You need a plastic grate to build a grate!</span>")
			return
		if(W)
			if(R.use(1))
				to_chat(user, "<span class='notice'>You construct a grate.</span>")
				playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
				if(istype(C, /obj/item/stack/plasticgrate && !istype(C, /obj/item/stack/plasticgrate/windowfloor)))
					new/obj/structure/plasticgrate(src)
				if(istype(C, /obj/item/stack/plasticgrate/windowfloor))
					new/obj/structure/plasticgrate/window(src)
			else
				to_chat(user, "<span class='warning'>You need a plastic grate to build a grate!</span>")
			return
		if(R.use(1))
			to_chat(user, "<span class='notice'>You construct a grate.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
			if(istype(C, /obj/item/stack/plasticgrate && !istype(C, /obj/item/stack/plasticgrate/windowfloor)))
				ReplaceWithPGrate()
			if(istype(C, /obj/item/stack/plasticgrate/windowfloor))
				ReplaceWithPWF()
		else
			to_chat(user, "<span class='warning'>You need one grate to build a grate.</span>")
		return

/turf/proc/ReplaceWithPLattice()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	new /obj/structure/lattice/plastic(locate(x, y, z))

/turf/proc/ReplaceWithPGrate()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	new /obj/structure/plasticgrate(locate(x, y, z))

/turf/proc/ReplaceWithPWF()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	new /obj/structure/plasticgrate/window(locate(x, y, z))