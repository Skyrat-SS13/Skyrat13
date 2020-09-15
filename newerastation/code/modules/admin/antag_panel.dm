/client/proc/open_team_panel()
	set category = "Admin"
	set name = "Check Teams"

	if(!check_rights(R_ADMIN))
		return

	if(!SSticker.HasRoundStarted())
		alert("The game hasn't started yet!")
		return

	GLOB.team_panel.ui_interact(usr)

GLOBAL_DATUM_INIT(team_panel, /datum/teampanel, new)

/datum/teampanel

/datum/teampanel/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.admin_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "TeamPanel", "Team Panel", 700, 700, master_ui, state)
		ui.open()


/datum/teampanel/ui_data(mob/user)
	. = list()
	var/teams = list()
	for(var/datum/team/T in GLOB.antagonist_teams)
		if(!T.members)
			continue
		var/team = list()
		team["ref"] = REF(T)
		team["name"] = T.antag_listing_name()
		team["members"] = T.tgui_team_panel_members()
		team["extrainfo"] = T.tgui_team_panel_extra_info()
		var/objectives = list() //remember, field access is slow.
		for(var/datum/objective/O in T.objectives)
			var/objective = list()
			objective["ref"] = REF(O)
			objective["index"] = (LAZYLEN(objectives)+1)
			objective["explanation_text"] = (O.team_explanation_text || O.explanation_text)
			objective["completed"] = O.completed
			objectives += list(objective)
		team["objectives"] = objectives

		teams += list(team)

	.["teams"] = teams

// ...What? Did you really think I was gonna rework the entirety
// of Antag and Team code just to get this UI working?
// Well... Maybe one day. -Trigg
/datum/teampanel/ui_act(action, list/params)
	if(..())
		return

	/*
	This is Trigg's incredibly duct-taped way to resolve Topic calls from
 	the already duct-taped way of getting any sort of info to tgui
	Because I couldn't get JS to behave well enough.
	Yes, this is my way of saying "I suck at JS"
	I mean, what you gonna do? I'm the only one who's bothered to tackle this UI in months.
	*/
	switch(action)
		if("admin_topic")
			usr.client.holder.Topic("teampanel_uiact", params)
		if("client_topic")
			usr.client.Topic("teampanel_uiact", params)

	var/datum/team/T = locate(params["team"])
	if(istype(T))
		T.traitor_panel_ui_act(action, params)
