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
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 75)
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

//makeshift armor
/obj/item/clothing/suit/armor/makeshift
	name = "makeshift armor"
	desc = "A hazard vest with metal plate taped on it. It offers minor protection at the cost of speed."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	icon_state = "makeshiftarmor-worn"
	item_state = "makeshiftarmor"
	w_class = 3
	blood_overlay_type = "armor"
	slowdown = 0.35
	armor = list("melee" = 25, "bullet" = 10, "laser" = 0, "energy" = 0, "bomb" = 5, "bio" = 0, "rad" = 0)

//cloaker armor vest
/obj/item/clothing/suit/armor/vest/advanced
	name = "advanced armor vest"
	desc = "Stop hitting yourself."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	icon_state = "cloaker"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 35, "energy" = 50, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 100)
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

//solar armor
/obj/item/clothing/suit/armor/riot/solar
	name = "solar armor"
	desc = "An unimaginably powerful suit of armor, said to have been forged with the very essence of every star in the universe."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	icon_state = "solar_armor"
	item_state = "solar_armor"
	armor = list("melee" = 90, "bullet" = 90, "laser" = 90, "energy" = 90, "bomb" = 90, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 100)
	allowed = list(/obj/item/clockwork/weapon/daybreak)
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	blocks_shove_knockdown = TRUE
	strip_delay = 80
	equip_delay_other = 60