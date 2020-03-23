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
	move_to_delay = 4
	projectiletype = /obj/item/projectile/magic/impfireball
	projectilesound = 'modular_skyrat/sound/misc/imp.wav'
	ranged = 1
	ranged_message = "shoots a fireball"
	ranged_cooldown_time = 70
	throw_message = "does nothing against the hardened skin of"
	vision_range = 5
	speed = 1
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
	robust_searching = FALSE
	death_sound = 'modular_skyrat/sound/misc/impdies.wav'

/obj/item/projectile/magic/impfireball //bobyot y u no use child of fireball
	name = "demonic fireball" //because it fucking explodes and deals brute damage even when values are set to -1
	icon_state = "fireball"
	damage = 10
	damage_type = BURN
	nodamage = 0
	armour_penetration = 20
	var/firestacks = 5

/obj/item/projectile/magic/impfireball/on_hit(target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.adjust_fire_stacks(firestacks)
		C.IgniteMob()