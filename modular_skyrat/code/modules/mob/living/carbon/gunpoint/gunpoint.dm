/mob/living/carbon
	var/datum/gunpoint/gunpointing

/mob
	var/list/gunpointed = list()


/mob/living/carbon/ShiftMiddleClickOn(atom/A)
	var/obj/item/gun/G = get_active_held_item()
	if(CHECK_MOBILITY(src, MOBILITY_STAND) && ((G && ismob(A)) || (gunpointing && (G == gunpointing.aimed_gun))))
		DoGunpoint(A)
	else
		src.pointed(A)
	return

/mob/living/carbon/proc/DoGunpoint(mob/M)
	if(gunpointing)
		gunpointing.ClickDestroy()
	else if (CanGunpointAt(M, TRUE))
		var/obj/item/gun/G = get_active_held_item()
		gunpointing = new(src, M, G)

/mob/living/carbon/proc/CanGunpointAt(mob/M, notice = FALSE)
	if(!M in viewers(get_turf(src), 7))
		if(notice)
			to_chat(src, "<span class='warning'>Your target is out of your view!</span>")
		return FALSE
	if(M.alpha < 70)
		if(notice)
			to_chat(src, "<span class='warning'>You can't quite make out your target!</span>")
		return FALSE
	return TRUE