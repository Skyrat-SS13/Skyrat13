/turf/open/floor/plating/rock
	name = "rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"
	var/list/mineralSpawnChanceList = list(/turf/closed/mineral/uranium = 5, /turf/closed/mineral/diamond = 1, /turf/closed/mineral/gold = 10,
		/turf/closed/mineral/silver = 12, /turf/closed/mineral/plasma = 20, /turf/closed/mineral/iron = 40, /turf/closed/mineral/titanium = 11,
		/turf/closed/mineral/gibtonite = 4, /turf/open/floor/plating/asteroid = 2, /turf/closed/mineral/bscrystal = 1)
		//Currently, Adamantine won't spawn as it has no uses. -Durandan
	var/mineralChance = 13
	var/display_icon_state = "rock"
	initial_gas_mix = AIRLESS_ATMOS
	opacity = 1
	density = TRUE
	blocks_air = 1
	layer = EDGED_TURF_LAYER
	temperature = TCMB
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	var/environment_type = "asteroid"
	var/turf/open/floor/plating/turf_type = /turf/open/floor/plating/asteroid/airless
	var/mineralType = null
	var/mineralAmt = 3
	var/spread = 0 //will the seam spread?
	var/spreadChance = 0 //the percentual chance of an ore spreading to the neighbouring tiles
	var/last_act = 0
	var/scan_state = "" //Holder for the image we display when we're pinged by a mining scanner
	var/defer_change = 0

/turf/open/floor/plating/rock/attackby(obj/item/pickaxe/I, mob/user, params)
	var/stored_dir = user.dir
	if (!user.IsAdvancedToolUser())
		to_chat(usr, "<span class='warning'>You don't have the dexterity to do this!</span>")
		return

	if(I.tool_behaviour == TOOL_MINING)
		var/turf/T = user.loc
		if (!isturf(T))
			return

		if(last_act + (40 * I.toolspeed) > world.time)//prevents message spam
			return
		last_act = world.time
		to_chat(user, "<span class='notice'>You start picking...</span>")

		if(I.use_tool(src, user, 40, volume=50))
			var/range = I.digrange //Store the current digrange so people don't cheese digspeed swapping for faster mining
			var/list/dug_tiles = list()
			if(ismineralturf(src))
				if(I.digrange > 0)
					for(var/turf/closed/mineral/M in range(user,range))
						if(get_dir(user,M)&stored_dir)
							M.gets_drilled(user)
							dug_tiles += M
				to_chat(user, "<span class='notice'>You finish cutting into the rock.</span>")
				if(!(src in dug_tiles))
					gets_drilled(user)
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, I.type)
	else
		return attack_hand(user)

/turf/closed/mineral/attack_animal(mob/living/simple_animal/user)
	if((user.environment_smash & ENVIRONMENT_SMASH_WALLS) || (user.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		gets_drilled()
	..()

/turf/open/floor/plating/rock/Initialize()

	mineralSpawnChanceList = typelist("mineralSpawnChanceList", mineralSpawnChanceList)

	if (display_icon_state)
		icon_state = display_icon_state
	. = ..()
	if (prob(mineralChance))
		var/path = pickweight(mineralSpawnChanceList)
		var/turf/T = ChangeTurf(path,null,CHANGETURF_IGNORE_AIR)

		if(T && ismineralturf(T))
			var/turf/closed/mineral/M = T
			M.mineralAmt = rand(1, 5)
			M.environment_type = src.environment_type
			M.turf_type = src.turf_type
			M.baseturfs = src.baseturfs
			src = M
			M.levelupdate()