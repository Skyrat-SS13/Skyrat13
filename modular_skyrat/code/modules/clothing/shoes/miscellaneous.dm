/obj/item/clothing/shoes/heels
	name = "high heels"
	desc = "A fancy pair of high heels. Won't compensate for your below average height that much."
	mutantrace_variation = STYLE_NO_ANTHRO_ICON | STYLE_DIGITIGRADE
	icon = 'modular_skyrat/icons/obj/clothing/shoes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/feet.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/feet_digi.dmi'
	icon_state = "heels"
	item_state = "heels"
	var/list/poly_colors = list("#DDDDDD", "#AEAEAE", "#727272", "#616161")

/obj/item/clothing/shoes/heels/poly
	name = "polychromic high heels"
	desc = "A fancy pair of high heels. Won't compensate for your below average height that much."

/obj/item/clothing/shoes/heels/poly/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 1)

/obj/item/clothing/shoes/bhop
	name = "dashing boots"
	desc = "A specialized pair of combat boots with a built-in propulsion system for rapid foward movement. <b>These do not, however, help you jump over gaps, lava and other such things.</b>"
