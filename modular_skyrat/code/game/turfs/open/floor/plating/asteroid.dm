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
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50, /obj/structure/spawner/lavaland/goliath = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random = 10, /obj/structure/spawner/lavaland/icewatcher = 2, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 30, \
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30, /obj/structure/spawner/lavaland/legion = 3, \
		SPAWN_MEGAFAUNA = 4, /mob/living/simple_animal/hostile/asteroid/goldgrub = 10)

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

	var/tunnel_width = 2
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

#undef SPAWN_MEGAFAUNA
#undef SPAWN_BUBBLEGUM