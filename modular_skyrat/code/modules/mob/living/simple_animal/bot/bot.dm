/mob/living/simple_animal/bot
	var/commissioned = FALSE // Will other (noncommissioned) bots salute this bot?
	var/can_salute = TRUE
	var/salute_delay = 60 SECONDS

/mob/living/simple_animal/bot/handle_automated_action() //Master process which handles code common across most bots.
	diag_hud_set_botmode()

	if (ignorelistcleanuptimer % 300 == 0) // Every 300 actions, clean up the ignore list from old junk
		for(var/ref in ignore_list)
			var/atom/referredatom = locate(ref)
			if (!referredatom || !istype(referredatom) || QDELETED(referredatom))
				ignore_list -= ref
		ignorelistcleanuptimer = 1
	else
		ignorelistcleanuptimer++

	if(!on || client)
		return

	if(!commissioned && can_salute)
		for(var/mob/living/simple_animal/bot/B in get_hearers_in_view(5, get_turf(src)))
			if(B.commissioned)
				visible_message("<b>[src]</b> performs an elaborate salute for [B]!")
				can_salute = FALSE
				addtimer(VARSET_CALLBACK(src, can_salute, TRUE), salute_delay)
				break

	switch(mode) //High-priority overrides are processed first. Bots can do nothing else while under direct command.
		if(BOT_RESPONDING)	//Called by the AI.
			call_mode()
			return
		if(BOT_SUMMON)		//Called by PDA
			bot_summon()
			return
	return TRUE //Successful completion. Used to prevent child process() continuing if this one is ended early.
