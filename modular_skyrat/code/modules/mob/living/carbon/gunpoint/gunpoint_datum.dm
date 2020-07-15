/obj/effect/overlay/gunpoint_effect
	icon = 'modular_skyrat/icons/mob/targeted.dmi'
	icon_state = "locking"
	layer = FLY_LAYER
	plane = GAME_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	mouse_opacity = 0

/datum/gunpoint
	var/mob/living/source
	var/mob/living/target
	var/datum/radial_menu/gunpoint/gunpoint_gui
	var/allow_move = FALSE
	var/allow_radio = FALSE
	var/allow_use = FALSE

	var/obj/item/gun/aimed_gun

	var/safeguard_time = 0
	var/next_autoshot = 0
	var/locked = FALSE
	var/was_running = FALSE

	var/moved_counter = 0

	var/static/radio_forbid = image(icon = 'modular_skyrat/icons/mob/radial_gunpoint.dmi', icon_state = "radial_radio_forbid")
	var/static/radio_allow = image(icon = 'modular_skyrat/icons/mob/radial_gunpoint.dmi', icon_state = "radial_radio")
	var/static/use_forbid = image(icon = 'modular_skyrat/icons/mob/radial_gunpoint.dmi', icon_state = "radial_use_forbid")
	var/static/use_allow = image(icon = 'modular_skyrat/icons/mob/radial_gunpoint.dmi', icon_state = "radial_use")
	var/static/move_forbid = image(icon = 'modular_skyrat/icons/mob/radial_gunpoint.dmi', icon_state = "radial_move_forbid")
	var/static/move_allow = image(icon = 'modular_skyrat/icons/mob/radial_gunpoint.dmi', icon_state = "radial_move")

/datum/gunpoint/New(user, tar, gun)
	source = user
	source.gunpointing = src
	target = tar
	target.gunpointed += src
	aimed_gun = gun

	source.face_atom(target)
	source.visible_message("<span class='danger'>[source.name] aims at [target.name] with the [aimed_gun.name]!</span>")

	was_running = (source.m_intent == MOVE_INTENT_RUN)
	if(was_running)
		source.toggle_move_intent()
	ADD_TRAIT(source, TRAIT_NORUNNING, "gunpoint")

	if(!target.gp_effect)
		target.gp_effect = new
		target.vis_contents += target.gp_effect

	RegisterSignal(target, COMSIG_MOVABLE_MOVED, .proc/MovedReact)
	RegisterSignal(source, COMSIG_MOVABLE_MOVED, .proc/SourceMoved)

	//RegisterSignal(source, COMSIG_LIVING_GUN_PROCESS_FIRE, .proc/Destroy)
	RegisterSignal(target, COMSIG_LIVING_GUN_PROCESS_FIRE, .proc/UseReact)

	RegisterSignal(source, COMSIG_LIVING_STATUS_STUN, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_STATUS_KNOCKDOWN, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_STATUS_PARALYZE, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_UPDATED_MOBILITY, .proc/SourceUpdatedMobility)

	RegisterSignal(aimed_gun, COMSIG_ITEM_EQUIPPED,.proc/ClickDestroy)
	RegisterSignal(aimed_gun, COMSIG_ITEM_DROPPED,.proc/ClickDestroy)

	RegisterSignal(target, COMSIG_MOVABLE_RADIO_TALK_INTO,.proc/RadioReact)

	RegisterSignal(target, COMSIG_MOB_ITEM_ATTACK, .proc/UseReact)
	RegisterSignal(target, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, .proc/MeleeAttackReact)
	RegisterSignal(target, COMSIG_MOB_ITEM_ATTACK_SELF, .proc/UseReact)
	RegisterSignal(target, COMSIG_MOB_ITEM_AFTERATTACK, .proc/UseReact)

	RegisterSignal(target, COMSIG_PARENT_QDELETING, .proc/Destroy)
	RegisterSignal(source, COMSIG_PARENT_QDELETING, .proc/Destroy)


	addtimer(CALLBACK(src, .proc/LockOn), 7)

/datum/gunpoint/proc/MeleeAttackReact(datum/source_datum, atom/target)
	if(!CheckContinuity())
		Destroy()
		return
	if(!allow_use && CanReact())
		source.log_message("[source] shot [target] because they attacked/disarmed/pulled", LOG_ATTACK)
		to_chat(source, "<span class='warning'>You pull the trigger instinctively to [target.name] actions!</span>")
		ShootTarget()

