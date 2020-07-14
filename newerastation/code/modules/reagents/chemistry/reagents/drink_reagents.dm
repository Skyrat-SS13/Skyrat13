/datum/reagent/consumable/guarana
	name = "Guaraná Antarctica"
	description = "Guaraná Soda"
	color = "#A76B29"
	taste_description = "guarana soda"
	glass_icon_state  = "glass_brown"
	glass_name = "glass of Guaraná"
	glass_desc = "If you stare at the Guarana, it stares back at you."
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/guarana/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()