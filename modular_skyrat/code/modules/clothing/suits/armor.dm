//child p- civil protection armor
/obj/item/clothing/suit/armor/vest/cparmor
	name = "Civil Protection armor"
	desc = "It barely covers your chest, but does a decent job at protecting you from crowbars."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	icon_state = "cparmor"
	item_state = "cparmor"
	blood_overlay_type = "armor"
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

//infiltrator suit buff
/obj/item/clothing/suit/armor/vest/infiltrator
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 40, "bomb" = 70, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)

//blueshield armor
/obj/item/clothing/suit/armor/vest/blueshield
	name = "blueshield security armor"
	desc = "An armored vest with the badge of a Blueshield Lieutenant."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	icon_state = "blueshield"
	item_state = "blueshield"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20,"energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 75)
	mutantrace_variation = STYLE_NO_ANTHRO_ICON
