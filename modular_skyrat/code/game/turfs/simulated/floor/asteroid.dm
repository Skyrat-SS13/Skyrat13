#define SPAWN_MEGAFAUNA "bluh bluh huge boss"
#define SPAWN_BUBBLEGUM 6

/turf/open/floor/plating/asteroid/airless/cave/volcanic
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50, /obj/structure/spawner/lavaland/goliath = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random = 40, /obj/structure/spawner/lavaland = 2, \
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30, /obj/structure/spawner/lavaland/legion = 3, \
		/mob/living/simple_animal/hostile/asteroid/miner = 40, /obj/structure/spawner/lavaland/shamblingminer = 2, \
		/mob/living/simple_animal/hostile/asteroid/imp = 20, /obj/structure/spawner/lavaland/imp = 1, \
		SPAWN_MEGAFAUNA = 6, /mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
//imps are rare because boy they annoying

/turf/open/floor/plating/asteroid/airless/cave/proc/SpawnMonster(turf/T)
	if(!isarea(loc))
		return
	var/area/A = loc
	var/definite_boss = pickweight(megafauna_spawn_list)
	var/shouldspawnboss = TRUE
	for(var/mob/living/simple_animal/hostile/megafauna/M in GLOB.mob_living_list)
		if(definite_boss == M.type)
			shouldspawnboss = FALSE
	if(shouldspawnboss && A.megafauna_spawn_allowed && megafauna_spawn_list && megafauna_spawn_list.len)
		for(var/mob/living/simple_animal/hostile/H in urange(12,T)) //prevents megafauan from spawning too near to each other.
			if(ismegafauna(H) && get_dist(src, H) <= 7)
				return
		new definite_boss(src)
		return TRUE
	var/shouldspawnlegiontendril = TRUE
	for(var/obj/structure/spawner/lavaland/legion/L in GLOB.tendrils)
		shouldspawnlegiontendril = FALSE
	if(shouldspawnlegiontendril)
		for(var/obj/structure/spawner/lavaland/L in urange(12,T))
			if(istype(L, /obj/structure/spawner/lavaland) && (get_dist(src, L) <= 3))
				return //prevents tendrils spawning in each other's collapse range
		new /obj/structure/spawner/lavaland/legion(src)
		return TRUE
	if(prob(30))
		if(!A.mob_spawn_allowed)
			return
		var/randumb = pickweight(mob_spawn_list)
		if(!randumb)
			return
		while(randumb == SPAWN_MEGAFAUNA)
			if(A.megafauna_spawn_allowed && megafauna_spawn_list && megafauna_spawn_list.len) //this is danger. it's boss time.
				var/maybe_boss = pickweight(megafauna_spawn_list)
				if(megafauna_spawn_list[maybe_boss])
					randumb = maybe_boss
			else //this is not danger, don't spawn a boss, spawn something else
				randumb = pickweight(mob_spawn_list)

		for(var/mob/living/simple_animal/hostile/H in urange(12,T)) //prevents mob clumps
			if((ispath(randumb, /mob/living/simple_animal/hostile/megafauna) || ismegafauna(H)) && get_dist(src, H) <= 7)
				return //if there's a megafauna within standard view don't spawn anything at all
			if(ispath(randumb, /mob/living/simple_animal/hostile/asteroid) || istype(H, /mob/living/simple_animal/hostile/asteroid))
				return //if the random is a standard mob, avoid spawning if there's another one within 12 tiles
		if(ispath(randumb, /obj/structure/spawner/lavaland))
			for(var/obj/structure/spawner/lavaland/L in urange(12,T))
				return //prevents tendrils spawning in each other's collapse range

		new randumb(T)
	return TRUE
