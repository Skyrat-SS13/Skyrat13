//explorer mask nerf
/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50)

//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "seva_suit"
	mob_overlay_icon = 'modular_skyrat/icons/mob/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/suit_digi.dmi'
	unique_reskin_worn = list(
	"Old" = 'modular_skyrat/icons/mob/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'modular_skyrat/icons/mob/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit_digi.dmi'
	)
	unique_reskin_stored = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "seva_helmet"
	mob_overlay_icon = 'modular_skyrat/icons/mob/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	unique_reskin_worn = list(
	"Old" = 'modular_skyrat/icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'modular_skyrat/icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	)
	unique_reskin_stored = list(
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
	icon_state = "seva_mask"
	mob_overlay_icon = 'modular_skyrat/icons/mob/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	unique_reskin_worn = list(
	"Old" = 'modular_skyrat/icons/mob/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'modular_skyrat/icons/mob/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	)
	unique_reskin_stored = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "exo_suit"
	mob_overlay_icon = 'modular_skyrat/icons/mob/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/suit_digi.dmi'
	unique_reskin_worn = list(
	"Old" = 'modular_skyrat/icons/mob/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Old" = 'modular_skyrat/icons/mob/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/suit_digi.dmi'
	)
	unique_reskin_stored = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "exo_helmet"
	mob_overlay_icon = 'modular_skyrat/icons/mob/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	unique_reskin_worn = list(
	"Old" = 'modular_skyrat/icons/mob/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'modular_skyrat/icons/mob/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	)
	unique_reskin_stored = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "exo_mask"
	mob_overlay_icon = 'modular_skyrat/icons/mob/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	unique_reskin_worn = list(
	"Old" = 'modular_skyrat/icons/mob/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask.dmi'
	)
	unique_reskin_worn_muzzled = list(
	"Old" = 'modular_skyrat/icons/mob/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/mask_muzzled.dmi'
	)
	unique_reskin_stored = list(
	"Old" = "exo",
	"Improved" = "exo_mask"
	)
