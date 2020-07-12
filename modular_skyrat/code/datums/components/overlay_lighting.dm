/turf
	var/dynamic_lumcount = 0

/obj/effect/overlay/light_visible
	icon = 'modular_skyrat/icons/misc/light_32.dmi'
	icon_state = "light"
	layer = O_LIGHTING_VISUAL_LAYER
	plane = O_LIGHTING_VISUAL_PLANE
	appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM	
	mouse_opacity = 0
	alpha = 0

/datum/component/overlay_lighting
	var/atom/movable/current_holder 
	var/range = 1
	var/lum_range = 0
	var/lum_power = 0.5
	var/set_alpha = 0
	var/list/turf/affected_turfs = list()
	var/obj/effect/overlay/light_visible/visible_mask
	var/static/list/weh = list("32" = 'modular_skyrat/icons/misc/light_32.dmi',
		"64" = 'modular_skyrat/icons/misc/light_64.dmi',
		"96" = 'modular_skyrat/icons/misc/light_96.dmi',
		"128" = 'modular_skyrat/icons/misc/light_128.dmi',
		"160" = 'modular_skyrat/icons/misc/light_160.dmi',
		"192" = 'modular_skyrat/icons/misc/light_192.dmi',
		"224" = 'modular_skyrat/icons/misc/light_224.dmi',
		"256" = 'modular_skyrat/icons/misc/light_256.dmi',
		"288" = 'modular_skyrat/icons/misc/light_288.dmi',
		"320" = 'modular_skyrat/icons/misc/light_320.dmi',
		"352" = 'modular_skyrat/icons/misc/light_352.dmi'
		)

/datum/component/overlay_lighting/Initialize(_color, _range, _power, starts_on = TRUE)
	visible_mask = new()
	set_range(_range)
	set_power(_power)
	set_color(_color)
	if(starts_on)
		visible_mask.alpha = set_alpha

/datum/component/overlay_lighting/RegisterWithParent()
	. = ..()
	var/atom/movable/A = parent
	RegisterSignal(A, COMSIG_PARENT_QDELETING, .proc/on_qdel)
	RegisterSignal(A, COMSIG_MOVABLE_MOVED, .proc/on_parent_moved)
	check_holder()
	make_luminosity_update()

/datum/component/overlay_lighting/proc/on_qdel()
	Destroy(src)

/datum/component/overlay_lighting/Destroy()
	for(var/turf/lit_turf in affected_turfs)
		lit_turf.dynamic_lumcount -= lum_power
	affected_turfs.Cut()
	QDEL_NULL(visible_mask)
	return ..()

/datum/component/overlay_lighting/proc/clean_old_turfs()
	for(var/turf/lit_turf in affected_turfs)
		lit_turf.dynamic_lumcount -= lum_power
	affected_turfs.Cut()

/datum/component/overlay_lighting/proc/get_new_turfs()
	if(!current_holder)
		return
	for(var/turf/lit_turf in range(current_holder.loc, lum_range))
		lit_turf.dynamic_lumcount += lum_power
		affected_turfs += lit_turf

/datum/component/overlay_lighting/proc/make_luminosity_update()
	clean_old_turfs()
	get_new_turfs()

/datum/component/overlay_lighting/proc/set_holder(var/atom/movable/new_holder)
	if(new_holder == current_holder)
		return
	if(current_holder)
		if(new_holder != parent)
			UnregisterSignal(new_holder, COMSIG_PARENT_QDELETING)
			UnregisterSignal(new_holder, COMSIG_MOVABLE_MOVED)
		current_holder.luminosity -= lum_range
		current_holder.vis_contents -= visible_mask
	current_holder = new_holder
	if(new_holder == null)
		visible_mask.moveToNullspace()
		clean_old_turfs()
	else
		new_holder.luminosity += lum_range
		new_holder.vis_contents += visible_mask
		if(new_holder != parent)
			RegisterSignal(new_holder, COMSIG_PARENT_QDELETING, .proc/on_holder_qdel)
			RegisterSignal(new_holder, COMSIG_MOVABLE_MOVED, .proc/on_holder_moved)

/datum/component/overlay_lighting/proc/check_holder()
	var/atom/movable/A = parent
	if(isturf(A.loc))
		set_holder(A)
	else
		var/atom/movable/inside = A.loc
		if(isturf(inside.loc))
			set_holder(inside)
		else
			set_holder(null)

/datum/component/overlay_lighting/proc/on_holder_qdel()
	UnregisterSignal(current_holder, COMSIG_PARENT_QDELETING)
	UnregisterSignal(current_holder, COMSIG_MOVABLE_MOVED)
	set_holder(null)

/datum/component/overlay_lighting/proc/on_holder_moved()
	if(visible_mask.alpha)
		make_luminosity_update()

/datum/component/overlay_lighting/proc/on_parent_moved()
	check_holder()
	if(visible_mask.alpha)
		make_luminosity_update()

/datum/component/overlay_lighting/proc/set_color(new_color)
	visible_mask.color = new_color

/datum/component/overlay_lighting/proc/set_range(new_range)
	range = FLOOR(new_range,0.5)
	if(range < 1)
		range = 1
	else if(range > 6)
		range = 6
	var/pixel_bounds = ((range-1)*64)+32
	lum_range = CEILING(range,1)
	visible_mask.icon = weh["[pixel_bounds]"]
	if(pixel_bounds != 32)
		var/offset = (pixel_bounds-32)/2
		var/matrix/M = new
		M.Translate(-offset, -offset)
		visible_mask.transform = M

/datum/component/overlay_lighting/proc/set_power(new_power)
	if(new_power < 0)
		new_power = -new_power
		lum_power = -0.5
	set_alpha = min(230,(new_power*110)+35)
	if(visible_mask.alpha) //if it's turned on
		visible_mask.alpha = set_alpha	

/datum/component/overlay_lighting/proc/turn_on()
	visible_mask.alpha = set_alpha
	get_new_turfs()

/datum/component/overlay_lighting/proc/turn_off()
	visible_mask.alpha = 0
	clean_old_turfs()

/datum/component/overlay_lighting/UnregisterFromParent()
	. = ..()
	var/atom/movable/A = parent
	UnregisterSignal(A, COMSIG_PARENT_QDELETING)
	UnregisterSignal(A, COMSIG_MOVABLE_MOVED)
	A.vis_contents -= visible_mask
	A.luminosity -= lum_range
