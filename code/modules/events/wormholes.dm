/datum/round_event_control/wormholes
	name = "Wormholes"
	typepath = /datum/round_event/wormholes
	max_occurrences = 3
	weight = 2
	min_players = 2
	gamemode_blacklist = list("dynamic")

/datum/round_event/wormholes
	announceWhen = 10
	endWhen = 60

	var/list/pick_turfs = list()
	var/list/wormholes = list()
	var/shift_frequency = 3
	var/number_of_wormholes = 400

/datum/round_event/wormholes/setup()
	announceWhen = rand(0, 20)
	endWhen = rand(40, 80)

/datum/round_event/wormholes/start()
	for(var/turf/open/floor/T in world)
		if(is_station_level(T.z))
			var/area/A = get_area(T)
			if(A.outdoors)
				continue
			pick_turfs += T

	//Start of Skyrat Changes.
	for(var/i = 1, i <= CEILING(number_of_wormholes,2), i++) //Force even number of wormholes.
		var/turf/T = pick(pick_turfs)
		var/obj/effect/portal/wormhole/W = new /obj/effect/portal/wormhole(T, null, 0, null, FALSE)
		animate(W,alpha = 75, time = (endWhen - startWhen)*10, easing = CIRCULAR_EASING | EASE_IN) //Animate it.
		if(i > 0 && i % 2 == 0) //Only trigger on even numbers greater than 0.
			//Link the two wormholes together.
			var/obj/effect/portal/wormhole/OLD_W = wormholes[i - 1]
			OLD_W.hard_target = W.loc
			W.hard_target = OLD_W.loc
		wormholes += W
	//End of Skyrat changes.

/datum/round_event/wormholes/announce(fake)
	priority_announce("Space-time anomalies detected on the station. There is no additional data.", "Anomaly Alert", "spanomalies")

/* SKYRAT CHANGE: NO WORMHOLE SHIFTING.
/datum/round_event/wormholes/tick()
	if(activeFor % shift_frequency == 0)
		for(var/obj/effect/portal/wormhole/O in wormholes)
			var/turf/T = pick(pick_turfs)
			if(T)
				O.forceMove(T)
*/

/datum/round_event/wormholes/end()
	QDEL_LIST(wormholes)
	wormholes = null

/obj/effect/portal/wormhole
	name = "wormhole"
	desc = "It looks highly unstable. You could end up literally anywhere." //SKYRAT CHANGE.
	icon = 'icons/obj/objects.dmi'
	icon_state = "anom"
	mech_sized = TRUE

/obj/effect/portal/wormhole/teleport(atom/movable/M)
	if(iseffect(M))	//sparks don't teleport
		return
	if(M.anchored)
		if(!(ismecha(M) && mech_sized))
			return

	if(ismovable(M))
		if(!hard_target && GLOB.portals.len) //SKYRAT CHANGE, CHECK IF IT HAS A HARD TARGET.
			var/obj/effect/portal/P = pick(GLOB.portals)
			if(P && isturf(P.loc))
				hard_target = P.loc
		if(!hard_target)
			return
		do_teleport(M, hard_target, 1, 1, 0, 0, channel = TELEPORT_CHANNEL_WORMHOLE) ///You will appear adjacent to the beacon
