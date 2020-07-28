//fucking clothes
//Ablative trenchcoat
/datum/crafting_recipe/ablativecoat
	name = "Ablative Trenchcoat"
	result = /obj/item/clothing/suit/hooded/ablative
	reqs = list(/obj/item/clothing/suit/armor/laserproof = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/mineral/diamond = 2,
				/obj/item/stack/sheet/plasmaglass = 3, //plasmarglass is just too much
				/obj/item/clothing/glasses/hud/security/sunglasses = 1,
				/obj/item/stock_parts/cell/high = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 75
	category = CAT_CLOTHING

/datum/crafting_recipe/hazardarmor
	name = "Hazard Vest Armor"
	result =  /obj/item/clothing/suit/armor/hazard
	reqs = list(/obj/item/stack/packageWrap = 5,
				/obj/item/stack/sheet/plasteel = 2,
				/obj/item/clothing/suit/hazardvest = 1)
	time = 60
	category = CAT_CLOTHING


//mining hud sunglasses
/datum/crafting_recipe/minesunhud
	name = "Ore Scanner Sunglasses"
	result = /obj/item/clothing/glasses/hud/mining/sunglasses
	reqs = list(/obj/item/clothing/glasses/hud/mining = 1,
				/obj/item/clothing/glasses/sunglasses = 1)
	time = 30
	category = CAT_CLOTHING

/datum/crafting_recipe/mineprescriptionsunhud
	name = "Ore Scanner Prescription Sunglasses"
	result = /obj/item/clothing/glasses/hud/mining/prescription/sunglasses
	reqs = list(/obj/item/clothing/glasses/hud/mining/prescription = 1,
				/obj/item/clothing/glasses/sunglasses = 1)
	time = 30
	category = CAT_CLOTHING
