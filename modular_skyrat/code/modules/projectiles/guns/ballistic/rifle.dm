//Surplus rifle changes, because its fucking actual garbage, a fucking PIPE PISTOL is better.
/obj/item/gun/ballistic/automatic/surplus
	icon = 'modular_skyrat/icons/obj/bobstation/guns/rifle.dmi'
	fire_delay = 5
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/automatic/surplus/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"][magazine ? "" : "-nomag"][safety ? "-safe" : ""]"
