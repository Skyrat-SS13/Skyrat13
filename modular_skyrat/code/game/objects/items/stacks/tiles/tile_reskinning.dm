// Titanium Coloured Tiles

/obj/item/stack/tile/mineral/titanium/ShiftClick(mob/user)
	var/choice = input(user, "What tile would you like?") as null|anything in list("Titanium", "Yellow Titanium", "Blue Titanium", "White Titanium", "Purple Titanium", "Titanium Tile", "Yellow Titanium Tile", "Blue Titanium Tile", "White Titanium Tile", "Purple Titanium Tile")
	switch(choice)
		if("Titanium")
			turf_type = /turf/open/floor/mineral/titanium
			icon_state = "tile_shuttle"
			desc = "Sleek titanium tiles."
		if("Yellow Titanium")
			turf_type = /turf/open/floor/mineral/titanium/yellow
			icon_state = "tile_shuttle_yellow"
			desc = "Sleek yellow titanium tiles."
		if("Blue Titanium")
			turf_type = /turf/open/floor/mineral/titanium/blue
			icon_state = "tile_shuttle_blue"
			desc = "Sleek blue titanium tiles."
		if("White Titanium")
			turf_type = /turf/open/floor/mineral/titanium/white
			icon_state = "tile_shuttle_white"
			desc = "Sleek white titanium tiles."
		if("Purple Titanium")
			turf_type = /turf/open/floor/mineral/titanium/purple
			icon_state = "tile_shuttle_purple"
			desc = "Sleek purple titanium tiles."
		if("Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old
			icon_state = "tile_shuttle_old"
			desc = "Titanium floor tiles."
		if("Yellow Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/yellow
			icon_state = "tile_shuttle_old_yellow"
			desc = "Yellow titanium floor tiles."
		if("Blue Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/blue
			icon_state = "tile_shuttle_old_blue"
			desc = "Blue titanium floor tiles."
		if("White Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/white
			icon_state = "tile_shuttle_old_white"
			desc = "White titanium floor tiles."
		if("Purple Titanium Tile")
			turf_type = /turf/open/floor/mineral/titanium/old/purple
			icon_state = "tile_shuttle_old_purple"
			desc = "Purple titanium floor tiles."

/obj/item/stack/tile/plasteel/ShiftClick(mob/user)
	var/choice = input(user, "What tile would you like?") as null|anything in list("Plasteel", "White Plasteel", "Chapel Flooring", "Shower Tiles", "Freezer", "Kitchen", "Grimy", "Solar Panel")
	switch(choice)
		if("Plasteel")
			turf_type = /turf/open/floor/plasteel
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile"
			desc = "Metal floor tiles."
		if("White Plasteel")
			turf_type = /turf/open/floor/plasteel/white
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_white"
			desc = "White metal floor tiles."
		if("Dark Plasteel")
			turf_type = /turf/open/floor/plasteel/dark
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_dark"
			desc = "Dark metal floor tiles."
		if("Chapel Flooring")
			turf_type = /turf/open/floor/plasteel/chapel_floor
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_chapel"
			desc = "Those very dark floor tiles you find in the chapel a lot."
		if("Shower Tiles")
			turf_type = /turf/open/floor/plasteel/showroomfloor
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_shower"
			desc = "Shower tiling."
		if("Freezer")
			turf_type = /turf/open/floor/plasteel/freezer
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_freezer"
			desc = "High-grip flooring for walk-in freezers and chillers."
		if("Kitchen")
			turf_type = /turf/open/floor/plasteel/cafeteria
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_kitchen"
			desc = "Chequered pattern plasteel tiles."
		if("Grimy")
			turf_type = /turf/open/floor/plasteel/grimy
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_grimy"
			desc = "I'm sure it'll look nice somewhere?"
		if("Solar Panel")
			turf_type = /turf/open/floor/plasteel/airless/solarpanel
			icon = 'modular_skyrat/icons/obj/tiles.dmi'
			icon_state = "tile_solar"
			desc = "Using this indoors is against an Intergalactic War Crime."

/turf/open/floor/plasteel/attackby(obj/item/stack/tile/plasteel, mob/user)
	var/choice = input(user, "This floor has a certain icon stored in memory. What would you like to change it to?") as null|anything in list("Plasteel", "White Plasteel", "Chapel Flooring", "Shower Tiles", "Freezer", "Kitchen", "Grimy", "Solar Panel")
	switch(choice)
		if("Plasteel")
			icon_regular_floor = "floor"
		if("White Plasteel")
			icon_regular_floor = "white"
		if("Dark Plasteel")
			icon_regular_floor = "darkfull"
		if("Chapel Flooring")
			icon_regular_floor = "chapel_alt"
		if("Shower Tiles")
			icon_regular_floor = "showroomfloor"
		if("Freezer")
			icon_regular_floor = "freezerfloor"
		if("Kitchen")
			icon_regular_floor = "cafeteria"
		if("Grimy")
			icon_regular_floor = "grimy"
		if("Solar Panel")
			icon_regular_floor = "solarpanel"
		else return()
