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

//////////////////
///AMMO CRAFTING//
//////////////////

/datum/crafting_recipe/pipepistol
	name = "makeshift pistol magazine (10mm)
	result = /obj/item/ammo_box/magazine/m10mm/makeshift
	reqs = list(/obj/item/pipe = 1,
				/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/packageWrap = 1)