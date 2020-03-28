//fucking clothes
/datum/crafting_recipe/ablativecoat
	name = "Ablative Trenchcoat"
	result = /obj/item/clothing/suit/hooded/ablative
	reqs = list(/obj/item/clothing/suit/armor/laserproof = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/mineral/diamond = 2,
				/obj/item/stack/sheet/plasmarglass = 3,
				/obj/item/clothing/glasses/hud/security/sunglasses = 1,
				/obj/item/stock_parts/cell/high = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 75
	category = CAT_CLOTHING

/datum/crafting_recipe/hazardarmor
	name = "hazard vest armor"
	result =  /obj/item/clothing/suit/armor/hazard
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/cable_coil = 15,
				/obj/item/stack/sheet/plasteel = 2,
				/obj/item/clothing/suit/hazardvest = 1,
				/obj/item/stack/wrapping_paper = 5)
	time = 60
	category = CAT_CLOTHING