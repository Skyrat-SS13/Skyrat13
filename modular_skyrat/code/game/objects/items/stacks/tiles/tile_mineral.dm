// Titanium Coloured Tiles
/*
/obj/item/stack/tile/mineral/titanium/yellow
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/yellow
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/blue
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/blue
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/white
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/white
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/purple
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/purple
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

// Old Titanium Tiles

/obj/item/stack/tile/mineral/titanium/old
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/old
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/old/yellow
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/old/yellow
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/old/blue
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/old/blue
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/old/white
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/old/white
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)

/obj/item/stack/tile/mineral/titanium/old/purple
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium/old/purple
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=500)
*/
/obj/item/stack/tile/mineral/titanium/AltClick(mob/user)
var/static/list/types = list("Titanium", "Yellow Titanium", "Blue Titanium", "White Titanium", "Purple Titanium", "Titanium Tile", "Yellow Titanium Tile", "Blue Titanium Tile", "White Titanium Tile", "Purple Titanium Tile")
var/choice = pick(types)
	if(choice)
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
				icon_state = "tile_shuttl_purple"
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

