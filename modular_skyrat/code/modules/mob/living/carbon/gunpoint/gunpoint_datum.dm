/datum/gunpoint
	var/mob/living/carbon/source
	var/mob/target
	var/datum/radial_menu/persistent/gunpoint_gui
	var/allow_move = FALSE
	var/allow_radio = FALSE
	var/allow_use = FALSE

	var/obj/item/gun/aimed_gun

	var/locked_time = 0
	var/was_running = FALSE

	var/static/radio_forbid = image(icon = 'modular_skyrat/icons/mob/radial.dmi', icon_state = "radial_radio_forbid")
	var/static/radio_allow = image(icon = 'modular_skyrat/icons/mob/radial.dmi', icon_state = "radial_radio")
	var/static/use_forbid = image(icon = 'modular_skyrat/icons/mob/radial.dmi', icon_state = "radial_use_forbid")
	var/static/use_allow = image(icon = 'modular_skyrat/icons/mob/radial.dmi', icon_state = "radial_use")
	var/static/move_forbid = image(icon = 'modular_skyrat/icons/mob/radial.dmi', icon_state = "radial_move_forbid")
	var/static/move_allow = image(icon = 'modular_skyrat/icons/mob/radial.dmi', icon_state = "radial_move")

/datum/gunpoint/New(user, tar, gun)
	source = user
	source.gunpointing = src
	target = tar
	target.gunpointed += src
	aimed_gun = gun

	was_running = (source.m_intent == MOVE_INTENT_RUN)
	ADD_TRAIT(source, TRAIT_NORUNNING, "gunpoint")
	if(was_running)
		source.toggle_move_intent()

	playsound(get_turf(source), 'modular_skyrat/sound/effects/targeton.ogg', 50,1)
	var/list/choice_list = ConstructChoiceList()
	gunpoint_gui = show_radial_menu_persistent(source, target , choice_list, select_proc = CALLBACK(src, .proc/GunpointGuiReact, source), radius = 42)
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, .proc/MovedReact)
	RegisterSignal(source, COMSIG_MOVABLE_MOVED, .proc/SourceMoved)

	RegisterSignal(source, COMSIG_LIVING_GUN_PROCESS_FIRE, .proc/Destroy)
	RegisterSignal(target, COMSIG_LIVING_GUN_PROCESS_FIRE, .proc/UseReact)

	RegisterSignal(source, COMSIG_LIVING_STATUS_STUN, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_STATUS_KNOCKDOWN, .proc/SourceCC)
	RegisterSignal(source, COMSIG_LIVING_STATUS_PARALYZE, .proc/SourceCC)

	RegisterSignal(aimed_gun, COMSIG_ITEM_EQUIPPED,.proc/ClickDestroy)
	RegisterSignal(aimed_gun, COMSIG_ITEM_DROPPED,.proc/ClickDestroy)

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

	REMOVE_TRAIT(source, TRAIT_NORUNNING, "gunpoint")
	if(was_running)
		source.toggle_move_intent()
	target.gunpointed -= src
	source.gunpointing = null
	QDEL_NULL(gunpoint_gui)
	return ..()

/datum/gunpoint/proc/ClickDestroy()
	playsound(get_turf(source), 'modular_skyrat/sound/effects/targetoff.ogg', 50,1)
	Destroy()

/datum/gunpoint/proc/SourceCC(amount, update, ignore)
	if(amount && !ignore)
		ClickDestroy()

/datum/gunpoint/proc/ShootTarget()

/datum/gunpoint/proc/MovedReact(datum/source)
	if(!allow_move)
		ShootTarget()

/datum/gunpoint/proc/UseReact(datum/source)
	if(!allow_use)
		ShootTarget()

/datum/gunpoint/proc/SourceMoved(datum/source)

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