/datum/reagent
	var/process_flags = REAGENT_ORGANIC // What can process this? REAGENT_ORGANIC, REAGENT_SYNTHETIC, or REAGENT_ORGANIC | REAGENT_SYNTHETIC?. We'll assume by default that it affects organics.
	var/glass_icon = 'icons/obj/drinks.dmi' 