/obj/item/xenoarch/clean/brush
	name = "Mining Brush"
	desc = "Cleans 1cm of material."
	icon = 'modular_skyrat/code/modules/research/xenoarch/tools.dmi'
	icon_state = "pick_brush"

	var/cleaningdepth = 1

/obj/item/xenoarch/clean/brush/Initialize()
	..()