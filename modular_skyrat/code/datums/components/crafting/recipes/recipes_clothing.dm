//Ablative coat
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
	time = 90
	category = CAT_CLOTHING

//mining hud sunglasses
/datum/crafting_recipe/minesunhud
	name = "Ore Scanner Sunglasses"
	result = /obj/item/clothing/glasses/hud/mining/sunglasses
	reqs = list(/obj/item/clothing/glasses/hud/mining = 1,
				/obj/item/clothing/glasses/sunglasses)
	time = 20
	category = CAT_CLOTHING
