/mob/living
	var/enabled_combat_indicator = FALSE
	var/nextcombatpopup = 0

//this is not ideal but I really just want to catch up with everything
/mob/living/Initialize()
	RegisterSignal(src, COMSIG_LIVING_COMBAT_ENABLED, .proc/combat_mode_enabled_signal)
	RegisterSignal(src, COMSIG_LIVING_COMBAT_DISABLED, .proc/combat_mode_disabled_signal)
	. = ..()

/mob/living/Destroy()
	UnregisterSignal(src, COMSIG_LIVING_COMBAT_ENABLED)
	UnregisterSignal(src, COMSIG_LIVING_COMBAT_DISABLED)
	. = ..()

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
		src.log_message("<font color='red'>has turned ON the combat indicator!</font>", INDIVIDUAL_ATTACK_LOG)
	else
		cut_overlay(combat_indicator)
		enabled_combat_indicator = FALSE
		src.log_message("<font color='blue'>has turned OFF the combat indicator!</font>", INDIVIDUAL_ATTACK_LOG)

/mob/living/proc/change_combat_indicator(state)
	if(state && !enabled_combat_indicator && world.time >= nextcombatpopup) //No cooldown
		nextcombatpopup = world.time + 10 SECONDS
		playsound(src, 'sound/machines/chime.ogg', 10)
		flick_emote_popup_on_mob(src, "combat", 20)
	if(state && world.time >= combatmessagecooldown) //If combat mode didn't make a message
		combatmessagecooldown = world.time + 10 SECONDS
		visible_message("<span class='warning'>[src] gets ready for combat!</span>")

	set_combat_indicator(state)

/mob/living/proc/combat_mode_disabled_signal()
	change_combat_indicator(FALSE)


/mob/living/proc/combat_mode_enabled_signal()
	change_combat_indicator(TRUE)

/mob/living/proc/user_toggle_intentional_combat_indication()
	if(FORCE_BOOLEAN((src.stat == CONSCIOUS) && !(src.combat_flags & COMBAT_FLAG_HARD_STAMCRIT)))
		var/combat_enabled = (SEND_SIGNAL(src, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_TOGGLED))
		if(combat_enabled)
			to_chat(src, "<span class='warning'>Disable combat mode first!</span>")
		else if (enabled_combat_indicator)
			change_combat_indicator(FALSE)
		else
			change_combat_indicator(TRUE)
