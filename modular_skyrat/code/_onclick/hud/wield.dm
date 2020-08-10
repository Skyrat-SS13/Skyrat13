/obj/screen/wield
	name = "wield"
	layer = ABOVE_HUD_LAYER - 0.1

/obj/screen/wield/Click()
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.wield_active_hand()
