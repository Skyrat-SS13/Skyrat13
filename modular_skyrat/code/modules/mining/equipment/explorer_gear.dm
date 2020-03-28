//explorer mask nerf
/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50) //WHY THE FUCK DID THESE FUCKING HAVE LASER, BULLET AND FUCKING MELEE PROTECTION IN THE FIRST PLACE? ARE YOU FUCKIGN RETARDED? FUCK YOU.

//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_suit"
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'icons/mob/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva_suit"
	)

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_helmet"
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva_helmet"
	)

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/mask/gas/seva
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_mask"
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva_mask"
	)

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_suit"
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'icons/mob/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo_suit"
	)

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_helmet"
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo_helmet"
	)

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	icon_state = "seva_mask"
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/epic_mining.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/epic_mining_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo_mask"
	)