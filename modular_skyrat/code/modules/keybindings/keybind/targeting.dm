/datum/keybinding/mob/toggle_zone
	hotkey_keys = list("CtrlF")
	name = "toggle_zone_select"
	full_name = "Toggle zone select"
	description = "Change your zone selection to the next one."
	category = CATEGORY_TARGETING

/datum/keybinding/mob/toggle_zone/down(client/user)
	var/mob/M = user.mob
	if(M)
		switch(M.zone_selected)
			if(BODY_ZONE_HEAD)
				user.body_toggle_head()
			if(BODY_ZONE_PRECISE_EYES)
				user.body_toggle_head()
			if(BODY_ZONE_PRECISE_MOUTH)
				user.body_r_arm()
			if(BODY_ZONE_R_ARM)
				user.body_r_arm()
			if(BODY_ZONE_PRECISE_R_HAND)
				user.body_chest()
			if(BODY_ZONE_CHEST)
				user.body_chest()
			if(BODY_ZONE_PRECISE_GROIN)
				user.body_l_arm()
			if(BODY_ZONE_L_ARM)
				user.body_l_arm()
			if(BODY_ZONE_PRECISE_L_HAND)
				user.body_r_leg()
			if(BODY_ZONE_R_LEG)
				user.body_r_leg()
			if(BODY_ZONE_PRECISE_R_FOOT)
				user.body_l_leg()
			if(BODY_ZONE_L_LEG)
				user.body_l_leg()
			if(BODY_ZONE_PRECISE_L_FOOT)
				user.body_toggle_head()
	return TRUE
