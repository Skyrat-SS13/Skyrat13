/obj/structure/window
	icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	//overlay of the brim
	var/mutable_appearance/mutable_overlay
	//change the shit below appropriately please
	var/wall_icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	var/nowall_icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'

/obj/structure/window/Initialize(mapload, direct)
	. = ..()
	if(length(canSmoothWith))
		canSmoothWith |= (typesof(/obj/machinery/door) - typesof(/obj/machinery/door/window) - typesof(/obj/machinery/door/firedoor) - typesof(/obj/machinery/door/poddoor))
		canSmoothWith |= typesof(/turf/closed/wall)
		canSmoothWith |= typesof(/obj/structure/falsewall)
		canSmoothWith |= typesof(/turf/closed/indestructible/riveted)
		canSmoothWith |= typesof(/obj/structure/table/low_wall)
	update_overlays()

/obj/structure/window/setAnchored(anchorvalue)
	..()
	update_icon()
	update_overlays()

/obj/structure/window/Bumped(atom/movable/AM)
	. = ..()
	if(!anchored)
		update_icon()
		update_overlays()

/obj/structure/window/update_icon()
	..()
	//this is fucking stupid but if we're not fulltile, we always use the no brim icon
	if(fulltile)
		for(var/obj/structure/table/low_wall/low_wall in get_turf(src))
			icon = wall_icon
			return
		icon = nowall_icon
	else
		icon = wall_icon

/obj/structure/window/update_overlays()
	. = ..()
	if(mutable_overlay)
		cut_overlay(mutable_overlay)
	var/obj/structure/table/low_wall/wall
	for(var/obj/structure/table/low_wall/wally in loc)
		wall = wally
		break
	if(wall?.mutable_overlay)
		mutable_overlay = wall.mutable_overlay
		add_overlay(mutable_overlay)

/obj/structure/window/fulltile
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)

/obj/structure/window/reinforced
	icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/window_nowall.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/reinforced_window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/reinforced_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/reinforced_window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)

/obj/structure/window/plasma
	icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plasma_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/plasma_window_nowall.dmi'

/obj/structure/window/plasma/fulltile
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plasma_window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/reinforced_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/plasma_window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)

/obj/structure/window/plasma/reinforced
	icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/rplasma_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/reinforced_plasma_window_nowall.dmi'

/obj/structure/window/plasma/reinforced/fulltile
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/rplasma_window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/rplasma_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/reinforced_plasma_window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)

/obj/structure/window/reinforced/tinted
	icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/tinted_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/tinted_window_nowall.dmi'

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/tinted_window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/tinted_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/tinted_window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)

/obj/structure/window/plastitanium
	icon = 'modular_skyrat/icons/eris/obj/structures/windows.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plastitanium_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/plastitanium_window_nowall.dmi'

/obj/structure/window/plastitanium/Initialize()
	. = ..()
	//this is stupid but oh well
	if(fulltile)
		icon = nowall_icon

/obj/structure/window/plastitanium/fulltile
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plastitanium_window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plastitanium_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/plastitanium_window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)

//shuttle windows are stupid
/obj/structure/window/shuttle
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plastitanium_window.dmi'
	wall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nobrim/plastitanium_window.dmi'
	nowall_icon = 'modular_skyrat/icons/eris/obj/smooth_structures/nowall/plastitanium_window_nowall.dmi'
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)
