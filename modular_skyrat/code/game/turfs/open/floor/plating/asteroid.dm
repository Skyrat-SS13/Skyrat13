#define SPAWN_MEGAFAUNA "bluh bluh huge boss"
#define SPAWN_BUBBLEGUM 6

/turf/open/floor/plating/asteroid/snow/atmosphere
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	digResult = /obj/item/stack/sheet/mineral/snow

/turf/open/lava/plasma/ice_moon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	baseturfs = /turf/open/lava/plasma/ice_moon
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/airless/cave/snow
	gender = PLURAL
	name = "snow"
	desc = "Looks cold."
	icon = 'modular_skyrat/icons/turf/snow.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	icon_state = "snow"
	icon_plating = "snow"
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	environment_type = "snow"
	flags_1 = NONE
	planetary_atmos = TRUE
	burnt_states = list("snow_dug")
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/sheet/mineral/snow
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/wolf = 50, /obj/structure/spawner/ice_moon = 3, \
						  /mob/living/simple_animal/hostile/asteroid/polarbear = 30, /obj/structure/spawner/ice_moon/polarbear = 3, \
						  /mob/living/simple_animal/hostile/asteroid/goldgrub = 10)

	megafauna_spawn_list = list()
	flora_spawn_list = list(/obj/structure/flora/tree/pine = 2, /obj/structure/flora/rock/icy = 2, /obj/structure/flora/rock/pile/icy = 2, /obj/structure/flora/grass/both = 12)
	data_having_type = /turf/open/floor/plating/asteroid/airless/cave/snow/has_data
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon

/turf/open/floor/plating/asteroid/airless/cave/snow/underground
	flora_spawn_list = list(/obj/structure/flora/rock/icy = 6, /obj/structure/flora/rock/pile/icy = 6)
	data_having_type = /turf/open/floor/plating/asteroid/airless/cave/snow/underground/has_data

/turf/open/floor/plating/asteroid/airless/cave/snow/has_data //subtype for producing a tunnel with given data
	has_data = TRUE

/turf/open/floor/plating/asteroid/airless/cave/snow/underground/has_data //subtype for producing a tunnel with given data
	has_data = TRUE

/turf/open/floor/plating/asteroid/airless/cave/snow/make_tunnel(dir, pick_tunnel_width)
	pick_tunnel_width = list("1" = 6, "2" = 1) // tunnel with 6/7 chance to be 1 tile wide and 1/7 chance to be 2 tiles wide
	..()

/turf/open/floor/plating/asteroid/airless/cave/make_tunnel(dir, pick_tunnel_width)
	var/turf/closed/mineral/tunnel = src
	var/next_angle = pick(45, -45)

	var/tunnel_width = 1
	if(pick_tunnel_width)
		tunnel_width = text2num(pickweight(pick_tunnel_width))

	for(var/i = 0; i < length; i++)
		if(!sanity)
			break

		var/list/L = list(45)
		if(ISODD(dir2angle(dir))) // We're going at an angle and we want thick angled tunnels.
			L += -45

		// Expand the edges of our tunnel
		for(var/edge_angle in L)
			var/turf/closed/mineral/edge = tunnel
			for(var/current_tunnel_width = 1 to tunnel_width)
				edge = get_step(edge, angle2dir(dir2angle(dir) + edge_angle))
				if(istype(edge))
					SpawnFloor(edge)

		if(!sanity)
			break

		// Move our tunnel forward
		tunnel = get_step(tunnel, dir)

		if(istype(tunnel))
			// Small chance to have forks in our tunnel; otherwise dig our tunnel.
			if(i > 3 && prob(20))
				if(isarea(tunnel.loc))
					var/area/A = tunnel.loc
					if(!A.tunnel_allowed)
						sanity = 0
						break
				var/turf/open/floor/plating/asteroid/airless/cave/C = tunnel.ChangeTurf(data_having_type, null, CHANGETURF_IGNORE_AIR)
				C.going_backwards = FALSE
				C.produce_tunnel_from_data(rand(10, 15), dir)
			else
				SpawnFloor(tunnel)
		else //if(!istype(tunnel, parent)) // We hit space/normal/wall, stop our tunnel.
			break

		// Chance to change our direction left or right.
		if(i > 2 && prob(33))
			// We can't go a full loop though
			next_angle = -next_angle
			setDir(angle2dir(dir2angle(dir) )+ next_angle)

/turf/open/floor/plating/asteroid/airless/cave/SpawnFloor(turf/T)
	for(var/S in RANGE_TURFS(1, src))
		var/turf/NT = S
		if(!NT)
			sanity = 0
			return
		if(isarea(NT.loc))
			var/area/A = NT.loc
			if(!A.tunnel_allowed)
				sanity = 0
				return
	if(is_mining_level(z))
		SpawnFlora(T)	//No space mushrooms, cacti.
	SpawnMonster(T)		//Checks for danger area.
	T.ChangeTurf(turf_type, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/asteroid/airless/cave/SpawnMonster(turf/T)
	if(!isarea(loc))
		return
	var/area/A = loc
	if(prob(30))
		if(!A.mob_spawn_allowed)
			return
		var/randumb = pickweight(mob_spawn_list)
		if(!mob_spawn_list)
			return
		if(!randumb)
			return
		while(randumb == SPAWN_MEGAFAUNA)
			if(A.megafauna_spawn_allowed) //this is danger. it's boss time.
				var/maybe_boss = pickweight(megafauna_spawn_list)
				if(megafauna_spawn_list[maybe_boss])
					randumb = maybe_boss
			else //this is not danger, don't spawn a boss, spawn something else
				randumb = pickweight(mob_spawn_list)

		for(var/thing in urange(12, T)) //prevents mob clumps
			if(!ishostile(thing) && !istype(thing, /obj/structure/spawner))
				continue
			if((ispath(randumb, /mob/living/simple_animal/hostile/megafauna) || ismegafauna(thing)) && get_dist(src, thing) <= 7)
				return //if there's a megafauna within standard view don't spawn anything at all
			if(ispath(randumb, /mob/living/simple_animal/hostile/asteroid) || istype(thing, /mob/living/simple_animal/hostile/asteroid))
				return //if the random is a standard mob, avoid spawning if there's another one within 12 tiles
			if((ispath(randumb, /obj/structure/spawner/lavaland) || istype(thing, /obj/structure/spawner/lavaland)) && get_dist(src, thing) <= 2)
				return //prevents tendrils spawning in each other's collapse range

		if(ispath(randumb, /mob/living/simple_animal/hostile/megafauna/bubblegum)) //there can be only one bubblegum, so don't waste spawns on it
			megafauna_spawn_list.Remove(randumb)

		if(randumb)
			new randumb(T)

/turf/open/floor/plating/asteroid/airless/cave/SpawnFlora(turf/T)
	if(prob(12))
		if(isarea(loc))
			var/area/A = loc
			if(!A.flora_allowed)
				return
		var/randumb = pickweight(flora_spawn_list)
		for(var/obj/structure/flora/F in range(4, T)) //Allows for growing patches, but not ridiculous stacks of flora
			if(!istype(F, randumb))
				return
		new randumb(T)

#undef SPAWN_MEGAFAUNA
#undef SPAWN_BUBBLEGUM