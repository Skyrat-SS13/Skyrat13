//Hallucination screen object
/datum/hud
	var/obj/screen/fullscreen/dreamer/dreamer

/obj/screen/fullscreen/dreamer
	name = "wake up"
	icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/fullscreen.dmi'
	icon_state = "hall"
	alpha = 0
	var/waking_up = FALSE
