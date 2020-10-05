//Hallucination screen object
/datum/hud
	var/obj/screen/dreamer/dreamer

/obj/screen/dreamer
	name = "wake up"
	icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/fullscreen.dmi'
	icon_state = "hall"
	screen_loc = ui_dreamer
	alpha = 0
	var/waking_up = FALSE
