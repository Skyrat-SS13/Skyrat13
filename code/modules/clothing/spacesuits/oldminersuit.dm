/obj/item/clothing/head/helmet/space/hardsuit/oldmine
	name = "prototype mining RIG hardsuit helmet"
	desc = "A reinforced version of the engineering RIG helmet, designed for miners on asteroid mining operations."
	icon = 'icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head.dmi'
	icon_state = "oldmine0"
	hardsuit_type = "oldmine"
	armor = list("melee" = 30, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 75, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/oldmine
	name = "prototype mining RIG hardsuit"
	desc = "An offshoot of the prototype engineering RIG suit built for miners after many years of accidental suit punctures on asteroid mining missions."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	icon_state = "oldmine"
	armor = list("melee" = 40, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 75, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 75)
	slowdown = 2
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/oldmine
	resistance_flags = FIRE_PROOF

/obj/machinery/suit_storage_unit/oldmine
	suit_type = /obj/item/clothing/suit/space/hardsuit/oldmine