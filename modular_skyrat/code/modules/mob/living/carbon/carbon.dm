/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(gunpointing)
		var/dir = get_dir(get_turf(gunpointing.source),get_turf(gunpointing.target))
		if(dir)
			setDir(dir)

/mob/living/carbon/on_examine_atom(atom/examined)
	if(!istype(examined) || !client)
		return

	if(get_dist(src, examined) > EYE_CONTACT_RANGE)
		return
	
	if(!((wear_mask && wear_mask.flags_inv & (wear_mask.flags_inv & HIDEFACE || wear_mask.flags_inv & HIDEEYES)) || (head && (head.flags_inv & HIDEFACE || head.flags_inv & HIDEEYES)) || (glasses && (glasses.flags_inv & HIDEFACE || glasses.flags_inv & HIDEEYES))))
	
	visible_message(message = "<span class='notice'>\The [src] examines [examined].</span>", vision_distance = 3)
