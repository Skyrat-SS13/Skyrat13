//Noise holder
/obj/screen/fullscreen/noise
	icon = 'modular_skyrat/icons/mob/noise.dmi'
	icon_state = "1h"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = HUD_LAYER-1
	plane = HUD_PLANE-1
	var/list/mutable_appearance/noise_overlays = list()

/obj/screen/fullscreen/noise/update_for_view(client_view)
	. = ..()
	var/noise = rand(1,9)
	icon_state = "[noise]h"