/datum/gunpoint/proc/LockOn()
	if(src) //if we're not present then locking on failed and this datum is deleted
		if(!CheckContinuity())
			Destroy()
			return
		locked = TRUE
		log_combat(target, source, "locked onto with aiming")
		playsound(get_turf(source), 'modular_skyrat/sound/effects/targeton.ogg', 50,1)
		to_chat(source, "<span class='boldnotice'>You lock onto [target.name]!</span>")
		target.visible_message("<span class='boldwarning'>[source.name] holds [target.name] at gunpoint with the [aimed_gun.name]!</span>", "<span class='userdanger'>[source.name] holds you at gunpoint with the [aimed_gun.name]!</span>")
		if(target.gunpointed.len == 1)//First case
			to_chat(target, "<span class='danger'>You'll <b>get shot</b> if you <b>use radio</b>, <b>move</b> or <b>interact with items</b>!</span>")
			to_chat(target, "<span class='notice'>You can however take items out, toss harmless items or drop them.</span>")
		var/list/choice_list = ConstructChoiceList()
		gunpoint_gui = show_radial_menu_gunpoint(source, target , choice_list, select_proc = CALLBACK(src, .proc/GunpointGuiReact, source), radius = 42)
		if(target.gp_effect.icon_state != "locked")
			target.gp_effect.icon_state = "locked"
		safeguard_time = world.time + 30

/datum/gunpoint/proc/CheckContinuity()
	if(!target)
		return FALSE
	if(source.CanGunpointAt(target))
		source.face_atom(target)
		return TRUE
	return FALSE

/datum/gunpoint/proc/CanReact()
	if(locked && (world.time >= safeguard_time) && !(target.combat_flags & COMBAT_FLAG_HARD_STAMCRIT) && !target.InCritical() && source.next_move <= world.time && next_autoshot <= world.time)
		return TRUE
	return FALSE

