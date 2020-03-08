/mob/living/simple_animal/hostile/asteroid/hivelord/creeper
	name = "creeper"
	desc = "Aw man."
	icon = 'modular_skyrat/icons/mob/minecraft/minecraft.dmi'
	icon_state = "creeper"
	icon_living = "creeper"
	icon_aggro = "creeper"
	icon_dead = "creeper_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	move_to_delay = 10
	ranged = 0
	vision_range = 4
	aggro_vision_range = 7
	speed = 1
	maxHealth = 75
	health = 75
	harm_intent_damage = 5
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext = "lashes out at"
	speak_emote = list("hisses")
	attack_sound = 'modular_skyrat/sound/minecraft/gravel.ogg'
	throw_message = "aww mans"
	ranged_cooldown = 0
	ranged_cooldown_time = 100
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 1
	pass_flags = PASSTABLE
	loot = list(/obj/item/stack/ore/glass/basalt, /obj/item/stack/ore/glass/basalt, /obj/item/stack/ore/glass/basalt)
	brood_type = null

/mob/living/simple_animal/hostile/asteroid/hivelord/creeper/OpenFire(the_target)
	playsound(src,'modular_skyrat/sound/minecraft/hiss.ogg',200,1)
	addtimer(CALLBACK(src, .proc/xplode), 60)
	return

/mob/living/simple_animal/hostile/asteroid/hivelord/creeper/AttackingTarget()
	OpenFire()
	return TRUE

/mob/living/simple_animal/hostile/asteroid/hivelord/creeper/death()
	src.xplode()
	qdel(src)

/mob/living/simple_animal/hostile/asteroid/hivelord/creeper/proc/xplode()
	playsound(src,'modular_skyrat/sound/minecraft/tntold.ogg',200,1)
	explosion(src, 0, 1, 2, 0, adminlog = FALSE, ignorecap = FALSE, flame_range = 3, silent = TRUE, smoke = TRUE)

