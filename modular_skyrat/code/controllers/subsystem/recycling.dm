/obj/recycling_nullspace

//Disgustingly hacky system to remove the GC lag, dumb games deserve dumb solutions
SUBSYSTEM_DEF(recycling)
	name = "Recycling"
	wait = 1800 //fires once every three minutes.
	var/list/recycled_monkeys = list()
	var/list/recycled_movable_lighting_objects = list()
	var/list/recycled_slimes = list()
	var/obj/recycling_nullspace/nullspace = new /obj/recycling_nullspace

/datum/controller/subsystem/recycling/Initialize()
	//nullspace.forceMove(locate(1,1,1))

/datum/controller/subsystem/recycling/fire()
	//Perhaps pre-initialize stuff here each every tick to get them ready for send off?

/datum/controller/subsystem/recycling/proc/recycle_monkey(mob)
	var/mob/living/carbon/monkey/M = mob
	if(!M || M in recycled_monkeys)
		message_admins("Something went terribly wrong with monkey recycling")
		return

	//Monkey related stuff
	SSmobs.cubemonkeys -= M

	//Carbon related stuff NOT SURE IF I AM TO REMOVE ORGANS/BODYPARTS/DNA HERE OR JUST DO SOME CHECKS ALONG THE WAY
	GLOB.carbon_list -= M
	QDEL_LIST(M.stomach_contents)
	QDEL_LIST(M.implants)
	M.remove_from_all_data_huds()

	//Living related stuff
	if(LAZYLEN(M.status_effects))
		for(var/s in M.status_effects)
			var/datum/status_effect/S = s
			if(S.on_remove_on_mob_delete) //the status effect calls on_remove when its mob is deleted
				qdel(S)
			else
				S.be_replaced()
	if(M.ranged_ability)
		M.ranged_ability.remove_ranged_ability(M)
	if(M.buckled)
		M.buckled.unbuckle_mob(M,force=1)
	GLOB.mob_living_list -= M
	QDEL_LIST(M.diseases)

	//Mob related stuff
	GLOB.mob_list -= M
	GLOB.dead_mob_list -= M
	GLOB.alive_mob_list -= M
	GLOB.all_clockwork_mobs -= M
	GLOB.mob_directory -= M.tag
	M.focus = null
	M.LAssailant = null
	M.movespeed_modification = null
	for (var/alert in M.alerts)
		M.clear_alert(alert, TRUE)
	if(M.observers && M.observers.len)
		for(var/G in M.observers)
			var/mob/dead/observe = G
			observe.reset_perspective(null)
	qdel(M.hud_used)
	for(var/cc in M.client_colours)
		qdel(cc)
	M.client_colours = null
	M.ghostize()

	//Recycling related stuff
	recycled_monkeys += M
	M.forceMove(nullspace)

/datum/controller/subsystem/recycling/proc/deploy_monkey(mapload, cubespawned=FALSE, mob/spawner)
	var/mob/living/carbon/monkey/M
	if (cubespawned)
		var/cap = CONFIG_GET(number/monkeycap)
		if (LAZYLEN(SSmobs.cubemonkeys) > cap)
			if (spawner)
				to_chat(spawner, "<span class='warning'>Bluespace harmonics prevent the spawning of more than [cap] monkeys on the station at one time!</span>")
			return


	if(recycled_monkeys.len == 0)
		M = new /mob/living/carbon/monkey(mapload, cubespawned, spawner)
	else
		M = recycled_monkeys[recycled_monkeys.len]
		recycled_monkeys -= M
		//M.fully_heal(admin_revive = TRUE)
		//Init procs
		//Mob
		GLOB.mob_list += M
		GLOB.mob_directory[tag] = M
		if(M.stat == DEAD)
			GLOB.dead_mob_list += M
		else
			GLOB.alive_mob_list += M
		M.set_focus(M)
		M.prepare_huds()
		for(var/v in GLOB.active_alternate_appearances)
			if(!v)
				continue
			var/datum/atom_hud/alternate_appearance/AA = v
			AA.onNewMob(M)
		M.nutrition = rand(NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_START_MAX)
		M.update_config_movespeed()
		M.update_movespeed(TRUE)
		hook_vr("mob_new",list(M))

		//Living
		GLOB.mob_living_list += M

		//Carbon
		GLOB.carbon_list += M
		M.update_body_parts()

		//Monky
		if(cubespawned)
			SSmobs.cubemonkeys += M
		M.create_dna(M)
		M.dna.initialize_dna(random_blood_type())
		
		M.a_intent_change(INTENT_HELP)
		M.enemies = list()
		M.pickupTimer = 0
		M.resisting = FALSE
		M.aggressive = 0
		M.frustration = 0
		M.mode = MONKEY_IDLE
		M.forceMove(mapload)
		M.revive(full_heal = TRUE, admin_revive = TRUE)
		M.set_resting(FALSE, TRUE)
	return M

/datum/controller/subsystem/recycling/proc/recycle_movable_lighting_object(light_obj, force = TRUE)
	var/atom/movable/lighting_object/LO = light_obj
	if(!LO || LO in recycled_movable_lighting_objects)
		message_admins("Something went terribly wrong with light obj recycling")
		return

	GLOB.lighting_update_objects -= LO
	if (LO.loc != LO.myturf)
		var/turf/oldturf = get_turf(LO.myturf)
		var/turf/newturf = get_turf(LO.loc)
		stack_trace("A lighting object was recycled with a different loc then it is suppose to have ([COORD(oldturf)] -> [COORD(newturf)])")
	if (isturf(LO.myturf))
		LO.myturf.lighting_object = null
		LO.myturf.luminosity = 1
	LO.myturf = null

	//I've peered over destroy() on atom and atom/movable but it seemed like nothing related was happening

	recycled_movable_lighting_objects += LO
	LO.forceMove(nullspace)

/datum/controller/subsystem/recycling/proc/deploy_movable_lighting_object(mapload)
	var/atom/movable/lighting_object/LO
	if(recycled_movable_lighting_objects.len == 0)
		LO = new /atom/movable/lighting_object(mapload)
	else
		LO = recycled_movable_lighting_objects[recycled_movable_lighting_objects.len]
		LO.color = LIGHTING_BASE_MATRIX
		LO.forceMove(get_turf(mapload))
		LO.loc = get_turf(mapload)
		LO.myturf = LO.loc
		if(LO.myturf.lighting_object)
			recycle_movable_lighting_object(LO.myturf.lighting_object) //hello darkness my old friend
		LO.myturf.lighting_object = LO
		LO.myturf.luminosity = 0
		LO.needs_update = TRUE
		GLOB.lighting_update_objects += LO


		for(var/turf/open/space/S in RANGE_TURFS(1, LO)) //RANGE_TURFS is in code\__HELPERS\game.dm
			S.update_starlight()

		if (LO.light_power && LO.light_range)
			LO.update_light()

		recycled_movable_lighting_objects -= LO
	return LO