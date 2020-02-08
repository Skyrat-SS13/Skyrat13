TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, verb_consent)()
	set name = "Toggle Lewd Verbs"
	set category = "Preferences"
	set desc = "Allow Lewd Verbs"

	if (usr && isliving(usr))
		var/mob/living/L = usr
		if(L.refractory_period)
			to_chat(usr, "You need to wait [DisplayTimeText(L.refractory_period * 10, TRUE)] to change your consent setting.")
			return

	usr.client.prefs.toggles ^= VERB_CONSENT
	usr.client.prefs.save_preferences()
	to_chat(usr, "You [(usr.client.prefs.toggles & VERB_CONSENT) ? "consent" : "do not consent"] to the use of lewd verbs on your character.")
	if (usr && isliving(usr))
		var/mob/living/L = usr
		L.hud_used.arousal?.update_icon_state()
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Allow Lewd Verbs", "[usr.client.prefs.toggles & VERB_CONSENT ? "Yes" : "No"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/verb_consent/Get_checked(client/C)
	return C.prefs.toggles & VERB_CONSENT
