#define SPAWN_MEGAFAUNA "bluh bluh huge boss"
#define SPAWN_BUBBLEGUM 6

/turf/open/floor/plating/asteroid/airless/cave
	var/list/terrain_spawn_list

/turf/open/floor/plating/asteroid/airless/cave/Initialize()
	if (!mob_spawn_list)
		mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goldgrub = 1, /mob/living/simple_animal/hostile/asteroid/goliath = 5, /mob/living/simple_animal/hostile/asteroid/basilisk = 4, /mob/living/simple_animal/hostile/asteroid/hivelord = 3)
	if (!megafauna_spawn_list)
		megafauna_spawn_list = GLOB.megafauna_spawn_list
	if (!flora_spawn_list)
		flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2)
	if(!terrain_spawn_list)
		terrain_spawn_list = list(/obj/structure/geyser/random = 1)
	. = ..()
	if(!has_data)
		produce_tunnel_from_data()

/turf/open/floor/plating/asteroid/airless/cave/SpawnFloor(turf/T)
	for(var/S in RANGE_TURFS(1, src))
		var/turf/NT = S
		if(!NT || isspaceturf(NT) || istype(NT.loc, /area/mine/explored) || (istype(NT.loc, /area/lavaland/surface/outdoors) && !istype(NT.loc, /area/lavaland/surface/outdoors/unexplored)))
			sanity = 0
			break
	if(!sanity)
		return
	if(is_mining_level(z))
		SpawnFlora(T)	//No space mushrooms, cacti.
	SpawnTerrain(T)
	SpawnMonster(T)		//Checks for danger area.
	T.ChangeTurf(turf_type, null, CHANGETURF_IGNORE_AIR)

/turf/open/floor/plating/asteroid/airless/cave/volcanic
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50, /obj/structure/spawner/lavaland/goliath = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random = 40, /obj/structure/spawner/lavaland = 2, \
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30, /obj/structure/spawner/lavaland/legion = 3, \
		/mob/living/simple_animal/hostile/asteroid/miner = 40, /obj/structure/spawner/lavaland/shamblingminer = 2, \
		/mob/living/simple_animal/hostile/asteroid/imp = 20, /obj/structure/spawner/lavaland/imp = 1, \
		SPAWN_MEGAFAUNA = 6, /mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
//imps are rare because boy they annoying
