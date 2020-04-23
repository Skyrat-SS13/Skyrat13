//explorer mask nerf
/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50)

//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "seva_suit"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	unique_reskin_stored = list(
	"Old" = "seva",
	"Improved" = "seva_suit"
	)
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "seva_helmet"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	unique_reskin_stored = list(
	"Old" = "seva",
	"Improved" = "seva_hood"
	)
	flags_inv = HIDEEARS
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/mask/gas/seva
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "seva_mask"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	unique_reskin_stored = list(
	"Old" = "seva",
	"Improved" = "seva_mask"
	)
	flags_inv = 0
	mutantrace_variation = STYLE_MUZZLE

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "exo_suit"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	unique_reskin_stored = list(
	"Old" = "exo",
	"Improved" = "exo_suit"
	)
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "exo_helmet"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	unique_reskin_stored = list(
	"Old" = "exo",
	"Improved" = "exo_helmet"
	)
	flags_inv = HIDEEARS
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "exo_mask"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	unique_reskin_stored = list(
	"Old" = "exo",
	"Improved" = "exo_mask"
	)
	flags_inv = 0
	mutantrace_variation = STYLE_MUZZLE

//dora the explorer suit
/obj/item/clothing/suit/hooded/explorer
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/gun/energy/plasmacutter)
	flags_inv = HIDEEARS

/obj/item/clothing/mask/gas/explorer
	flags_inv = 0
