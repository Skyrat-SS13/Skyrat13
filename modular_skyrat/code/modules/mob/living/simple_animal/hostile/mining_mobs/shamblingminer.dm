//A slow, melee crazy miner.
/mob/living/simple_animal/hostile/asteroid/miner
	name = "shambling miner"
	desc = "Consumed by the ash storm, this shell of a human being only seeks to harm those he once called coworkers."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "miner"
	icon_living = "miner"
	icon_aggro = "miner"
	icon_dead = "miner_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	move_to_delay = 3
	ranged = 1
	ranged_cooldown_time = 60
	friendly = "hugs"
	speak_emote = list("moans")
	speed = 1
	move_to_delay = 1
	maxHealth = 200
	health = 200
	obj_damage = 100
	melee_damage_lower = 25
	melee_damage_upper = 25
	attacktext = "smashes"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	throw_message = "barely affects the"
	vision_range = 2
	aggro_vision_range = 5
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	loot = /obj/item/twohanded/kinetic_crusher
	crusher_loot = /obj/item/crusher_trophy/blaster_tubes/eye
	do_footstep = TRUE
	anchored = TRUE
	minimum_distance = 0
	var/obj/item/twohanded/kinetic_crusher/minercrusher

/mob/living/simple_animal/hostile/asteroid/miner/OpenFire()
	if(get_dist(src, target) <= 1)
		AttackingTarget(target)

/mob/living/simple_animal/hostile/asteroid/miner/AttackingTarget(target)
	do_attack_animation(target)
	..()

mob/living/simple_animal/hostile/asteroid/miner/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!used_item && !isturf(A))
		used_item = minercrusher
		new /obj/effect/temp_visual/kinetic_blast(A)
	..()