var/static/mutable_appearance/combat_indicator

/mob/living/proc/set_combat_indicator(var/state)
	if(!combat_indicator)
		combat_indicator = mutable_appearance('modular_skyrat/icons/mob/combat_indicator.dmi', "combat", FLY_LAYER)
		combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART

	if(state && stat != DEAD)
		add_overlay(combat_indicator)
	else
		cut_overlay(combat_indicator)

/mob/living/disable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	. = ..()
	set_combat_indicator(FALSE)


/mob/living/enable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	. = ..()
	set_combat_indicator(TRUE) 

/mob/living/proc/flash_combat_popup()
	var/image/I = image('modular_skyrat/icons/mob/popup_flicks.dmi', src, "combat",FLY_LAYER)
	I.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	INVOKE_ASYNC(GLOBAL_PROC, /proc/flick_overlay_view, I, src, 30)
	animate(I, alpha = 255, time = 5, easing = BOUNCE_EASING, pixel_y = 10)