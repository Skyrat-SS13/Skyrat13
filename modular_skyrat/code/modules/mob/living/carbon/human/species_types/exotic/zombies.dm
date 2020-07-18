/datum/species/zombie
	// 3spooky
	name = "High-Functioning Zombie"
	id = "zombie"
	say_mod = "growls"
	
/datum/species/zombie/infectious
	name = "Nanite Horror"
	exotic_blood = /datum/reagent/romerol
	icon_limbs = 'modular_skyrat/icons/mob/zombie_parts.dmi'
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_NOLIMBDISABLE,TRAIT_UNINTELLIGIBLE_SPEECH,TRAIT_FREESPRINT,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE)
