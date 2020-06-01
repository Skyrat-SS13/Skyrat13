/mob/living
	var/enabled_combat_indicator = FALSE
	var/nextcombatpopup = 0


var/static/mutable_appearance/combat_indicator

/mob/living/proc/set_combat_indicator(state)
	if(enabled_combat_indicator == state)
		return

	if(!combat_indicator)
		combat_indicator = mutable_appearance('modular_skyrat/icons/mob/combat_indicator.dmi', "combat", FLY_LAYER)
		combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART

	if(state && stat != DEAD)
		add_overlay(combat_indicator)
		enabled_combat_indicator = TRUE
	else
		cut_overlay(combat_indicator)
		enabled_combat_indicator = FALSE

/mob/living/proc/change_combat_indicator(state)
	if(state && !enabled_combat_indicator && world.time >= nextcombatpopup) //No cooldown
		nextcombatpopup = world.time + 10 SECONDS
		playsound(src, 'sound/machines/chime.ogg', 10) 
		flick_emote_popup_on_mob(src, "combat", 20)
		src.log_message("<font color='red'>has used the combat indicator!</font>", INDIVIDUAL_ATTACK_LOG)
	if(state && world.time >= combatmessagecooldown) //If combat mode didn't make a message
		combatmessagecooldown = world.time + 10 SECONDS
		visible_message("<span class='warning'>[src] gets ready for combat!</span>")

	set_combat_indicator(state)

/mob/living/disable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	. = ..()
	change_combat_indicator(FALSE)


/mob/living/enable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	. = ..()
	change_combat_indicator(TRUE) 

/mob/living/proc/user_toggle_intentional_combat_indication()
	if(CAN_TOGGLE_COMBAT_MODE(src))
		var/combat_enabled = (combat_flags & COMBAT_FLAG_COMBAT_TOGGLED)
		if(combat_enabled && iscarbon(src))
			to_chat(src, "<span class='warning'>Disable combat mode first!</span>")
		else if (enabled_combat_indicator)
			change_combat_indicator(FALSE)
		else
			change_combat_indicator(TRUE)