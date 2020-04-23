/datum/radial_menu
	var/last_hovered 

/obj/screen/radial/slice/MouseEntered(location, control, params)
	. = ..()
	parent.last_hovered = src