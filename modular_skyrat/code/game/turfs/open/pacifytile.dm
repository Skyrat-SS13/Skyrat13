GLOBAL_LIST_EMPTY(safezone_players)

/turf/open/centcom_safezone
	name = "safezone tile"
	icon = 'modular_skyrat/icons/turf/floors/pacifytile.dmi'
	slowdown = -1
	CanAtmosPass = ATMOS_PASS_NO

/turf/open/centcom_safezone/pacifytile
	name = "pacifying tile"
	icon_state = "safezone"
	baseturfs = /turf/open/centcom_safezone/pacifytile

/turf/open/centcom_safezone/pacifytile/CanPass(atom/movable/mover, turf/target)
	if(!ishuman(mover))
		if(isprojectile(mover))
			qdel(mover)
		if(issilicon(mover))
			return TRUE
		return FALSE
	if(mover in GLOB.safezone_players)
		return FALSE
	var/mob/living/carbon/human/H = mover
	if(!H.ckey)
		return FALSE
	if(!HAS_TRAIT(H, TRAIT_PACIFISM))
		ADD_TRAIT(H, TRAIT_PACIFISM, "pacified")
		to_chat(H, "You have been pacified.")
	GLOB.safezone_players += mover
	return TRUE

/turf/open/centcom_safezone/warzonetile
	name = "warzone tile"
	icon_state = "killzone"
	baseturfs = /turf/open/centcom_safezone/warzonetile

/turf/open/centcom_safezone/warzonetile/CanPass(atom/movable/mover, turf/target)
	if(mover in GLOB.safezone_players)
		return FALSE
	if(isliving(mover))
		var/mob/living/L = mover
		if(HAS_TRAIT(L, TRAIT_PACIFISM))
			return FALSE
	GLOB.safezone_players += mover
	return TRUE

/turf/open/centcom_safezone/healtile
	name = "heal tile"
	icon_state = "healzone"
	baseturfs = /turf/open/centcom_safezone/healtile

/turf/open/centcom_safezone/healtile/Entered(atom/movable/AM)
	if(!ishuman(AM))
		return
	var/mob/living/carbon/human/H = AM
	H.fully_heal(TRUE)
