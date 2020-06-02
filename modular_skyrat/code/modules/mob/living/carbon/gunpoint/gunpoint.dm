/mob/living/ShiftMiddleClickOn(atom/A)
	var/obj/item/gun/G = get_active_held_item()
	if(combat_flags & COMBAT_FLAG_COMBAT_ACTIVE && istype(G, /obj/item/gun) && CHECK_MOBILITY(src, MOBILITY_STAND) && isliving(A) || (gunpointing && (G == gunpointing.aimed_gun)))
		DoGunpoint(A)
	else
		src.pointed(A)
	return

/mob/living/proc/DoGunpoint(mob/living/M)
	if(gunpointing)
		gunpointing.ClickDestroy()
	else if (M != src && CanGunpointAt(M, TRUE))
		var/obj/item/gun/G = get_active_held_item()
		gunpointing = new(src, M, G)

/mob/living/proc/CanGunpointAt(mob/M, notice = FALSE)
	if(!(M in fov_viewers(8, src)))
		if(notice)
			to_chat(src, "<span class='warning'>Your target is out of your view!</span>")
		return FALSE
	if(M.alpha < 70)
		if(notice)
			to_chat(src, "<span class='warning'>You can't quite make out your target!</span>")
		return FALSE
	return TRUE