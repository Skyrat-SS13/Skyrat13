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

/datum/crafting_recipe/makeshift/crowbar
	name = "Makeshift Crowbar"
	tools = list(/obj/item/hammer/makeshift)
	result = /obj/item/crowbar/makeshift
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/cable_coil = 2)
	time = 120
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/makeshift/hammer
	name = "Makeshift Hammer"
	result = /obj/item/hammer/makeshift
	reqs = list(/obj/item/stack/cable_coil = 2,
				/obj/item/stack/rods = 2,
				/obj/item/kitchen/rollingpin = 1)
	time = 80
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/makeshift/screwdriver
	name = "Makeshift Screwdriver"
	tools = list(/obj/item/hammer/makeshift)
	result = /obj/item/screwdriver/makeshift
	reqs = list(/obj/item/stack/cable_coil = 2,
				/obj/item/stack/rods = 2)
	time = 80
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/makeshift/welder
	name = "Makeshift Welder"
	tools = list(/obj/item/hammer/makeshift, /obj/item/screwdriver, /obj/item/wirecutters)
	result = /obj/item/weldingtool/makeshift
	reqs = list(/obj/item/tank/internals/emergency_oxygen = 1,
				/obj/item/stack/sheet/metal = 6,
				/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/cable_coil = 4)
	time = 160
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/makeshift/wirecutters
	name = "Makeshift Wirecutters"
	tools = list(/obj/item/hammer/makeshift, /obj/item/screwdriver)
	result = /obj/item/wirecutters/makeshift
	reqs = list(/obj/item/stack/cable_coil = 2,
				/obj/item/stack/rods = 4)
	time = 80
	subcategory = CAT_TOOL
	category = CAT_MISC

/datum/crafting_recipe/makeshift/wrench
	name = "Makeshift Wrench"
	tools = list(/obj/item/hammer/makeshift, /obj/item/screwdriver)
	result = /obj/item/wrench/makeshift
	reqs = list(/obj/item/stack/cable_coil = 2,
				/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/rods = 1)
	time = 80
	subcategory = CAT_TOOL
	category = CAT_MISC
