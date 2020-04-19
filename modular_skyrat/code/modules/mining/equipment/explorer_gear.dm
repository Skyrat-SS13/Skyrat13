//explorer mask nerf
/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50) //WHY THE FUCK DID THESE FUCKING HAVE LASER, BULLET AND FUCKING MELEE PROTECTION IN THE FIRST PLACE? ARE YOU FUCKIGN RETARDED? FUCK YOU.

//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "seva"
	alternate_worn_icon = 'modular_skyrat/icons/mob/suit.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/suit_digi.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'icons/mob/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "seva"
	alternate_worn_icon = 'modular_skyrat/icons/mob/head.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	flags_inv = HIDEHAIR
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/mask/gas/seva
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "seva"
	alternate_worn_icon = 'modular_skyrat/icons/mob/mask.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/masks.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "exo"
	alternate_worn_icon = 'modular_skyrat/icons/mob/suit.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/suit_digi.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'icons/mob/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "exo"
	alternate_worn_icon = 'modular_skyrat/icons/mob/head.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "exo"
	alternate_worn_icon = 'modular_skyrat/icons/mob/mask.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/masks.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)
