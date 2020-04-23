//Disgustingly hacky system to remove the GC lag, dumb games deserve dumb solutions 
SUBSYSTEM_DEF(recycling)
	name = "Recycling"
	wait = 1800 //fires once every three minutes.
	var/list/recycled_monkeys = list()
	var/list/recycled_movable_lighting_objects = list()
	var/list/recycled_slimes = list()
	var/obj/recycling_nullspace/nullspace = new /obj/recycling_nullspace //Yeah I could just not but this way I know how the internals of the system look better

/datum/controller/subsystem/recycling/fire()
	//Perhaps pre-initialize stuff here each every tick to get them ready for send off?

/datum/controller/subsystem/recycling/proc/recycle_monkey(mob)
	var/mob/living/carbon/monkey/M = mob
	if(!M || (M in recycled_monkeys))
		message_admins("Something went terribly wrong with monkey recycling")
		return

	if(M.mind) //Chances are mind monkeys are changeligns or admin memery so lets not fuck with them
		qdel(M)
		return
	//Let's drop the references to it, so far I can think of slime friends
	for(var/mob/living/simple_animal/slime/S in GLOB.mob_living_list)
		S.Friends -= M

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
		for(var/datum/action/A in M.actions)
			A.Remove(M)
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
		M.regenerate_icons()
	return M

/datum/controller/subsystem/recycling/proc/recycle_movable_lighting_object(light_obj, force = TRUE)
	var/atom/movable/lighting_object/LO = light_obj
	if(!LO || (LO in recycled_movable_lighting_objects))
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

/datum/controller/subsystem/recycling/proc/recycle_slime(mob)
	var/mob/living/simple_animal/slime/S = mob
	if(!S || (S in recycled_slimes))
		message_admins("Something went terribly wrong with slimes recycling")
		return

	/*This is called on their death, I guess
	if(S.buckled)
		S.Feedstop(silent = TRUE) //releases ourselves from the mob we fed on.

	S.stat = DEAD
	S.cut_overlays()

	S.update_canmove()
	*/


	GLOB.simple_animals[S.AIStatus] -= S
	if (SSnpcpool.state == SS_PAUSED && LAZYLEN(SSnpcpool.currentrun))
		SSnpcpool.currentrun -= S

	if(S.nest)
		S.nest.spawned_mobs -= S
		S.nest = null

	var/turf/T = get_turf(S)
	if (T && S.AIStatus == AI_Z_OFF)
		SSidlenpcpool.idle_mobs_by_zlevel[T.z] -= S
	//Hey did you know the code above runs 2 times 4nr when a slime is deleted?

	//Living related stuff
	if(LAZYLEN(S.status_effects))
		for(var/se in S.status_effects)
			var/datum/status_effect/SE = se
			if(SE.on_remove_on_mob_delete) //the status effect calls on_remove when its mob is deleted
				qdel(S)
			else
				SE.be_replaced()
	if(S.ranged_ability)
		S.ranged_ability.remove_ranged_ability(S)
	if(S.buckled)
		S.buckled.unbuckle_mob(S,force=1)
	GLOB.mob_living_list -= S
	QDEL_LIST(S.diseases)

	//Mob related stuff
	GLOB.mob_list -= S
	GLOB.dead_mob_list -= S
	GLOB.alive_mob_list -= S
	GLOB.all_clockwork_mobs -= S
	GLOB.mob_directory -= S.tag
	S.focus = null
	S.LAssailant = null
	S.movespeed_modification = null
	for (var/alert in S.alerts)
		S.clear_alert(alert, TRUE)
	if(S.observers && S.observers.len)
		for(var/G in S.observers)
			var/mob/dead/observe = G
			observe.reset_perspective(null)
	qdel(S.hud_used)
	for(var/cc in S.client_colours)
		qdel(cc)
	S.client_colours = null
	S.ghostize()

	S.forceMove(nullspace)
	recycled_slimes += S



/datum/controller/subsystem/recycling/proc/deploy_slime(mapload, new_colour="grey", new_is_adult=FALSE)
	var/mob/living/simple_animal/slime/S 
	if(recycled_slimes.len == 0)
		S = new /mob/living/simple_animal/slime(mapload, new_colour, new_is_adult)
	else
		S = recycled_slimes[recycled_slimes.len]
		//Slime stuff


		S.is_adult = new_is_adult

		for(var/datum/action/A in S.actions)
			A.Remove(S)

		var/datum/action/innate/slime/feed/F = new
		F.Grant(S)

		if(S.is_adult)
			var/datum/action/innate/slime/reproduce/R = new
			R.Grant(S)
			S.health = 200
			S.maxHealth = 200
		else
			var/datum/action/innate/slime/evolve/E = new
			E.Grant(S)
			S.health = 150
			S.maxHealth = 150

		S.set_colour(new_colour)
		//Mob
		GLOB.mob_list += S
		GLOB.mob_directory[tag] = S
		if(S.stat == DEAD)
			GLOB.dead_mob_list += S
		else
			GLOB.alive_mob_list += S
		S.set_focus(S)
		S.prepare_huds()
		for(var/v in GLOB.active_alternate_appearances)
			if(!v)
				continue
			var/datum/atom_hud/alternate_appearance/AA = v
			AA.onNewMob(S)
		//S.nutrition = rand(NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_START_MAX)
		S.update_config_movespeed()
		S.update_movespeed(TRUE)
		hook_vr("mob_new",list(S))

		//Living
		GLOB.mob_living_list += S

		//simple animal
		GLOB.simple_animals[S.AIStatus] += S
		S.update_simplemob_varspeed()

		//again, slime
		S.nutrition = 700

		S.mutation_chance = 30
		S.cores = 1

		S.powerlevel = 0
		S.number = 0

		S.Friends = list()
		S.attacked = 0
		S.rabid = 0
		S.holding_still = 0
		S.target_patience = 0

		S.mood = ""
		S.mutator_used = FALSE
		S.force_stasis = FALSE

		S.effectmod = null
		S.applied = 0 

		recycled_slimes -= S
		S.forceMove(mapload)
		S.revive(full_heal = TRUE, admin_revive = TRUE)
		S.regenerate_icons()
		S.update_name()
	return S

/obj/recycling_nullspace
