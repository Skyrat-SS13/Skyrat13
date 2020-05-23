/datum/event_menu
	var/mob/dead/observer/owner

/datum/event_menu/New(mob/dead/observer/new_owner)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner

/datum/event_menu/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.observer_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "event_menu", "Event Menu", 450, 600, master_ui, state)
		ui.open()

/datum/event_menu/ui_data(mob/user)
	var/list/data = list()
	
	

	return data

/datum/event_menu/ui_act(action, params)
	if(..())
		return

	// switch(action)
	// 	if("jump")
	// 		if(MS)
	// 			owner.forceMove(get_turf(MS))
	// 			. = TRUE
	// 	if("spawn")
	// 		if(MS)
	// 			MS.attack_ghost(owner)
	// 			. = TRUE
