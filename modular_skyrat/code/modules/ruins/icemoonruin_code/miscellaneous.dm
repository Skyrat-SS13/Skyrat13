/turf/open/floor/plating/ice/icemoon/slippery
	name = "slippery ice"
	desc = "Not even iceboots could withstand this one."

/turf/open/floor/plating/ice/icemoon/slippery/Initialize()
	. = ..()
	AddComponent(datum/component/slippery, 120, SLIDE | GALOSHES_DONT_HELP | SLIP_WHEN_CRAWLING)