/obj/structure/spawner/lavaland
	max_integrity = 350

/obj/structure/spawner/lavaland/Initialize()
	. = ..()
	if(prob(20))
		max_integrity *= 2
		max_mobs *= 2
		name = "strong [name]"
		chest_type = /obj/structure/closet/crate/necropolis/tendril/legion_loot

/obj/structure/spawner/lavaland/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	var/list/possible_targets = list()
	var/list/thralls = list()
	var/mob/living/target
	for(var/mob/living/C in view(7, src))
		if(iscarbon(C))
			possible_targets += C
		else if(istype(C, /mob/living/simple_animal/hostile/asteroid))
			thralls += C
	if(length(possible_targets))
		target = pick(possible_targets)
		for(var/mob/living/simple_animal/hostile/asteroid/ass in thralls)
			ass.GiveTarget(target)

/obj/structure/spawner/lavaland/shamblingminer
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/miner)

/obj/structure/spawner/lavaland/imp
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/imp)

/obj/structure/spawner/lavaland/icewatcher
	mob_types = list(/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing)
