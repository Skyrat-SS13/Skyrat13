//A speedy, annoying and scaredy demon
/mob/living/simple_animal/hostile/asteroid/imp
	name = "lava imp"
	desc = "Lowest on the hierarchy of slaughter demons, this one is still nothing to sneer at."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "imp"
	icon_living = "imp"
	icon_aggro = "imp"
	icon_dead = "imp_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	move_to_delay = 2
	projectiletype = /obj/item/projectile/magic/aoe/impfireball
	projectilesound = 'modular_skyrat/sound/misc/imp.wav'
	ranged = 1
	ranged_message = "shoots a fireball"
	ranged_cooldown_time = 35
	throw_message = "does nothing against the hardened skin of"
	vision_range = 5
	speed = -1
	maxHealth = 150
	health = 150
	harm_intent_damage = 15
	obj_damage = 60
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "claws"
	a_intent = INTENT_HARM
	speak_emote = list("groans")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	aggro_vision_range = 15
	retreat_distance = 5
	gold_core_spawnable = HOSTILE_SPAWN
	crusher_loot = /obj/item/crusher_trophy/blaster_tubes/impskull
	loot = list()
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/bone = 3, /obj/item/stack/sheet/sinew = 2)
	robust_searching = TRUE
	death_sound = 'modular_skyrat/sound/misc/impdies.wav'

/obj/item/projectile/magic/aoe/impfireball //bobyot y u no use child of fireball
	name = "demonic fireball" //because if i do, the on_hit proc will call the parent and fuck shit up ok
	icon_state = "fireball"
	damage = 10
	damage_type = BURN
	nodamage = 0

	//explosion values
	var/exp_heavy = -1
	var/exp_light = -1
	var/exp_flash = -1
	var/exp_fire = 2

/obj/item/projectile/magic/aoe/impfireball/on_hit(target)
	. = ..()
	var/turf/T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire) //so demonic there is no anti-magic blocking it