/mob/living/simple_animal/hostile/asteroid/polarbear
	name = "polar bear"
	desc = "An aggressive animal that defends it's territory with incredible power. These beasts don't run from their enemies."
	icon = 'modular_skyrat/icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "polarbear"
	icon_living = "polarbear"
	icon_dead = "polarbear_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	speak_emote = list("growls")
	speed = 3
	maxHealth = 200
	health = 200
	obj_damage = 40
	melee_damage_lower = 15
	melee_damage_upper = 15
	attacktext= "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	vision_range = 7
	aggro_vision_range = 3
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/bear = 5, /obj/item/clothing/head/bearpelt = 1)
	loot = list()
	stat_attack = UNCONSCIOUS
	robust_searching = TRUE
	var/aggressive_message_said = FALSE
	weather_immunities = list("snow")

/mob/living/simple_animal/hostile/asteroid/polarbear/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(health <= maxHealth*0.5)
		if(!aggressive_message_said && target)
			visible_message("<span class='danger'>The [name] gets an enraged look at [target]!</span>")
			aggressive_message_said = TRUE
		rapid_melee = 2
	else
		rapid_melee = initial(rapid_melee)

/mob/living/simple_animal/hostile/asteroid/polarbear/Life()
	. = ..()
	if(target == null)
		adjustHealth(-maxHealth*0.025)
		aggressive_message_said = FALSE

/mob/living/simple_animal/hostile/asteroid/polarbear/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	..(gibbed)