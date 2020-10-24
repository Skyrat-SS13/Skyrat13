//Surplus rifle changes, because its fucking actual garbage, a fucking PIPE PISTOL is better.
/obj/item/gun/ballistic/automatic/surplus
	icon = 'modular_skyrat/icons/obj/bobstation/guns/rifle.dmi'
	icon_state = "surplus"
	fire_delay = 5
	w_class = WEIGHT_CLASS_BULKY
	safety_sound = 'modular_skyrat/sound/weapons/safety2.ogg'

/obj/item/gun/ballistic/automatic/surplus/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"][magazine ? "" : "-nomag"][safety ? "-safe" : ""]"
