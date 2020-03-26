/obj/item/stack/cable_coil/Initialize(mapload, new_amount = null, param_color = null)
	.=..()
	if(!GLOB.cable_coil_recipes.Find(list(new/datum/stack_recipe("noose", /obj/structure/chair/noose, 20, time = 80, one_per_turf = 1, on_floor = 1)))
		GLOB.cable_coil_recipes += list(new/datum/stack_recipe("noose", /obj/structure/chair/noose, 20, time = 80, one_per_turf = 1, on_floor = 1)))
	recipes = GLOB.cable_coil_recipes