/mob/living/simple_animal/slime/death(gibbed)
	if(stat == DEAD)
		return
	if(!gibbed)
		if(is_adult)
			var/mob/living/simple_animal/slime/M = SSrecycling.deploy_slime(loc, colour) //Skyrat change
			M.rabid = TRUE
			M.regenerate_icons()

			is_adult = FALSE
			maxHealth = 150
			for(var/datum/action/innate/slime/reproduce/R in actions)
				R.Remove(src)
			var/datum/action/innate/slime/evolve/E = new
			E.Grant(src)
			revive(full_heal = 1)
			regenerate_icons()
			update_name()
			return

	if(buckled)
		Feedstop(silent = TRUE) //releases ourselves from the mob we fed on.

	stat = DEAD
	cut_overlays()

	update_mobility()

	if(SSticker.mode)
		SSticker.mode.check_win()

	return ..(gibbed)

/mob/living/simple_animal/slime/gib()
	death(TRUE)
	SSrecycling.recycle_slime(src) //Skyrat change, this is called from the processor too
