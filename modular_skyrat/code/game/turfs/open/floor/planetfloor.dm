/turf/open/floor/plating/cobblestone
	name = "cobblestone"
	desc = "Stone cobbles set into the ground."
	icon = 'modular_skyrat/icons/turf/floors/planetfloor.dmi'
	icon_state = "cobblestone"
	baseturfs = /turf/open/floor/plating/asteroid

/turf/open/floor/plating/cobblestone/snow
	name = "snowy cobblestone"
	desc = "Snnnooooowwwww! Snowy cobblestone."
	icon_state = "cobblestone_snow"

/turf/open/floor/cobblestone/Initialize(mapload)
	dir = pick(1,2,4,8)
