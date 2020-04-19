//explorer mask nerf
/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50) 

//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "seva"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'icons/mob/clothing/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "seva"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	flags_inv = HIDEHAIR
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/clothing/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/mask/gas/seva
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "seva"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/masks.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/clothing/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)
	mutantrace_variation = STYLE_MUZZLE

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "exo"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'icons/mob/clothing/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "exo"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/clothing/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "exo"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/masks.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'icons/mob/clothing/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)
	mutantrace_variation = STYLE_MUZZLE
