/datum/crafting_recipe/bronze_multitool
	name = "Bronze Plated Multitool"
	tools = list(/obj/item/stock_parts/cell/upgraded/plus)
	result = /obj/item/multitool/brass/bronze
	reqs = list(/obj/item/multitool = 1,
				/obj/item/stack/cable_coil = 10,
				/obj/item/stack/tile/bronze = 1,
				/datum/reagent/water  = 15)
	time = 40
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/expbronze_welder
	name = "Upgraded Bronze Plated Welder"
	tools = list(/obj/item/stock_parts/cell/upgraded/plus)
	result = /obj/item/weldingtool/experimental/brass/bronze
	reqs = list(/obj/item/weldingtool/experimental = 1,
				/obj/item/weldingtool/bronze = 1,
				/obj/item/stack/cable_coil = 10)
	time = 40
	subcategory = CAT_TOOL
	category = CAT_MISC