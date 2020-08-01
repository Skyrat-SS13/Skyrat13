//this file is used to solve the stupid issues i had in related to lighting and layers
//this is stupid and is named after being stupid and has little to no organization at all
/obj/structure/window
	plane = WALL_PLANE
	layer =	WALL_WINDOW_LAYER

/obj/structure/window/Initialize(mapload, direct)
	..()
	if(!fulltile)
		layer = ABOVE_OBJ_LAYER //Just above doors
		plane = GAME_PLANE

/obj/structure/grille
	plane = ABOVE_FLOOR_PLANE
	layer =	LATTICE_LAYER

/obj/structure/cable
	plane = ABOVE_FLOOR_PLANE
	layer = WIRE_LAYER

/obj/machinery/door/poddoor
	plane = ABOVE_FLOOR_PLANE
	layer = POD_DOOR_LAYER

/obj/machinery/atmospherics/pipe
	//This is gonna cause issues with wall pipes. I know.
	//The hardest choices require the strongest wills.
	plane = ABOVE_FLOOR_PLANE
