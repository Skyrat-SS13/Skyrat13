/obj/structure/grille
	icon = 'modular_skyrat/icons/eris/obj/structures.dmi'

/obj/structure/grille/Initialize()
	. = ..()
	if(length(canSmoothWith))
		canSmoothWith |= (typesof(/obj/machinery/door) - typesof(/obj/machinery/door/window) - typesof(/obj/machinery/door/firedoor) - typesof(/obj/machinery/door/poddoor))
		canSmoothWith |= typesof(/turf/closed/wall)
		canSmoothWith |= typesof(/obj/structure/falsewall)
		canSmoothWith |= typesof(/turf/closed/indestructible/riveted)
