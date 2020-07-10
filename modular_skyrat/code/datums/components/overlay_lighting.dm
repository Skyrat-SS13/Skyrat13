/obj/effect/overlay/light_blocker
	icon = 'modular_skyrat/icons/misc/o_light_32.dmi'
	icon_state = "dark"
	layer = O_LIGHTING_BLOCKER_LAYER
	plane = O_LIGHTING_BLOCKER_PLANE
	appearance_flags = RESET_TRANSFORM
	mouse_opacity = 0

/obj/effect/overlay/light_visible
	icon = 'modular_skyrat/icons/misc/o_light_32.dmi'
	icon_state = "light"
	layer = O_LIGHTING_VISUAL_LAYER
	plane = O_LIGHTING_VISUAL_PLANE
	appearance_flags = RESET_TRANSFORM
	mouse_opacity = 0

/datum/component/overlay_lighting
	var/range = 1
	var/light = "#FFFFFF"
	var/set_alpha
	var/power = 0
	var/obj/effect/overlay/light_blocker/blocker_mask
	var/obj/effect/overlay/light_visible/visible_mask

/datum/component/overlay_lighting/Initialize(_light, _range, _alpha)
	light = _light
	range = _range
	set_alpha = _alpha

/datum/component/overlay_lighting/RegisterWithParent()
	. = ..()
	var/atom/movable/A = parent
	RegisterSignal(A, COMSIG_PARENT_QDELETING, .proc/on_qdel)
	blocker_mask = new()
	visible_mask = new()
	visible_mask.color = light
	visible_mask.alpha = set_alpha
	A.vis_contents += blocker_mask
	A.vis_contents += visible_mask

/datum/component/overlay_lighting/proc/on_qdel()
	Destroy(src)

/datum/component/overlay_lighting/UnregisterFromParent()
	. = ..()
	var/atom/movable/A = parent
	UnregisterSignal(A, COMSIG_PARENT_QDELETING)
	A.vis_contents -= blocker_mask
	A.vis_contents -= visible_mask
	QDEL_NULL(blocker_mask)
	QDEL_NULL(visible_mask)
