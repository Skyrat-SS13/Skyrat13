/mob/living/ShiftMiddleClickOn(atom/A)
	src.pointed(A)
	return

/mob/living/proc/DoGunpoint(atom/A, obj/item/gun/G)
	if(A == src)
		return
	if(!isliving(A))
		if(gunpointing) //Cancelling a gunpoint by shift + MMB on a non-mob
			gunpointing.Destroy()
		return
	var/mob/living/L = A
	if(gunpointing && L == gunpointing.target) //Cancelling a gunpoint by shift + MMB on the target
		gunpointing.ClickDestroy()
	else
		if(!CanGunpointAt(L, TRUE))
			return
		if(gunpointing) //We're gunpoint and we already know we're locking onto a different, valid target
			gunpointing.Destroy()
		gunpointing = new(src, L, G)

/mob/living/proc/CanGunpointAt(mob/living/L, notice = FALSE)
	if(!(CHECK_MOBILITY(src, MOBILITY_STAND)))
		if(notice)
			to_chat(src, "<span class='warning'>I need to be standing to get a good aim!</span>")
		return FALSE
	if(!(L in fov_viewers(8, src)))
		if(notice)
			to_chat(src, "<span class='warning'>My target is out of my view!</span>")
		return FALSE
	if(L.alpha < 70)
		if(notice)
			to_chat(src, "<span class='warning'>I can't quite make out my target!</span>")
		return FALSE
	if(mind && (GET_SKILL_LEVEL(src, ranged) <= JOB_SKILLPOINTS_NOVICE))
		if(notice)
			var/fuck = pick("Fnord", "Fuck", "Shit", "Piss", "Ugh", "Hnng")
			to_chat(src, "<span class='warning'>[fuck]... I'm too incompentent to aim at my target!</span>")
		return FALSE
	return TRUE
