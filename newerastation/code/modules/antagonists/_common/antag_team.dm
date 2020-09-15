/////////////////////////////////
//    TGUI TEAM PANEL PROCS    //
/////////////////////////////////

/datum/team/proc/tgui_team_panel_extra_info()

	/*
	Good day, future coder.
	Here, since I'm feeling nice today,
	have an example covering most stuff you can feed to the tgui in this proc.
	It is checked every time the UI updates, so try to not put laggy stuff here.
	You should STILL read tgui-next/packages/tgui/interfaces/TeamPanel.js

	. = list()
	// Tgui isn't really a fan of HTML tags in input text, so...
	// Improvise. Adapt. Overcome. It's a mess.
	. += TGUI_ANTAGLISTING_TEXT("GET THAT FOOKEN DISK")
	// Need to escape linebreaks because the preprocessor is dumb
	. += TGUI_ANTAGLISTING_BUTTON(\
		"content"="click me daddy",\
		"color"="pink",\
		"icon"="brain",\
		"iconRotation"=45,\
		iconSpin=TRUE,\
		title="ohhh yes",\
		action="tele_dat_disk_to_me",\
		params=list(target="REF(DISK)"),\
		)
		// In case you haven't noticed, you don't
		// even need to wrap any of these in quotation marks


	. += TGUI_ANTAGLISTING_BR

	. += TGUI_ANTAGLISTING_TEXT("Oh yes this is bold, italic, large, and red", list(
		"bold" = TRUE,
		"italic" = TRUE,
		"size" = 5,
		"color" = "red", // can be #ff0000 too
		))
	*/
	
	return

/datum/team/proc/tgui_team_panel_members()
	. = list()
	for(var/datum/antagonist/A in get_team_antags())
		. += list(A.team_panel_entry()+team_panel_member_suffix(A))

/*
Made with the intent to allow for passing the ref of the team to params,
every member entry is appended with this to finish it off.
Finishing off with at least a TGUI_ANTAGLISTING_BR is highly reccomended.

You could actually only use this and not have a team panel entry for the antag datum at all.
That is, if you're 100% sure your team will be made up of the same exact antag type.
Or something. Look, just use whatever you want, ok? I'm not a cop.
*/
/datum/team/proc/team_panel_member_suffix(datum/antagonist/A)
	. = list()
	. += TGUI_ANTAGLISTING_BR


//////////////////////////
//  COMMANDS AND PROCS  //
//////////////////////////
/datum/team/proc/traitor_panel_ui_act(action, params)
	switch(action)
		// The team itself
		if("rename")
			admin_rename(usr)
		if("communicate")
			admin_communicate(usr)
		if("delete")
			admin_delete(usr)

		// Objectives
		if("add_objective")
			admin_add_objective(usr)
		if("edit_objective")
			var/datum/objective/O = locate(params["target"])
			if(O)
				admin_edit_objective(usr, O)
		if("remove_objective")
			var/datum/objective/O = locate(params["target"])
			if(O)
				admin_remove_objective(usr, O)
		if("toggle_completion")
			var/datum/objective/O = locate(params["target"])
			if(O)
				admin_objective_completion(usr, O)
		if("check_completion")
			var/datum/objective/O = locate(params["target"])
			if(O)
				var/status = "<b><font color='red'>NOT COMPLETE</font></b>"
				if(O.completed || O.check_completion())
					status = "<b><font color='green'>COMPLETE</font></b>"
				to_chat(usr, "This objective is currently considered [status].")

//Most code below this point has been yoinked from BeeStation
/datum/team/proc/admin_rename(mob/user)
	var/old_name = name
	var/team_name = stripped_input(user,"New Team name?","Team rename",old_name)
	if(!team_name)
		return
	name = team_name
	message_admins("[key_name_admin(usr)] renamed [old_name] team to [name]")
	log_admin("[key_name(usr)] renamed [old_name] team to [name]")

/datum/team/proc/admin_communicate(mob/user)
	var/message = input(user,"Message for the team? HTML tags and embeds are supported.","Team Message") as text|null
	if(!message)
		return
	for(var/datum/mind/M in members)
		to_chat(M.current,message)

	message_admins("[key_name_admin(usr)] messaged [name] team with: [message]")
	log_admin("Team Message: [key_name(usr)] -> [name] team: [message]")

