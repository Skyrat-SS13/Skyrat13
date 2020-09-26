/obj/structure/falsewall/Initialize()
	. = ..()
	if(length(canSmoothWith))
		canSmoothWith |= (typesof(/obj/machinery/door) - typesof(/obj/machinery/door/window) - typesof(/obj/machinery/door/firedoor) - typesof(/obj/machinery/door/poddoor))
		canSmoothWith |= typesof(/turf/closed/wall)
		canSmoothWith |= typesof(/obj/structure/falsewall)
		canSmoothWith |= typesof(/turf/closed/indestructible/riveted)

/obj/structure/falsewall
	icon = 'modular_skyrat/icons/eris/turf/walls/wall.dmi'
	icon_state = "wall"
	canSmoothWith = list(
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	)

/obj/structure/falsewall/reinforced
	icon = 'modular_skyrat/icons/eris/turf/walls/rwall.dmi'
	icon_state = "r_wall"

/obj/structure/falsewall/uranium
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#2fb314"

/obj/structure/falsewall/silver
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#a1c8db"

/obj/structure/falsewall/gold
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#ffff73"

/obj/structure/falsewall/diamond
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#3cf9ff"

/obj/structure/falsewall/bananium
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#fffb00"

/obj/structure/falsewall/plasma
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#d341ff"

/obj/structure/falsewall/iron
	icon = 'modular_skyrat/icons/eris/turf/walls/gwall.dmi'
	icon_state = "wall"
	color = "#677172"

/obj/structure/falsewall/titanium
	icon = 'modular_skyrat/icons/hyper/turf/walls/titanium.dmi'
	icon_state = "wall"
	color = "#c7c7c7"

/obj/structure/falsewall/plastitanium
	icon = 'modular_skyrat/icons/hyper/turf/walls/plastitanium.dmi'
	icon_state = "wall"
	color = "#555555"

/obj/structure/falsewall/wood
	icon = 'modular_skyrat/icons/hyper/turf/walls/gwood_wall.dmi'
	icon_state = "wall"
	color = "#472e00"
