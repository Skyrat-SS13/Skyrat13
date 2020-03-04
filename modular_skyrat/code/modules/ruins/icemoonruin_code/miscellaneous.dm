/turf/open/floor/plating/ice/icemoon/slippery
	name = "slippery ice"
	desc = "Not even iceboots could withstand this one."

/turf/open/floor/plating/ice/icemoon/slippery/Initialize()
	. = ..()
	AddComponent(datum/component/slippery, 120, SLIDE | GALOSHES_DONT_HELP | SLIP_WHEN_CRAWLING)

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

/obj/structure/spawner/syndicate/cryosleep/Process()
	..()
	if(var/mob/living/L in view(src, 2) && !activated)
		audible_message("<span class='warning'>The [src] emits a hissing sound.</span>")
		addtimer(CALLBACK(src, /datum/proc/AddComponent, /datum/component/spawner, mob_types, 0, faction, spawn_text, max_mobs), 5)
		sleep(65)
		max_mobs = 0