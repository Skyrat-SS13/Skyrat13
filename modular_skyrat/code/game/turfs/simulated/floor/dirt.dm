/turf/open/floor/plating/dirt/dark/proc/getDug()
	new digResult(src, 5)
	if(postdig_icon_change)
		if(!postdig_icon)
			icon_plating = "greenerdirt_dug"
			icon_state = "greenerdirt_dug"
	dug = TRUE

/turf/open/floor/plating/dirt/dark/proc/can_dig(mob/user)
	if(!dug)
		return TRUE
	if(user)
		to_chat(user, "<span class='notice'>Looks like someone has dug here already.</span>")

/turf/open/floor/plating/dirt/dark/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(!.)
		if(W.tool_behaviour == TOOL_SHOVEL || W.tool_behaviour == TOOL_MINING)
			if(!can_dig(user))
				return TRUE

			if(!isturf(user.loc))
				return

			to_chat(user, "<span class='notice'>You start digging...</span>")

			if(W.use_tool(src, user, 40, volume=50))
				if(!can_dig(user))
					return TRUE
				to_chat(user, "<span class='notice'>You dig a hole.</span>")
				getDug()
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
				return TRUE
		else if(istype(W, /obj/item/storage/bag/ore))
			for(var/obj/item/stack/ore/O in src)
				SEND_SIGNAL(W, COMSIG_PARENT_ATTACKBY, O)

/turf/open/floor/plating/dirt/proc/SpawnFloor(turf/T)
	for(var/S in RANGE_TURFS(1, src))
		var/turf/NT = S
		if(!NT || isspaceturf(NT) || istype(NT.loc, /area/mine/explored) || (istype(NT.loc, /area/lavaland/surface/outdoors) && !istype(NT.loc, /area/lavaland/surface/outdoors/unexplored)))
			sanity = 0
			break
	if(!sanity)
		return
	SpawnFlora(T)

/turf/open/floor/plating/dirt/proc/SpawnFlora(turf/T)
	if(prob(75))
		if(!istype(loc, /area/lavaland/surface))
			return
		var/randumb = pickweight(flora_spawn_list)
		for(var/obj/structure/flora/rock/F in range(1, T))
			if(!istype(F, randumb))
				return
		new randumb(T)


/turf/open/floor/plating/dirt/Initialize()
	. = ..()
	if(SSticker.current_state < GAME_STATE_PLAYING) //make sure you dont get a fucking tree in your face when you try to deconstruct stuff
		SpawnFloor(src)