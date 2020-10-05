/obj/screen/info
	name = "item info"
	icon = 'modular_skyrat/icons/mob/screen_gen.dmi'
	icon_state = "info"

/obj/screen/info/Click(location, control, params)
	. = ..()
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.item_info()
