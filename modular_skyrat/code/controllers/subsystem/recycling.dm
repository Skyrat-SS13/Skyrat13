/obj/recycling_nullspace

//Disgustingly hacky system to remove the GC lag
SUBSYSTEM_DEF(recycling)
	name = "Recycling"
	wait = 1800 //fires once every three minutes.
	var/list/recycled_monkeys = list()
	var/obj/recycling_nullspace/nullspace = new /obj/recycling_nullspace

/datum/controller/subsystem/recycling/Initialize()
	nullspace.forceMove(locate(1,1,1))

/datum/controller/subsystem/recycling/fire()
	//Perhaps pre-initialize stuff here each every tick to get them ready for send off?

/datum/controller/subsystem/recycling/proc/recycle_monkey(/mob/living/carbon/monkey/M)
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
	/var/mob/living/carbon/monkey/M
	if(recycled_monkeys.len == 0)
		M = new /mob/living/carbon/monkey(mapload, cubespawned, spawner)
	else
		M = recycled_monkeys[recycled_monkeys.len]
		recycled_monkeys -= M
		M.fully_heal(admin_revive = TRUE)
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
		
		M.forceMove(mapload)
	return M