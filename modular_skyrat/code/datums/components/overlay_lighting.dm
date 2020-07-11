/turf
	var/dynamic_lumcount = 0

/obj/effect/overlay/light_visible
	icon = 'modular_skyrat/icons/misc/light_32.dmi'
	icon_state = "light"
	layer = O_LIGHTING_VISUAL_LAYER
	plane = O_LIGHTING_VISUAL_PLANE
	appearance_flags = RESET_TRANSFORM
	mouse_opacity = 0

/datum/component/overlay_lighting
	var/range = 1
	var/lum_range = 0
	var/lum_power = 0.5
	var/light = "#FFFFFF"
	var/set_alpha = 0
	var/list/turf/affected_turfs = list()
	var/obj/effect/overlay/light_visible/visible_mask
	var/static/list/weh = list("1" = 'modular_skyrat/icons/misc/light_32.dmi',
		"2" = 'modular_skyrat/icons/misc/light_64.dmi',
		"3" = 'modular_skyrat/icons/misc/light_96.dmi',
		"4" = 'modular_skyrat/icons/misc/light_128.dmi',
		"5" = 'modular_skyrat/icons/misc/light_160.dmi'
		)

/datum/component/overlay_lighting/Initialize(_color, _range, _alpha)
	//Light - the colour of the overlay
	light = _color
	//Range - which sprite we're using for the overlay 1 - 32x32; 2 - 64x64; 3 - 96x96 ;4 - 128x128; 5 - 160x160
	// - Also affects emitted luminosity
	// ONLY 1 to 5
	range = _range
	lum_range = range
	//Alpha - strength. 255 is 100% strength and 128 is 50% strength
	set_alpha = _alpha

/datum/component/overlay_lighting/RegisterWithParent()
	. = ..()
	var/atom/movable/A = parent
	RegisterSignal(A, COMSIG_PARENT_QDELETING, .proc/on_qdel)
	RegisterSignal(A, COMSIG_MOVABLE_MOVED, .proc/on_parent_moved)
	visible_mask = new()
	visible_mask.icon = weh["[range]"]
	if(range != 1)
		var/offset = ((range * 32)-32)/2
		var/matrix/M = new
		M.Translate(-offset, -offset)
		visible_mask.transform = M
	visible_mask.color = light
	visible_mask.alpha = set_alpha
	A.vis_contents += visible_mask
	A.luminosity += lum_range
	for(var/turf/lit_turf in range(A.loc, lum_range))
		lit_turf.dynamic_lumcount += lum_power
		affected_turfs += lit_turf

/datum/component/overlay_lighting/proc/on_qdel()
	Destroy(src)

/datum/component/overlay_lighting/Destroy()
	for(var/turf/lit_turf in affected_turfs)
		lit_turf.dynamic_lumcount -= lum_power
	affected_turfs.Cut()
	QDEL_NULL(visible_mask)
	return ..()

/datum/component/overlay_lighting/proc/on_parent_moved()
	var/atom/movable/A = parent
	for(var/turf/lit_turf in affected_turfs)
		lit_turf.dynamic_lumcount -= lum_power
	affected_turfs.Cut()
	for(var/turf/lit_turf in range(A.loc, lum_range))
		lit_turf.dynamic_lumcount += lum_power
		affected_turfs += lit_turf

/datum/component/overlay_lighting/proc/set_color(new_color)
	visible_mask.color = new_color

/datum/component/overlay_lighting/proc/turn_on()
	visible_mask.alpha = set_alpha
	for(var/turf/lit_turf in range(A.loc, lum_range))
		lit_turf.dynamic_lumcount += lum_power
		affected_turfs += lit_turf

/datum/component/overlay_lighting/proc/turn_off()
	visible_mask.alpha = 0
	var/atom/movable/A = parent
	for(var/turf/lit_turf in affected_turfs)
		lit_turf.dynamic_lumcount -= lum_power
	affected_turfs.Cut()

/datum/component/overlay_lighting/UnregisterFromParent()
	. = ..()
	var/atom/movable/A = parent
	UnregisterSignal(A, COMSIG_PARENT_QDELETING)
	UnregisterSignal(A, COMSIG_MOVABLE_MOVED)
	A.vis_contents -= visible_mask
	A.luminosity -= lum_range
