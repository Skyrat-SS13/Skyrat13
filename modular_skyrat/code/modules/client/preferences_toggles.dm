TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, verb_consent)()
	set name = "Toggle Lewd Verbs"
	set category = "Preferences"
	set desc = "Allow Lewd Verbs"

	usr.client.prefs.toggles ^= VERB_CONSENT
	usr.client.prefs.save_preferences()
	to_chat(usr, "You [(usr.client.prefs.toggles & VERB_CONSENT) ? "consent" : "do not consent"] to the use of lewd verbs on your character.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Allow Lewd Verbs", "[usr.client.prefs.toggles & VERB_CONSENT ? "Yes" : "No"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/verb_consent/Get_checked(client/C)
	return C.prefs.toggles & VERB_CONSENT

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, lewd_verb_sound_consent)()
	set name = "Toggle Lewd Verb Sounds"
	set category = "Preferences"
	set desc = "Mute Lewd Verb Sounds"

	usr.client.prefs.toggles ^= LEWD_VERB_SOUNDS
	usr.client.prefs.save_preferences()
	to_chat(usr, "You [(usr.client.prefs.toggles & LEWD_VERB_SOUNDS) ? "turn off" : "turn on"] lewd verb sounds.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Lewd Verb Sounds", "[usr.client.prefs.toggles & LEWD_VERB_SOUNDS ? "Yes" : "No"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/lewd_verb_sound_consent/Get_checked(client/C)
	return C.prefs.toggles & LEWD_VERB_SOUNDS