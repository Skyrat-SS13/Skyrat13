/mob/living/simple_animal/hostile/carp/tigercarp
	name = "tiger carp"
	desc = "A rare patterned offshoot of the typical space carp. Reports of significant aggression."
	icon = 'modular_skyrat/icons/mob/animal.dmi'
	icon_state = "tigercarp"
	icon_living = "tigercarp"
	icon_dead = "tigercarp_dead"
	icon_gib = "tigercarp_gib"
	maxHealth = 50
	health = 50
	turns_per_move = 6
	vision_range = 13
	aggro_vision_range = 11
	move_to_delay = 2.8
	obj_damage = 65
	melee_damage_lower = 17
	melee_damage_upper = 17
	attack_verb_continuous = "thrashes"
	attack_verb_simple = "thrash"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/carpmeat/tcarpmeat = 3)