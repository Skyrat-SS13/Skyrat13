/mob/living/simple_animal/hostile/asteroid/goliath/zombie
	name = "zombie"
	gender = MALE
	desc = "Why is he so blocky?"
	icon = 'modular_skyrat/icons/mob/minecraft/minecraft.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_aggro = "zombie"
	icon_dead = "zombie_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	move_to_delay = 5
	ranged = 0
	friendly = "waves at"
	speak_emote = list("moans")
	speed = 1
	maxHealth = 200
	health = 200
	harm_intent_damage = 0
	obj_damage = 100
	melee_damage_lower = 18
	melee_damage_upper = 18
	attacktext = "bites"
	attack_sound = 'modular_skyrat/sound/minecraft/zombie.ogg'
	throw_message = "does nothing to the flesh of"
	vision_range = 4
	aggro_vision_range = 7
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	loot = list(/obj/item/stack/sheet/animalhide/goliath_hide)

	do_footstep = TRUE

/mob/living/simple_animal/hostile/asteroid/goliath/zombie/OpenFire()
	return