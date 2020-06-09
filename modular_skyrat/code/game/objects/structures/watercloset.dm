/obj/structure/toilet/proc/toilet_spin(var/count = FALSE)
	if(count)
		GLOB.polish_toilet_count++
	new /obj/machinery/jukebox/disco/toilet(get_turf(src))
	alpha = 0
	return QDEL_IN(src, 5 SECONDS)

/obj/machinery/jukebox/disco/toilet
	name = "polish toilet basshunter dota homosex K19191"
	desc = "Epic."
	icon = 'modular_skyrat/icons/obj/polish_watercloset.dmi'
	icon_state = "toilet00"

/obj/machinery/jukebox/disco/toilet/Initialize()
	..()
	selection = new /datum/track("polish toilet spin", 'modular_skyrat/sound/music/toilet.ogg', 1190, 5)
	activate_music()

/obj/machinery/jukebox/disco/toilet/update_icon_state()
	if(active)
		icon = 'modular_skyrat/icons/obj/polish_watercloset.dmi'
		icon_state = "toilet00"
	else
		icon = 'icons/obj/watercloset.dmi'
		icon_state = "toilet00"

/obj/machinery/jukebox/disco/toilet/dance_over()
	..()
	activate_music()
