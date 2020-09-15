/datum/antagonist/proc/team_panel_name()
	if(!owner)
		return TGUI_ANTAGLISTING_TEXT("Unassigned")
	if(owner.current)
		//newlines need to be escaped here because the preprocessor isn't smart enough
		return TGUI_ANTAGLISTING_BUTTON(\
			content=owner.current.real_name,\
			color="transparent",\
			action="admin_topic",\
			params=TGUI_ANTAGLISTING_HREF_LIST("adminplayeropts"=REF(owner.current)),\
		)
	else
		return TGUI_ANTAGLISTING_BUTTON(\
			content=owner.name,\
			color="transparent",\
			action="admin_topic",\
			params=TGUI_ANTAGLISTING_HREF_LIST("Vars"=REF(owner)),\
		)

/datum/antagonist/proc/team_panel_status()
	. = list()
	if(!owner)
		return TGUI_ANTAGLISTING_TEXT("Unassigned")
	if(!owner.current)
		return TGUI_ANTAGLISTING_TEXT("(Body destroyed)", list(color="red"))
	else
		if(owner.current.stat == DEAD)
			return TGUI_ANTAGLISTING_TEXT("(DEAD)", list(color="red"))
		else if(!owner.current.client)
			return TGUI_ANTAGLISTING_TEXT("No client")

/datum/antagonist/proc/team_panel_commands()
	if(!owner)
		return
	. = list()
	. += TGUI_ANTAGLISTING_BUTTON(\
			content="PM",\
			ml=1,\
			action="admin_topic",\
			params=TGUI_ANTAGLISTING_HREF_LIST("priv_msg"=ckey(owner.key)),\
		)
	if(owner.current) //There's a body to follow
		. += TGUI_ANTAGLISTING_BUTTON(\
				content="FLW",\
				action="admin_topic",\
				params=TGUI_ANTAGLISTING_HREF_LIST("adminplayerobservefollow"=REF(owner.current)),\
			)

/datum/antagonist/proc/team_panel_entry()
	. = list()
	. += team_panel_name()
	if(show_name_in_check_antagonists)
		. += TGUI_ANTAGLISTING_TEXT("([name])")
	
	. += team_panel_status()
	. += team_panel_commands()