//After a bit of consideration I block team deletion if there's any members left until unified objective handling is in.
/datum/team/proc/admin_delete(mob/user)
	if(members.len > 0)
		to_chat(user,"<span class='warning'>This team has members left, remove them first and make sure you know what you're doing.</span>")
		return
	qdel(src)

/datum/team/proc/admin_add_objective(mob/user)
	//any antag with get_team == src => add objective to that antag
	//otherwise create new custom antag
	if(!GLOB.objective_choices)
		populate_objective_choices()

	var/selected_type = input("Select objective type:", "Objective type") as null|anything in GLOB.objective_choices
	selected_type = GLOB.objective_choices[selected_type]
	if (!selected_type)
		return

	var/datum/objective/O = new selected_type
	O.team = src
	O.admin_edit(user)
	objectives |= O

	var/custom_antag_name

	for(var/datum/mind/M in members)
		var/datum/antagonist/team_antag
		for(var/datum/antagonist/A in M.antag_datums)
			if(A.get_team() == src)
				team_antag = A
		if(!team_antag)
			team_antag = new /datum/antagonist/custom
			if(!custom_antag_name)
				custom_antag_name = stripped_input(user, "Custom team antagonist name:", "Custom antag", "Antagonist")
				if(!custom_antag_name)
					custom_antag_name = "Team Member"
			team_antag.name = custom_antag_name
			M.add_antag_datum(team_antag,src)
		team_antag.objectives |= O

	message_admins("[key_name_admin(usr)] added objective \"[O.explanation_text]\" to [name]")
	log_admin("[key_name(usr)] added objective \"[O.explanation_text]\" to [name]")

/datum/team/proc/admin_edit_objective(mob/user, datum/objective/old_objective)
	if(!GLOB.objective_choices)
		populate_objective_choices()

	var/selected_type = input("Select objective type:", "Objective type") as null|anything in GLOB.objective_choices
	selected_type = GLOB.objective_choices[selected_type]
	if (!selected_type)
		return

	var/objective_pos = src.objectives.Find(old_objective) //Keep them in the same order, else it breaks muh immursion
	var/datum/objective/new_objective

	if(old_objective.type == selected_type)
		old_objective.admin_edit(user)

	else
		new_objective = new selected_type
		new_objective.team = src
		new_objective.admin_edit(user)

		//Apply it to the team
		objectives -= old_objective
		objectives.Insert(objective_pos, new_objective)

		//Now apply it to the members
		for(var/datum/mind/M in members)
			objective_pos = 0
			for(var/datum/antagonist/A in M.antag_datums)
				objective_pos = A.objectives.Find(old_objective)
				if(objective_pos) //Just in case an admin messed with their individual objectives
					//And yes, we'll assume it was intentional. They can always remove and re-add the objective.
					A.objectives -= old_objective
					A.objectives.Insert(objective_pos, new_objective)
					break
			if(!objective_pos)
				to_chat(user, "<span class='warning'>It seems like [M.current] does not have this objective despite being part of the team. If this is not intentional, consider removing and re-adding the objective.</span>")

	message_admins("[key_name_admin(usr)] edited team [src.name]'s objective to [new_objective.explanation_text]")
	log_admin("[key_name(usr)] edited team [src.name]'s objective to [new_objective.explanation_text]")

/datum/team/proc/admin_remove_objective(mob/user, datum/objective/O)
	for(var/datum/mind/M in members)
		for(var/datum/antagonist/A in M.antag_datums)
			A.objectives -= O
	objectives -= O

	message_admins("[key_name_admin(usr)] removed objective \"[O.explanation_text]\" from [name]")
	log_admin("[key_name(usr)] removed objective \"[O.explanation_text]\" from [name]")
	//qdel maybe

/datum/team/proc/admin_objective_completion(mob/user, datum/objective/O)
	O.completed = !O.completed
	log_admin("[key_name(usr)] toggled the win state for team [name]'s objective: [O.explanation_text]")
