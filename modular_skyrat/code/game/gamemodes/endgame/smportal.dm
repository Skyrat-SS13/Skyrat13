/obj/effect/smportal
	name = "portal"
	desc = "A portal to a better place."
	icon = 'modular_skyrat/code/game/gamemodes/endgame/smportal.dmi'
	icon_state = "rift"
	anchored = TRUE
	opacity = 0
	density = 0
	alpha = 0
	pixel_x = -252
	pixel_y = -266

	var/nextcheck = 0
	var/end_toggle = FALSE

/obj/effect/smportal/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/smportal/process()
	if(!end_toggle)
		if(world.time < nextcheck)
			return
		nextcheck = world.time + 10 SECONDS
		var/checking_for_smblob = locate(/turf/closed/wall/supermatter)
		if(!checking_for_smblob)
			return
		end_toggle = TRUE
		for(var/obj/machinery/light/L in GLOB.machines)
			L.break_light_tube()
		power_failure()
		alpha = 255
	else
		var/turf/exit_turf = get_turf(locate(/obj/effect/smportalexit))
		for(var/mob/living/L in range(src, "16x16"))
			if(!L.ckey && !L.mind)
				continue
			L.forceMove(exit_turf)

/obj/effect/smportal/attack_ghost(mob/user)
	. = ..()
	var/turf/exit_turf = get_turf(locate(/obj/effect/smportalexit))
	user.forceMove(exit_turf)
			
/obj/effect/smportalexit
	alpha = 0

/obj/effect/smportalexitfail
	alpha = 0
