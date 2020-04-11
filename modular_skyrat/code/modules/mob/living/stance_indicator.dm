var/static/mutable_appearance/stance_indicator

/mob/living/proc/set_stance_indicator(var/state)
	if(!stance_indicator)
		stance_indicator = mutable_appearance('modular_skyrat/icons/mob/stance_indicator.dmi', "combat", FLY_LAYER)

	if(state && stat != DEAD)
		add_overlay(stance_indicator)
	else
		cut_overlay(stance_indicator)

/mob/living/disable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	. = ..()
	set_stance_indicator(FALSE)


/mob/living/enable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	. = ..()
	set_stance_indicator(TRUE)