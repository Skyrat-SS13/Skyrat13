/datum/action/switch_erg
	name = "Participate in ERG"
	icon_icon = 'modular_skyrat/icons/mob/screen_gen.dmi'
	button_icon_state = "dg_normal"
	button_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND

/datum/action/switch_erg/New(Target)
	..()
	var/mob/M = Target
	if(istype(M))
		if(M.client?.prefs?.accept_ERG)
			button_icon_state = "erg_on"
		else
			button_icon_state = "erg_off"
	UpdateButtonIcon(FALSE, TRUE)

/datum/action/switch_erg/Trigger()
	. = ..()
	if(usr.client?.prefs)
		usr.client.prefs.accept_ERG = !usr.client.prefs.accept_ERG
		usr.client.prefs.save_preferences()
		usr.mind?.accept_ERG = usr.client.prefs.accept_ERG
		to_chat(usr, "<span class='notice'>You <b>[usr.client.prefs.accept_ERG ? "<font color='red'>will</font>" : "<font color='green'>won't</font>"]</b> participate on ERG.</span>")
		UpdateButtonIcon(FALSE, TRUE)