/datum/gunpoint/Destroy()
	UnregisterSignal(target, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

	//UnregisterSignal(source, COMSIG_LIVING_GUN_PROCESS_FIRE)
	UnregisterSignal(target, COMSIG_LIVING_GUN_PROCESS_FIRE)

	UnregisterSignal(source, COMSIG_LIVING_STATUS_STUN)
	UnregisterSignal(source, COMSIG_LIVING_STATUS_KNOCKDOWN)
	UnregisterSignal(source, COMSIG_LIVING_STATUS_PARALYZE)
	UnregisterSignal(source, COMSIG_LIVING_UPDATED_MOBILITY)

	UnregisterSignal(aimed_gun, COMSIG_ITEM_EQUIPPED)
	UnregisterSignal(aimed_gun, COMSIG_ITEM_DROPPED)

	UnregisterSignal(target, COMSIG_MOVABLE_RADIO_TALK_INTO)

	UnregisterSignal(target, COMSIG_MOB_ITEM_ATTACK)
	UnregisterSignal(target, COMSIG_HUMAN_MELEE_UNARMED_ATTACK)
	UnregisterSignal(target, COMSIG_MOB_ITEM_ATTACK_SELF)
	UnregisterSignal(target, COMSIG_MOB_ITEM_AFTERATTACK)

	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	UnregisterSignal(source, COMSIG_PARENT_QDELETING)

	REMOVE_TRAIT(source, TRAIT_NORUNNING, "gunpoint")
	if(was_running)
		source.toggle_move_intent()
	if(target.gunpointed.len == 1) //Last instance being deleted
		target.vis_contents -= target.gp_effect
		QDEL_NULL(target.gp_effect)
	target.gunpointed -= src
	source.gunpointing = null
	if(locked)
		QDEL_NULL(gunpoint_gui)
		target.visible_message("<span class='notice'>[source.name] no longer holds [target.name] at gunpoint.</span>", "<span class='boldnotice'>[source.name] no longer holds you at gunpoint.</span>")
	source = null
	target = null
	aimed_gun = null
	return ..()

/datum/gunpoint/proc/ClickDestroy()
	if(locked)
		playsound(get_turf(source), 'modular_skyrat/sound/effects/targetoff.ogg', 50,1)
	Destroy()

/datum/gunpoint/proc/SourceCC(datum/source, amount, update, ignore)
	if(amount && !ignore)
		Destroy()

/datum/gunpoint/proc/ShootTarget()
	next_autoshot = world.time + 5
	log_combat(target, source, "auto-shot with aim")
	aimed_gun.process_afterattack(target, source)

/datum/gunpoint/proc/RadioReact(datum/datum_source, obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)
	if(!allow_radio && CanReact())
		if(direct)
			source.log_message("[source] shot [target] because they spoke on radio", LOG_ATTACK)
			to_chat(source, "<span class='warning'>You pull the trigger instinctively as [target.name] speaks on the radio!</span>")
			ShootTarget()

/datum/gunpoint/proc/MovedReact(datum/datum_source, atom/moved, direction, forced)
	if(!CheckContinuity())
		Destroy()
		return
	if(!allow_move && CanReact() && !(target.pulledby && target.pulledby == source)) //Don't shoot him if we're pulling them
		MovedShootProc()

/datum/gunpoint/proc/MovedShootProc() //This exists in case of someone moving several tiles in one tick, such as dashes or diagonal movement
	moved_counter += 1
	var/count = moved_counter
	sleep(1)
	if(src && count == moved_counter)
		source.log_message("[source] shot [target] because they moved", LOG_ATTACK)
		ShootTarget()

/datum/gunpoint/proc/UseReact(datum/datum_source)
	if(!CheckContinuity())
		Destroy()
		return
	if(!allow_use && CanReact())
		source.log_message("[source] shot [target] because they used an item", LOG_ATTACK)
		to_chat(source, "<span class='warning'>You pull the trigger instinctively as [target.name] uses an item!</span>")
		ShootTarget()

/datum/gunpoint/proc/SourceMoved(datum/datum_source)
	if(!CheckContinuity())
		Destroy()

/datum/gunpoint/proc/SourceUpdatedMobility()
	if(!(CHECK_MOBILITY(source, MOBILITY_STAND)))
		Destroy()

/datum/gunpoint/proc/ConstructChoiceList()
	var/image/radio_image = (allow_radio ? radio_allow : radio_forbid)
	var/image/use_image = (allow_use ? use_allow : use_forbid)
	var/image/move_image = (allow_move ? move_allow : move_forbid)
	var/list/L = list("radio" = radio_image, "use" = use_image, "move" = move_image)
	return L

/datum/gunpoint/proc/GunpointGuiReact(mob/living/user,choice)
	switch(choice)
		if("radio")
			allow_radio = !allow_radio
			if(allow_radio)
				var/safe = TRUE
				for(var/datum/gunpoint/gp in target.gunpointed)
					if(gp.allow_radio == FALSE)
						safe = FALSE
						break
				if(safe)
					to_chat(target, "<span class='notice'>[source.name] signals you can <b>use radio</b>.</span>")
				else
					to_chat(target, "<span class='danger'>[source.name] signals you can use radio, however other people still don't</span>")
			else
				var/forbid_counts = 0
				for(var/datum/gunpoint/gp in target.gunpointed)
					if(gp.allow_radio == FALSE)
						forbid_counts += 1
				if(forbid_counts == 1) //Only first one warns the victim
					to_chat(target, "<span class='danger'>[source.name] signals you can't <b>use radio</b>.</span>")
		if("use")
			allow_use = !allow_use
			if(allow_use)
				var/safe = TRUE
				for(var/datum/gunpoint/gp in target.gunpointed)
					if(gp.allow_use == FALSE)
						safe = FALSE
						break
				if(safe)
					to_chat(target, "<span class='notice'>[source.name] signals you can <b>interact with items</b>.</span>")
				else
					to_chat(target, "<span class='danger'>[source.name] signals you can interact with items, however other people still don't</span>")
			else
				var/forbid_counts = 0
				for(var/datum/gunpoint/gp in target.gunpointed)
					if(gp.allow_use == FALSE)
						forbid_counts += 1
				if(forbid_counts == 1) //Only first one warns the victim
					to_chat(target, "<span class='danger'>[source.name] signals you can't <b>interact with items</b>.</span>")
		if("move")
			allow_move = !allow_move
			if(allow_move)
				var/safe = TRUE
				for(var/datum/gunpoint/gp in target.gunpointed)
					if(gp.allow_move == FALSE)
						safe = FALSE
						break
				if(safe)
					to_chat(target, "<span class='notice'>[source.name] signals you can <b>move</b>.</span>")
				else
					to_chat(target, "<span class='danger'>[source.name] signals you can move, however other people still don't</span>")
			else
				var/forbid_counts = 0
				for(var/datum/gunpoint/gp in target.gunpointed)
					if(gp.allow_move == FALSE)
						forbid_counts += 1
				if(forbid_counts == 1) //Only first one warns the victim
					to_chat(target, "<span class='danger'>[source.name] signals you can't <b>move</b>.</span>")
	var/list/new_choices = ConstructChoiceList()
	gunpoint_gui.entry_animation = FALSE
	gunpoint_gui.change_choices(new_choices,FALSE)