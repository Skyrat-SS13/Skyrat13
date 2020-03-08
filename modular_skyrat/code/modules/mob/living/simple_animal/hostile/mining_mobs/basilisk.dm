//A frail creature that actually evades combat.
/mob/living/simple_animal/hostile/asteroid/basilisk/wisp
	name = "wisp"
	desc = "A frail creature, that always flees from harm."
	icon = 'modular_skyrat/icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "wisp"
	icon_living = "wisp"
	icon_aggro = "wisp"
	icon_dead = "wisp_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	move_to_delay = 2
	projectiletype = /obj/item/projectile/temp/basilisk/wisp
	projectilesound = 'modular_skyrat/sound/effects/glassy.ogg'
	ranged = 1
	ranged_message = "shoots a blast"
	ranged_cooldown_time = 10
	throw_message = "audibly screeches"
	speed = 0.5
	maxHealth = 100
	health = 100
	obj_damage = 5
	attacktext = "iceburns"
	speak_emote = list("chitters")
	attack_sound = 'modular_skyrat/sound/effects/glassy.ogg'
	vision_range = 3
	aggro_vision_range = 21
	turns_per_move = 0
	loot = list(/obj/item/organ/regenerative_core/wisp)
	melee_damage_lower = 1
	melee_damage_upper = 1
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK
	retreat_distance = 21
	weather_immunities = list("snow")
	butcher_results = list()

/obj/item/projectile/temp/basilisk/wisp
	name = "freezing blast"
	icon_state = "ice_2"
	damage = 0
	damage_type = BURN
	nodamage = 1
	flag = "energy"
	temperature = 50

//le minecraft
/mob/living/simple_animal/hostile/asteroid/basilisk/ghast
	name = "ghast"
	desc = "A beast that despite it's crrying and shrieking and squarity, is very fearsome."
	icon = 'modular_skyrat/icons/mob/minecraft/minecraft.dmi'
	icon_state = "ghast"
	icon_living = "ghast"
	icon_aggro = "ghast"
	icon_dead = "ghast_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	move_to_delay = 10
	projectiletype = /obj/item/projectile/temp/basilisk/magmawing
	projectilesound = 'modular_skyrat/sound/minecraft/ghast.ogg'
	ranged = 1
	ranged_message = "cries"
	ranged_cooldown_time = 60
	throw_message = "does nothing against the hard shell of"
	vision_range = 4
	speed = 1
	maxHealth = 200
	health = 200
	harm_intent_damage = 5
	obj_damage = 60
	melee_damage_lower = 12
	melee_damage_upper = 12
	attacktext = "bites"
	a_intent = INTENT_HARM
	speak_emote = list("moans")
	attack_sound = 'modular_skyrat/sound/minecraft/fireball.ogg'
	aggro_vision_range = 9
	turns_per_move = 0
	gold_core_spawnable = HOSTILE_SPAWN
	loot = list(/obj/item/stack/ore/gold{layer = ABOVE_MOB_LAYER})