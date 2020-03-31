/mob/emote(act, m_type = null, message = null, intentional = FALSE)
	. = ..()
	if(client && client.prefs.toggles & ASYNCHRONOUS_SAY && typing)
		set_typing_indicator(FALSE)
