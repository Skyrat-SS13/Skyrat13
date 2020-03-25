/atom/recycling_nullspace

//Disgustingly hacky system to remove the GC lag
SUBSYSTEM_DEF(recycling)
	name = "Recycling"
	wait = 1800 //fires once every three minutes.
	var/list/recycled_monkeys = list()
	var/atom/recycling_nullspace/nullspace = new /atom/recycling_nullspace

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
	if(ranged_ability)
		M.ranged_ability.remove_ranged_ability(src)
	if(buckled)
		M.buckled.unbuckle_mob(src,force=1)
	GLOB.mob_living_list -= src
	QDEL_LIST(diseases)

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
		clear_alert(alert, TRUE)
	if(M.observers && M.observers.len)
		for(var/M in observers)
			var/mob/dead/observe = M
			observe.reset_perspective(null)
	qdel(M.hud_used)
	for(var/cc in M.client_colours)
		qdel(cc)
	M.client_colours = null
	M.ghostize()

	//Recycling related stuff
	recycled_monkeys += M
	M.forceMove(nullspace)

/datum/controller/subsystem/recycling/proc/deploy_monkey(/mob/living/carbon/monkey/M)