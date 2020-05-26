GLOBAL_LIST_INIT(plasticrod_recipes, list ( \
	new/datum/stack_recipe("plastic grille", /obj/structure/grille/plastic, 2, time = 10, one_per_turf = 1, on_floor = 1), \
	))

GLOBAL_LIST_INIT(plastic_recipes, list(
	new /datum/stack_recipe("see-through plastic flaps", /obj/structure/plasticflaps, 5, one_per_turf = TRUE, on_floor = TRUE, time = 40), \
	new /datum/stack_recipe("opaque plastic flaps", /obj/structure/plasticflaps/opaque, 5, one_per_turf = TRUE, on_floor = TRUE, time = 40), \
	new /datum/stack_recipe("water bottle", /obj/item/reagent_containers/glass/beaker/waterbottle/empty), \
	new /datum/stack_recipe("large water bottle", /obj/item/reagent_containers/glass/beaker/waterbottle/large/empty,3), \
	new /datum/stack_recipe("shower curtain", /obj/structure/curtain, 10, time = 10, one_per_turf = 1, on_floor = 1), \
	new /datum/stack_recipe("laser pointer case", /obj/item/glasswork/glass_base/laserpointer_shell, 30), \
	new /datum/stack_recipe("wet floor sign", /obj/item/caution, 2), \

	new /datum/stack_recipe("plastic girders", /obj/structure/girder/plastic, 2, time = 40, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe("plastic directional windows", /obj/structure/window/plastic/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new /datum/stack_recipe("plastic full windows", /obj/structure/window/plastic/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \

	new /datum/stack_recipe("plastic rod", /obj/item/stack/rods/plastic, 1, 2, 60), \
	new /datum/stack_recipe("plastic tile", /obj/item/stack/tile/plastic, 1, 4, 20), \
	new /datum/stack_recipe("plastic grate", /obj/item/stack/plasticgrate, 1, 4, 20), \
	new /datum/stack_recipe("plastic grate", /obj/item/stack/plasticgrate/windowfloor, 1, 4, 20), \
	new /datum/stack_recipe("plastic plate", /obj/item/stack/tile/plasticplate, 1, 4, 20), \
	))

/obj/item/stack/tile/plastic
	name = "plastic tile"
	singular_name = "plastic floor tile"
	desc = "A tile made out of plastic."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticitems.dmi'
	icon_state = "tile"
	turf_type = /turf/open/floor/plastic
	mineralType = "plastic"
	custom_materials = list(/datum/material/plastic=500)

/obj/item/stack/plasticgrate //Removed the tile part. Trying to use structures instead of turfs... annoying.
	name = "plastic grate"
	singular_name = "plastic floor grate"
	desc = "A grate made out of plastic."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticitems.dmi'
	icon_state = "grate"
	//turf_type = /turf/open/floor/plasticgrate
	//mineralType = "plastic"
	custom_materials = list(/datum/material/plastic=500)

/obj/item/stack/plasticgrate/windowfloor
	name = "plastic window floor"
	singular_name = "plastic window floor"
	desc = "A window floor made out of plastic."
	icon_state = "windowfloor"

/obj/item/stack/tile/plasticplate
	name = "plastic plate"
	singular_name = "plastic floor plate"
	desc = "A plate made out of plastic."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticitems.dmi'
	icon_state = "plate"
	turf_type = /turf/open/floor/plastic/plate
	mineralType = "plastic"
	custom_materials = list(/datum/material/plastic=500)

/obj/item/stack/tile/plastic/fifty
	amount = 50

/obj/item/stack/tile/plastic/twenty
	amount = 20

/obj/item/stack/rods/plastic
	name = "plastic rod"
	singular_name = "plastic rod"
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticitems.dmi'
	icon_state = "rods"
	custom_materials = list(/datum/material/plastic=1000)

/obj/item/stack/rods/plastic/fifty
	amount = 50

/obj/item/stack/rods/plastic/twenty
	amount = 20

/obj/item/stack/rods/plastic/get_main_recipes()
	. = ..()
	. += GLOB.plasticrod_recipes
	. -= GLOB.rod_recipes