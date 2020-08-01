/turf/open/floor/plating
	icon = 'modular_skyrat/icons/eris/turf/floors/plating.dmi'
	icon_state = "plating"
	var/platingid = 1
	var/minid = 1
	var/maxid = 18

/turf/open/floor/plating/Initialize()
	..()
	if (burnt_states == list("panelscorched"))
		burnt_states = list("platingscorched1", "platingscorched2", "platingscorched3")
	platingid = rand(minid, maxid)
	icon_plating = "[icon_plating][platingid]"
	icon_state = icon_plating
	update_icon()
