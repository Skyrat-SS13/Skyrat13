/datum/reagent/consumable/guarana
	name = "Guaraná Antarctica"
	description = "Guaraná Soda"
	color = "#A76B29"
	taste_description = "guarana soda"
	glass_icon_state  = "glass_brown"
	glass_name = "glass of Guaraná"
	glass_desc = "If you stare at the Guarana, it stares back at you."
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/caipivodka
	name = "Caipivodka de Guaraná"
	description = "A fizzy mix with ingredients from both Brazil and Russia. The internet's worst nightmare."
	color = "#503014" // rgb: 80, 48, 20
	boozepwr = 32
	taste_description = "acidic sweetness"
	glass_icon = 'newerastation/icons/obj/drinks.dmi'
	glass_icon_state = "caipivodka"
	glass_name = "glass of caipivodka"
	glass_desc = "The glass contain caipivodka. It makes you want to samba."
	shot_glass_icon_state = "shotglassclear"
	pH = 4.5

/datum/reagent/consumable/guarana/on_mob_life(mob/living/carbon/M)
	. = ..()
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
