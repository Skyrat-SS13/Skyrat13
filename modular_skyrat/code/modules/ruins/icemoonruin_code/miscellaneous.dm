/turf/open/floor/plating/ice/icemoon/slippery
	name = "slippery ice"
	desc = "Not even iceboots could withstand this one."

/turf/open/floor/plating/ice/icemoon/slippery/Initialize()
	. = ..()
	AddComponent(/datum/component/slippery, 120, SLIDE | GALOSHES_DONT_HELP | SLIP_WHEN_CRAWLING)

/turf/open/floor/plating/ice/icemoon/breaky
	name = "weak ice"
	desc = "Doesn't look too safe to step on..."
	var/breaking = 0

/turf/open/floor/plating/ice/icemoon/breaky/process()
	..()
	for(var/mob/living/L in src.contents)
		if(L in src.contents && !breaking)
			var/obj/item/storage/backpack/B = L.get_item_by_slot(SLOT_BACK)
			if(B)
				var/datum/component/storage/S = B.GetComponent(/datum/component/storage)
				if(S)
					var/sumweight
					for(var/obj/item/I in S)
						sumweight += I.w_class
					if(sumweight >= 14)
						breaking = 1
						audible_message("<span class='warning'>The [src] cracks! Stand back!</span>")
						playsound(loc,'sound/effects/Glassbr1.ogg', 100, 0, 50, 1, 1)
						addtimer(CALLBACK(src, TerraformTurf(/turf/open/chasm/icemoon, /turf/open/chasm/icemoon)), 50)

/turf/open/chasm/icemoon
/obj/structure/spawner/syndicate/cryosleep
	name = "warp beacon"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	spawn_text = "awakes from cryosleep"
	mob_types = list(/mob/living/simple_animal/hostile/syndicate/ranged)
	faction = list(ROLE_SYNDICATE)
	max_mobs = 1
	var/activated = 0

/obj/structure/spawner/syndicate/cryosleep/Initialize()
	..()
	for(var/datum/component/spawner/S in src)
		qdel(S)

/obj/structure/spawner/syndicate/cryosleep/process()
	..()
	if(/mob/living in view(src, 2) && !activated)
		activated = 1
		for(var/mob/living/L in view(src, 2))
			audible_message("<span class='warning'>The [src] emits a hissing sound.</span>")
			addtimer(CALLBACK(src, /datum/proc/AddComponent, /datum/component/spawner, mob_types, 0, faction, spawn_text, max_mobs), 5)
			sleep(65)
			max_mobs = 0

/turf/closed/indestructible/syndicate
	name = "plastitanium wall"
	desc = "Looks sturdier than normal."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "map-shuttle"

/obj/machinery/door/airlock/rogue
	name = "Door to Rogue Process' Arena"
	desc = "LOOK AT YOU HACKER. A PATHETIC CREATURE OF MEAT AND BONE."
	icon = 'icons/obj/doors/airlocks/station/uranium.dmi'
	normal_integrity = 10000
	max_integrity = 10000
	security_level = 6
	hackProof = TRUE
	abandoned = FALSE
	var/fighting = 0

/obj/machinery/door/airlock/rogue/process()
	..()
	obj_integrity = 10000
	for(var/mob/living/carbon/C in get_step(src, NORTH))
		if(!fighting)
			fighting = 1
			close()
			sleep(10)
			bolt()
			for(var/mob/living/simple_animal/hostile/megafauna/rogueprocess/R in view(20, src))
				R.say("FILTHY ORGANIC!")
	for(var/mob/living/simple_animal/hostile/megafauna/rogueprocess/R in view(40, src))
		if(R.stat != CONSCIOUS)
			unbolt()
			open()
			bolt()

/turf/open/floor/circuit/rogue
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/circuit/green/anim/rogue
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/circuit/red/anim/rogue
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
