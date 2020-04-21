//fucking clothes
//Ablative trenchcoat
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
	result =  /obj/item/clothing/suit/hazardvest/armor
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/cable_coil = 15,
				/obj/item/stack/sheet/plasteel = 2,
				/obj/item/clothing/suit/hazardvest = 1,
				/obj/item/stack/wrapping_paper = 5)
	time = 60
	category = CAT_CLOTHING

//Power armor (no longer used, see mecha_construction_paths.dm)
/*
/datum/crafting_recipe/powerarmor
	name = "Self-Powered Exoskeleton Rig" //I tried to make it a mecha assembly but that went tits up at every turn so now you get this. Fuck modular, and fuck whoever made mech code.
	result = /obj/item/clothing/suit/space/hardsuit/powerarmor
	reqs = list(/obj/item/mecha_parts/part/powerarmor_chassis = 1,
				/obj/item/mecha_parts/part/powerarmor_torso = 1,
				/obj/item/mecha_parts/part/powerarmor_helmet = 1,
				/obj/item/mecha_parts/part/powerarmor_left_arm = 1,
				/obj/item/mecha_parts/part/powerarmor_right_arm = 1,
				/obj/item/mecha_parts/part/powerarmor_left_leg = 1,
				/obj/item/mecha_parts/part/powerarmor_right_leg = 1,
				/obj/item/stack/ore/bluespace_crystal = 5,
				/obj/item/stack/cable_coil = 5,
				/obj/item/stock_parts/capacitor/quadratic = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WRENCH)
	time = 1200
	category = CAT_CLOTHING
*/
