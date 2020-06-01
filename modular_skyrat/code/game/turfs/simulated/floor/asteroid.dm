#define SPAWN_MEGAFAUNA "bluh bluh huge boss"
#define SPAWN_BUBBLEGUM 6

//This list basically counts if we have reached the minimum quantity
//of every megafauna type that doesn't spawn with ruins.
GLOBAL_LIST_INIT(remaining_megas,\
	list(/mob/living/simple_animal/hostile/megafauna/dragon = 1,\
	/mob/living/simple_animal/hostile/megafauna/colossus = 1,\
	/mob/living/simple_animal/hostile/megafauna/bubblegum = 1))

//This list prevents spawning more than the associated amount
//of megafauna.
GLOBAL_LIST_INIT(cap_megas,\
	list(/mob/living/simple_animal/hostile/megafauna/dragon = 3,\
	/mob/living/simple_animal/hostile/megafauna/colossus = 3,\
	/mob/living/simple_animal/hostile/megafauna/bubblegum = 3))

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
	var/definite_boss = pick_n_take(GLOB.remaining_megas)
	var/shouldspawnboss = TRUE
	if(definite_boss)
		for(var/mob/living/simple_animal/hostile/megafauna/M in GLOB.mob_living_list)
			if(istype(M, definite_boss))
				shouldspawnboss = FALSE
		if(shouldspawnboss && A.megafauna_spawn_allowed && megafauna_spawn_list && megafauna_spawn_list.len)
			for(var/mob/living/simple_animal/hostile/H in urange(7,T)) //prevents megafauna from spawning too near to other megafauna
				if(ismegafauna(H) && get_dist(src, H) <= 7)
					GLOB.remaining_megas[definite_boss] += 1
					return FALSE
			new definite_boss(src)
			GLOB.remaining_megas[definite_boss] = max(0, GLOB.remaining_megas[definite_boss] - 1)
			return TRUE
	var/shouldspawnlegiontendril = TRUE
	for(var/obj/structure/spawner/lavaland/legion/L in GLOB.tendrils)
		shouldspawnlegiontendril = FALSE
	if(shouldspawnlegiontendril)
		for(var/obj/structure/spawner/lavaland/L in urange(12,T))
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
					var/count = 0
					for(var/mob/living/simple_animal/hostile/megafauna/M in GLOB.mob_living_list)
						if(istype(M, maybe_boss))
							count++
					if(count < GLOB.cap_megas[maybe_boss])
						randumb = maybe_boss
					else
						randumb = pickweight(mob_spawn_list)
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
