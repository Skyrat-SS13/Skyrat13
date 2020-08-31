/obj/screen/ghost/eventsignup
	name = "Event Signup"
	icon = 'modular_skyrat/icons/mob/screen_ghost.dmi'
	icon_state = "eventsignupoff"

/obj/screen/ghost/eventsignup/New()
	icon_update()

/obj/screen/ghost/eventsignup/Click()
	var/mob/dead/observer/G = usr
	G.open_event_menu(src)

/obj/screen/ghost/eventsignup/proc/icon_update()
	icon_state = "eventsignup" + (usr.client?.prefs.event_participation ? "on" : "off")
	update_icon()

/datum/hud/ghost/New(mob/owner)
	..()

	var/obj/screen/using

	using = new /obj/screen/ghost/eventsignup()
	using.screen_loc = ui_ghost_eventsignup
	using.hud = src
	static_inventory += using
