/datum/keybinding/living/toggle_combat_indication
	hotkey_keys = list("CtrlC")
	name = "toggle_combat_indication"
	full_name = "Toggle combat indication"
	description = "Toggles whether or not you're escalating or de-escalating from mechanical combat."

/datum/keybinding/living/toggle_combat_indication/can_use(client/user)
	return isliving(user.mob)	

/datum/keybinding/living/toggle_combat_indication/down(client/user)
	var/mob/living/L = user.mob
	L.user_toggle_intentional_combat_indication()
	return TRUE