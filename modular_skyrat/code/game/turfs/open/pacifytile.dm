/turf/open/pacifytile
	name = "pacifying tile"
	icon = 'modular_skyrat/icons/turf/floors/pacifytile.dmi'
	icon_state = "safezone"
	baseturfs = /turf/open/pacifytile
	slowdown = -1

/turf/open/pacifytile/Entered(atom/movable/AM)
	if(!isliving(AM))
		return

	var/mob/living/L = AM
	if(!L.ckey)
		return

	if(!HAS_TRAIT(L, TRAIT_PACIFISM))
		ADD_TRAIT(L, TRAIT_PACIFISM, "pacified")
		to_chat(L, "You have been pacified.")
		return
	else
		return