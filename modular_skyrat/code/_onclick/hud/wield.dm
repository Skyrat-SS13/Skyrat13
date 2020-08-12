/obj/screen/wield
	name = "wield"
	layer = ABOVE_HUD_LAYER - 0.1
	var/active = FALSE

/obj/screen/wield/update_overlays()
	. = ..()
	cut_overlays()
	if(active)
		var/mutable_appearance/overlay_wielded = mutable_appearance(icon, "selected_act", ABOVE_HUD_LAYER, plane)
		add_overlay(overlay_wielded)

/obj/screen/wield/Click()
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		C.wield_active_hand()
