/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	wrongdirmovedelay = FALSE
	if(gunpointing)
		var/dir = get_dir(get_turf(gunpointing.source),get_turf(gunpointing.target))
		if(dir)
			wrongdirmovedelay = TRUE
			setDir(dir)
	else if((combat_flags & COMBAT_FLAG_COMBAT_ACTIVE) && client && lastmousedir)
		if(lastmousedir != dir)
			wrongdirmovedelay = TRUE
			setDir(lastmousedir, ismousemovement = TRUE)

/mob/living/carbon/onMouseMove(object, location, control, params)
	if((combat_flags & COMBAT_FLAG_COMBAT_ACTIVE) && !gunpointing)
		face_atom(object, TRUE)
		lastmousedir = dir