/datum/keybinding/carbon/wield_act
	hotkey_keys = list("CtrlX")
	name = "wield_act"
	full_name = "Wield active item"
	description = "Wield the item in your active hand."
	category = CATEGORY_CARBON

/datum/keybinding/carbon/wield_act/down(client/user)
	var/mob/living/L = user.mob
	if(istype(L))
		L.wield_active_hand()
	return TRUE
