//Noise holder
/obj/screen/fullscreen/noise
	icon = 'modular_skyrat/icons/mob/noise.dmi'
	icon_state = "noise1"
	screen_loc = "EAST,SOUTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/mutable_appearance/noise_appearance

/obj/screen/fullscreen/noise/Initialize()
	. = ..()
	generate_noise_appearance()

/obj/screen/fullscreen/noise/proc/generate_noise_appearance(view = world.view)
	var/current_noise = rand(1,9)
	noise_appearance = mutable_appearance(icon, "noise[current_noise]", FLOAT_LAYER-1, FLOAT_PLANE-1)
	var/views = splittext(world.view, "x")
	var/viewx = text2num(views[1])
	var/viewy = text2num(views[2])
	for(var/i in 0 to viewx)
		for(var/y in 0 to viewy)
			current_noise = rand(1,9)
			var/mutable_appearance/noiser = mutable_appearance(noise_appearance.icon, "noise[current_noise]", FLOAT_LAYER-1, FLOAT_PLANE-1)
			noiser.screen_loc = "EAST+[i],SOUTH+[y]"
			noise_appearance.overlays += noiser

/obj/screen/fullscreen/noise/update_overlays()
	. = ..()
	cut_overlays()
	if(noise_appearance)
		. += noise_appearance
