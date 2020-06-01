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
	else
		var/obj/item/gun/G = get_active_held_item()
		gunpointing = new(src, M, G)