/datum/status_effect/blooddrunk/argent
	id = "argent"
	duration = 100
	tick_interval = 0
	alert_type = /obj/screen/alert/status_effect/argent

/obj/screen/alert/status_effect/argent
	name = "Argent Energized"
	desc = "Argent energy rushes through your body! You'll only take 10% damage for the duration of the energy rush!"
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "argent"

/datum/status_effect/stealthsuit
	id = "stealthsuit"
	duration = -1
	tick_interval = 10
	alert_type = /obj/screen/alert/status_effect/stealthsuit

/obj/screen/alert/status_effect/stealthsuit
	name = "Stealth Suit"
	desc = "You are one with the dark. As long as you are immobile, you'll get more and more invisible. The invisibility effect is reset whenever you interact with something."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "stealth"