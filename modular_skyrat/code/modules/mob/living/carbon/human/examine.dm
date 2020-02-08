/mob/living/carbon/human/examine(mob/user)
// still can't do \his[src] though.
	var/t_His = p_their(TRUE)

	if(client && client.prefs)
		if(client.prefs.toggles & VERB_CONSENT)
			. += "[t_His] player has allowed lewd verbs.\n"
		else
			. += "[t_His] player has not allowed lewd verbs.\n"