/datum/mapGeneratorModule/splatterLayer/dungeonMonsters
	spawnableTurfs = list()
	spawnableAtoms = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 10,
	/mob/living/simple_animal/hostile/asteroid/hivelord/legion/advanced = 10,
	/mob/living/simple_animal/hostile/big_legion = 5,
	/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/magmawing = 10,
	/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 10)

/datum/mapGeneratorModule/splatterLayer/dungeonTendrils
	spawnableTurfs = list()
	spawnableAtoms = list(/obj/structure/spawner/lavaland/alltypes = 5,
	/obj/structure/spawner/lavaland/advancedlegion = 5,
	/obj/structure/spawner/lavaland/ancientgoliath = 5,
	/obj/structure/spawner/lavaland/shamblingminer = 5,
	/obj/structure/spawner/lavaland/magmawing= 5,
	/obj/structure/spawner/lavaland/icewing = 5,
	/obj/structure/elite_tumor/priest = 1,
	/obj/structure/elite_tumor = 5)

/datum/mapGenerator/dungeon/ground_only
	modules = list(/datum/mapGeneratorModule/bottomLayer/dungeon_default)
	buildmode_name = "Block: Lavaland Floor"

/datum/mapGenerator/dungeon/dense_ores
	modules = list(/datum/mapGeneratorModule/bottomLayer/dungeon_mineral/dense)
	buildmode_name = "Block: Lavaland Ores: Dense"

/datum/mapGenerator/dungeon/normal_ores
	modules = list(/datum/mapGeneratorModule/bottomLayer/dungeon_mineral)
	buildmode_name = "Block: Lavaland Ores"
