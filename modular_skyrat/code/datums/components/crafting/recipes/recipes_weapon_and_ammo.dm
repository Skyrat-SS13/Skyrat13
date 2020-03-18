/datum/crafting_recipe/switchblade_ms
	name = "Switchblade"
	result = /obj/item/switchblade/crafted
	reqs = list(/obj/item/weaponcrafting/stock = 1,
				/obj/item/weaponcrafting/receiver = 1,
				/obj/item/kitchen/knife = 1,
				/obj/item/stack/cable_coil = 2)
	tools = list(TOOL_WELDER)
	time = 45
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//////////////////
///GUNS CRAFTING//
//////////////////

/datum/crafting_recipe/pipepistol
	name = "Pipe Pistol(10mm)"
	result = /obj/item/gun/ballistic/automatic/pistol/makeshift
	reqs = list(/obj/item/weaponcrafting/receiver = 1,
				/obj/item/pipe = 2,
				/obj/item/stack/sheet/mineral/wood = 7,
				/obj/item/stack/packageWrap = 5)
	tools = list(TOOL_WELDER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/holorifle //gonna need to work for this
	name = "Holorifle"
	result = /obj/item/gun/ballistic/shotgun/holorifle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/cable_coil = 15,
				/obj/item/gun/ballistic/shotgun/riot = 1,
				/obj/item/stack/packageWrap = 5,
				/obj/item/stock_parts/capacitor/super = 1,
				/obj/item/circuitboard/machine/holopad = 1)
	tools = list(TOOL_WELDER, TOOL_WRENCH, TOOL_WIRECUTTER, TOOL_MULTITOOL)
	time = 300
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//////////////////
///AMMO CRAFTING//
//////////////////

/datum/crafting_recipe/makeshiftmagazine
	name = "makeshift pistol magazine (10mm)"
	result = /obj/item/ammo_box/magazine/m10mm/makeshift
	reqs = list(/obj/item/pipe = 1,
				/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/packageWrap = 1)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/microfusion
	name = "Microfusion Cell"
	result = /obj/item/ammo_casing/microfusion
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stock_parts/cell/super = 1,
				/obj/item/stock_parts/capacitor/super = 2,
				/obj/item/stock_parts/micro_laser/ultra = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_MULTITOOL)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO