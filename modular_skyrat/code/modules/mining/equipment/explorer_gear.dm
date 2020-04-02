//explorer mask nerf
/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50) //WHY THE FUCK DID THESE FUCKING HAVE LASER, BULLET AND FUCKING MELEE PROTECTION IN THE FIRST PLACE? ARE YOU FUCKIGN RETARDED? FUCK YOU.

//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_suit"
	alternate_worn_icon = 'modular_skyrat/icons/mob/epic_mining.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_helmet"
	alternate_worn_icon = 'modular_skyrat/icons/mob/epic_mining.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/mask/gas/seva
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_mask"
	alternate_worn_icon = 'modular_skyrat/icons/mob/epic_mining.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "exo_suit"
	alternate_worn_icon = 'modular_skyrat/icons/mob/epic_mining.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "exo_helmet"
	alternate_worn_icon = 'modular_skyrat/icons/mob/epic_mining.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "exo_mask"
	alternate_worn_icon = 'modular_skyrat/icons/mob/epic_mining.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
