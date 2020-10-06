//Hallucination screen object
/datum/hud
	var/obj/screen/fullscreen/dreamer/dreamer

/obj/screen/fullscreen/dreamer
	name = "wake up"
	icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/fullscreen.dmi'
	icon_state = "hall"
	alpha = 0
	var/mutable_appearance/black_underlay
	var/waking_up = FALSE

/obj/screen/fullscreen/dreamer/Initialize()
	. = ..()
	black_underlay = mutable_appearance(icon, "black", layer-0.1, plane, color)

/obj/screen/fullscreen/dreamer/update_for_view(client_view)
	if(screen_loc == "CENTER-7,CENTER-7" && view != client_view && black_underlay)
		var/list/actualview = getviewsize(client_view)
		view = client_view
		black_underlay.transform = matrix(actualview[1]/FULLSCREEN_OVERLAY_RESOLUTION_X, 0, 0, 0, actualview[2]/FULLSCREEN_OVERLAY_RESOLUTION_Y, 0)
	update_overlays()

/obj/screen/fullscreen/dreamer/update_overlays()
	. = ..()
	underlays -= black_underlay
	if(black_underlay)
		underlays += black_underlay

/obj/screen/fullscreen/dreaming
	icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/fullscreen_wakeup.dmi'
	icon_state = "dream"

/obj/screen/fullscreen/dreaming/waking_up
	icon_state = "wake_up"
