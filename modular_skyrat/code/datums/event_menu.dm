/datum/event_menu
	var/mob/dead/observer/owner
	var/obj/screen/ghost/eventsignup/event_icon
	var/state = "main"

/datum/event_menu/New(mob/dead/observer/new_owner, var/icon)
	if(!istype(new_owner))
		qdel(src)
	owner = new_owner
	event_icon = icon

/datum/event_menu/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.observer_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "event_menu", "Event Menu", 520, 600 , master_ui, state)
		ui.open()

/datum/event_menu/ui_data(mob/user)
	var/list/data = list()

	data["state"] = state
	
	if(check_rights_for(user.client, R_SPAWN))
		data["is_admin"] = TRUE

	switch(state)
		if("main")
			data["participating"] = user.client?.prefs.event_participation
			data["event_preferences"] = user.client?.prefs.event_prefs
		if("admin")
			if (data["is_admin"])
				for(var/mob/M in GLOB.mob_list)
					if (isobserver(M) && M.client?.prefs.event_participation)
						data["participating_observers"] += list(list(
							"ckey" = M.client.ckey,
							"time_played" = M.client.get_exp_living(),
							"prefs" = M.client.prefs.event_prefs,
							"ref" = "[REF(M)]"
						))

	return data

/datum/event_menu/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("toggle")
			usr.client.prefs.event_participation = !usr.client.prefs.event_participation
			event_icon.icon_update()
		if("set_pref")
			var/new_preference = stripped_multiline_input(usr, "Here you can add what kinds of events you'd \
				like to be part of most. Add your own ideas for ones you'd like done for yourself, or for \
				the station as a whole.", "Event Preferences", usr.client.prefs.event_prefs, MAX_MESSAGE_LEN)
			if (new_preference)
				usr.client.prefs.event_prefs = new_preference
		if("show_panel")
			var/mob/to_show = locate(params["ref"])
			usr.client.holder.show_player_panel(to_show)
		if("admin_view_toggle")
			if(check_rights_for(usr.client, R_SPAWN))
				state = "admin"
		if("back")
			state = "main"

	owner.client.prefs.save_preferences()
