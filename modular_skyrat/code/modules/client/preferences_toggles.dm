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

/client/proc/togglegloballoocs()
	set name = "Show/Hide LOOC Globally"
	set category = "Preferences"
	set desc = "Toggles seeing LocalOutOfCharacter chat globally"
	usr.client.prefs.chat_toggles ^= CHAT_LOOC_ADMIN
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.chat_toggles & CHAT_LOOC_ADMIN) ? "now see all" : "now only see local"] messages on the LOOC channel.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Seeing LOOC Globally", "[usr.client.prefs.chat_toggles & CHAT_LOOC_ADMIN ? "Enabled" : "Disabled"]"))

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, woundsothers)()
	set name = "Show/Hide Combat Wound Messages (Other)"
	set category = "Preferences"
	set desc = "Silence wound occur texts on other people"
	usr.client.prefs.chat_toggles ^= CHAT_WOUNDS_OTHER
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [usr.client.prefs.chat_toggles & CHAT_WOUNDS_OTHER ? "no longer" : "now"] see combat wound messages on other people")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Other Wound Messages", "[usr.client.prefs.toggles & CHAT_WOUNDS_OTHER ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/woundsothers/Get_checked(client/C)
	return C.prefs.toggles & CHAT_WOUNDS_OTHER

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, woundsself)()
	set name = "Show/Hide Combat Wound Messages (Self)"
	set category = "Preferences"
	set desc = "Silence wound occur texts on yourself"
	usr.client.prefs.chat_toggles ^= CHAT_WOUNDS_SELF
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [usr.client.prefs.chat_toggles & CHAT_WOUNDS_SELF ? "no longer" : "now"] see combat wound messages on yourself")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Slef Wound Messages", "[usr.client.prefs.toggles & CHAT_WOUNDS_SELF ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/woundsself/Get_checked(client/C)
	return C.prefs.toggles & CHAT_WOUNDS_SELF

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, megafauna_music)()
	set name = "Toggle Megafauna Music"
	set category = "Preferences"
	set desc = "Turn megafauna music on/off"

	usr.client.prefs.toggles ^= SOUND_MEGAFAUNA
	usr.client.prefs.save_preferences()
	to_chat(usr, "You [(usr.client.prefs.toggles & SOUND_MEGAFAUNA) ? "turn on" : "turn off"] the playback of megafauna music.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Megafauna Music", "[usr.client.prefs.toggles & SOUND_MEGAFAUNA ? "Yes" : "No"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/megafauna_music/Get_checked(client/C)
	return C.prefs.toggles & SOUND_MEGAFAUNA

TOGGLE_CHECKBOX(/datum/verbs/menu/Settings, metric_or_bust)()
	set name = "Toggle Measurements"
	set category = "Preferences"
	set desc = "Toggle/Untoggle Metric Measurements"

	usr.client.prefs.toggles ^= METRIC_OR_BUST
	usr.client.prefs.save_preferences()
	to_chat(usr, "You are now using [(usr.client.prefs.toggles & METRIC_OR_BUST) ? "metric" : "imperial"] measurements.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Measurements", "[usr.client.prefs.toggles & METRIC_OR_BUST ? "Metric" : "Imperial"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/verbs/menu/Settings/metric_or_bust/Get_checked(client/C)
	return C.prefs.toggles & METRIC_OR_BUST
