/mob/Moved(atom/OldLoc, Dir, Forced = FALSE)
	. = ..()
	if(client && client.prefs.toggles & ASYNCHRONOUS_SAY && typing)
		set_typing_indicator(FALSE)
