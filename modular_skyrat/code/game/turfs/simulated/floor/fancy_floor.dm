/turf/open/floor/smooth_grass
	name = "grass patch"
	desc = "You can't tell if this is real grass or just cheap plastic imitation."
	icon = 'icons/turf/floors.dmi'
	icon_state = "grass"
	floor_tile = /obj/item/stack/tile/grass
	//broken_states = list("sand")
	flags_1 = NONE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = null
	layer = 2.1
	var/smooth_icon = 'modular_skyrat/icons/turf/floors/smooth_grass.dmi'
	var/smoothing_groups = list(/turf/open/floor/smooth_grass, /turf/closed/indestructible)

/turf/open/floor/smooth_grass/Initialize()
	if(!canSmoothWith)
		canSmoothWith = smoothing_groups
	var/matrix/M = new
	M.Translate(-8, -8)
	transform = M
	icon = smooth_icon
	. = ..()