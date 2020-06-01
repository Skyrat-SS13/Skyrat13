/datum/gunpoint
	var/mob/living/carbon/source
	var/mob/target
	var/datum/radial_menu/gunpoint/gunpoint_gui
	var/allow_move = FALSE
	var/allow_radio = FALSE
	var/allow_use = FALSE

	var/obj/item/gun/aimed_gun

	var/image/aim_image

	var/safeguard_time = 0
	var/locked = FALSE
	var/was_running = FALSE

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

	aim_image = image('modular_skyrat/icons/mob/targeted.dmi', target, "locking", FLY_LAYER)
	if(source.client)
		source.client.images += aim_image

	source.face_atom(target)

	was_running = (source.m_intent == MOVE_INTENT_RUN)
	ADD_TRAIT(source, TRAIT_NORUNNING, "gunpoint")
	if(was_running)
		source.toggle_move_intent()

	RegisterSignal(target, COMSIG_MOVABLE_MOVED, .proc/MovedReact)
	RegisterSignal(source, COMSIG_MOVABLE_MOVED, .proc/SourceMoved)

	RegisterSignal(source, COMSIG_LIVING_GUN_PROCESS_FIRE, .proc/Destroy)
	RegisterSignal(target, COMSIG_LIVING_GUN_PROCESS_FIRE, .proc/UseReact)

	RegisterSignal(source, COMSIG_LIVING_STATUS_STUN, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_STATUS_KNOCKDOWN, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_STATUS_PARALYZE, .proc/SourceCC)

	RegisterSignal(aimed_gun, COMSIG_ITEM_EQUIPPED,.proc/ClickDestroy)
	RegisterSignal(aimed_gun, COMSIG_ITEM_DROPPED,.proc/ClickDestroy)

	addtimer(CALLBACK(src, .proc/LockOn), 10)

/datum/gunpoint/proc/LockOn()
	if(src) //if we're not present then locking on failed and this datum is deleted
		if(!CheckContinuity())
			Destroy()
			return
		locked = TRUE
		playsound(get_turf(source), 'modular_skyrat/sound/effects/targeton.ogg', 50,1)
		var/list/choice_list = ConstructChoiceList()
		gunpoint_gui = show_radial_menu_gunpoint(source, target , choice_list, select_proc = CALLBACK(src, .proc/GunpointGuiReact, source), radius = 42)
		aim_image.icon_state = "locked"

/datum/gunpoint/proc/CheckContinuity()
	if(!target)
		return FALSE
	return (source.CanGunpointAt(M))

/datum/gunpoint/Destroy()
	UnregisterSignal(target, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(source, COMSIG_MOVABLE_MOVED)

	UnregisterSignal(source, COMSIG_LIVING_GUN_PROCESS_FIRE)
	UnregisterSignal(target, COMSIG_LIVING_GUN_PROCESS_FIRE)

	UnregisterSignal(source, COMSIG_LIVING_STATUS_STUN)
	UnregisterSignal(source, COMSIG_LIVING_STATUS_KNOCKDOWN)
	UnregisterSignal(source, COMSIG_LIVING_STATUS_PARALYZE)

	UnregisterSignal(aimed_gun, COMSIG_ITEM_EQUIPPED)
	UnregisterSignal(aimed_gun, COMSIG_ITEM_DROPPED)

	if(source.client)
		source.client.images -= aim_image
	QDEL_NULL(aim_image)

	REMOVE_TRAIT(source, TRAIT_NORUNNING, "gunpoint")
	if(was_running)
		source.toggle_move_intent()
	target.gunpointed -= src
	source.gunpointing = null
	if(locked)
		QDEL_NULL(gunpoint_gui)
	return ..()

/datum/gunpoint/proc/ClickDestroy()
	if(locked)
		playsound(get_turf(source), 'modular_skyrat/sound/effects/targetoff.ogg', 50,1)
	Destroy()

/datum/gunpoint/proc/SourceCC(amount, update, ignore)
	if(amount && !ignore)
		ClickDestroy()

/datum/gunpoint/proc/ShootTarget()
	if(!locked)
		return

/datum/gunpoint/proc/RadioReact(datum/source)
	if(!allow_radio && locked)
		ShootTarget()

/datum/gunpoint/proc/MovedReact(datum/source)
	if(!CheckContinuity())
		Destroy()
		return
	if(!allow_move && locked)
		ShootTarget()

/datum/gunpoint/proc/UseReact(datum/source)
	if(!CheckContinuity())
		Destroy()
		return
	if(!allow_use && locked)
		ShootTarget()

/datum/gunpoint/proc/SourceMoved(datum/source)
	if(!CheckContinuity())
		Destroy()

/datum/gunpoint/proc/ConstructChoiceList()
	var/image/radio_image = (allow_radio ? radio_allow : radio_forbid)
	var/image/use_image = (allow_use ? use_allow : use_forbid)
	var/image/move_image = (allow_move ? move_allow : move_forbid)
	var/list/L = list("radio" = radio_image, "use" = use_image, "move" = move_image)
	return L

/datum/gunpoint/proc/GunpointGuiReact(mob/living/carbon/user,choice)
	switch(choice)
		if("radio")
			allow_radio = !allow_radio
		if("use")
			allow_use = !allow_use
		if("move")
			allow_move = !allow_move
	var/list/new_choices = ConstructChoiceList()
	gunpoint_gui.entry_animation = FALSE
	gunpoint_gui.change_choices(new_choices,FALSE)