//drunken alert
/obj/screen/alert/drunk
	name = "Drunk"
	desc = "All that alcohol you've been drinking is impairing your speech, motor skills, and mental cognition."
	icon_state = "drunk"

/obj/screen/alert/drunk/drunker
	name = "Very Drunk"
	desc = "You downed a lot of booze! *Hic* Everything feels so tipsy..."
	icon_state = "drunk2"

//synthetic hunger alert
/obj/screen/alert/fat/synth
	name = "Overcharged"
	desc = "Unit's power cell has been overcharged. Excess supply of power is being redirected to submodules."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "fat_synth"

/obj/screen/alert/hungry/synth
	name = "Low charge"
	desc = "Unit's power cell is running low."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "hungry_synth"

/obj/screen/alert/starving/synth
	name = "Out of charge"
	desc = "Unit's power cell has no charge remaining, and is running on backup power. Please recharge as soon as possible."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "starving_synth"
