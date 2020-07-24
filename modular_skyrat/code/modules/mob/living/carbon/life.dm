/mob/living/carbon/proc/rot()
	// Properly stored corpses shouldn't create miasma
	if(istype(loc, /obj/structure/closet/crate/coffin)|| istype(loc, /obj/structure/closet/body_bag) || istype(loc, /obj/structure/bodycontainer))
		return

	// No decay if formaldehyde/preservahyde in corpse or when the corpse is charred
	if(reagents.has_reagent(/datum/reagent/toxin/formaldehyde, 1) || HAS_TRAIT(src, TRAIT_HUSK) || reagents.has_reagent(/datum/reagent/medicine/preservahyde, 1))
		return

	// Also no decay if corpse chilled or not organic/undead
	if((bodytemperature <= T0C-10) || !(mob_biotypes & (MOB_ORGANIC|MOB_UNDEAD)))
		return

	// Wait a bit before decaying
	if(world.time - timeofdeath < 1200)
		return

	var/deceasedturf = get_turf(src)

	// Closed turfs don't have any air in them, so no gas building up
	if(!istype(deceasedturf,/turf/open))
		return

	var/turf/open/miasma_turf = deceasedturf

	var/datum/gas_mixture/stank = new

	switch(bodytemperature)
		if(T0C + 4 to T0C + 10)
			stank.gases[/datum/gas/miasma] = 0.15
		if(T0C + 5 to T0C + 20)
			stank.gases[/datum/gas/miasma] = 0.30
		if(T0C + 20 to T0C + 40)
			stank.gases[/datum/gas/miasma] = 0.45
		if(T0C + 40 to T0C + 50)
			stank.gases[/datum/gas/miasma] = 0.30
		if(T0C + 60 to T0C + 70)
			stank.gases[/datum/gas/miasma] = 0.15
		else
			stank.gases[/datum/gas/miasma] = 0.1
	stank.temperature = (bodytemperature + BODYTEMP_NORMAL) / 2

	miasma_turf.assume_air(stank)
	miasma_turf.air_update_turf()