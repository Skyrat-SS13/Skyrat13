//fuck it we making underwear actual items
/obj/item/clothing/underwear
	name = "Underwear"
	desc = "If you're reading this, something went wrong."
	icon = 'modular_skyrat/icons/mob/clothing/underwear.dmi' //if someone is willing to make proper inventory sprites that'd be very cash money
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/underwear.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/underwear_digi.dmi'
	body_parts_covered = GROIN
	permeability_coefficient = 0.9
	block_priority = BLOCK_PRIORITY_UNDERWEAR
	slot_flags = ITEM_SLOT_UNDERWEAR
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	mutantrace_variation = STYLE_NO_ANTHRO_ICON
	var/under_type = /obj/item/clothing/underwear //i don't know what i'm gonna use this for
	var/fitted = NO_FEMALE_UNIFORM
	var/has_colors = TRUE
