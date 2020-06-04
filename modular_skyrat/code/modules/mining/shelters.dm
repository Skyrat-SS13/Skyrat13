/datum/map_template/shelter/alpha/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/open/indestructible) //yogs added indestructible floors
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/beta/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/open/indestructible)
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)

/datum/map_template/shelter/charlie/New()
	. = ..()
	blacklisted_turfs = typecacheof(/turf/open/indestructible) //yogs added indestructible floors to the shelter black list
	whitelisted_turfs = typecacheof(/turf/closed/mineral)
	banned_objects = typecacheof(/obj/structure/stone_tile)
