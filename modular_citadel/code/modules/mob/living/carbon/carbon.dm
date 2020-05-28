/mob/living/carbon
	//oh no vore time
	var/voremode = FALSE

/mob/living/carbon/proc/toggle_vore_mode()
	if(SEND_SIGNAL(src, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_TOGGLED))
		return FALSE //let's not override the main draw of the game these days
	voremode = !voremode
	var/obj/screen/voretoggle/T = locate() in hud_used?.static_inventory
	T?.update_icon_state()
	return TRUE

<<<<<<< HEAD
/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	wrongdirmovedelay = FALSE
	if((combat_flags & COMBAT_FLAG_COMBAT_ACTIVE) && client && lastmousedir)
		if(lastmousedir != dir)
			wrongdirmovedelay = TRUE
			setDir(lastmousedir, ismousemovement = TRUE)

/mob/living/carbon/onMouseMove(object, location, control, params)
	if(!(combat_flags & COMBAT_FLAG_COMBAT_ACTIVE))
		return
	mouse_face_atom(object)
	lastmousedir = dir
=======
/mob/living/carbon/proc/disable_vore_mode()
	voremode = FALSE
	var/obj/screen/voretoggle/T = locate() in hud_used?.static_inventory
	T?.update_icon_state()
>>>>>>> 968426fd48... Combat mode component. (#12338)
