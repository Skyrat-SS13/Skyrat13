/datum/event_menu
	var/mob/dead/observer/owner

/datum/event_menu/New(mob/dead/observer/new_owner)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner

/datum/event_menu/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.observer_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "event_menu", "Event Menu", 350, 500, master_ui, state)
		ui.open()

/datum/event_menu/ui_data(mob/user)
	var/list/data = list()
	
	if(check_rights(R_ADMIN))
		data["is_admin"] = TRUE

	data["participating"] = user.client.prefs.event_participation
	data["event_preferences"] = user.client.prefs.event_prefs

	return data

/datum/event_menu/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("toggle")
			usr.client.prefs.event_participation = !usr.client.prefs.event_participation
			SEND_SIGNAL(src, COMSIG_EVENTPREF_UPDATE)
		if("set_pref")
			var/new_preference = stripped_multiline_input(usr, "Here you can add what kinds of events you'd \
				like to most be part, and your own ideas for ones you'd like done for yourself, or for \
				the station as a whole.", "Event Preferences", usr.client.prefs.event_prefs, MAX_MESSAGE_LEN)
			usr.client.prefs.event_prefs = new_preference

	owner.client.prefs.save_preferences()
