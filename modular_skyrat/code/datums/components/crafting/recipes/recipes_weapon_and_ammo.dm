///////////////////////
///WHATEVER CRAFTING///
///////////////////////
/datum/crafting_recipe/glasshatchet
	name = "Makeshift glass hatchet"
	result = /obj/item/hatchet/improvised
	parts = list(/obj/item/shard = 1)
	reqs = list(/obj/item/stack/wrapping_paper = 4,
				/obj/item/wrench = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

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

/datum/crafting_recipe/switchblade_deluxe
	name = "Deluxe Switchblade"
	result = /obj/item/switchblade/deluxe
	reqs = list(/obj/item/switchblade = 1,
				/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/mineral/diamond = 2,
				/obj/item/stack/sheet/mineral/plasma = 5,
				/obj/item/stack/sheet/mineral/titanium = 5,
				/obj/item/stack/sheet/mineral/plastitanium = 1,
				/obj/item/stack/sheet/mineral/gold = 5,
				/obj/item/stock_parts/cell = 1,
				/obj/machinery/igniter = 1)
	time = 250
	tools = list(TOOL_WELDER)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/trayshield
	name = "tray shield"
	result =  /obj/item/shield/riot/trayshield
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/storage/bag/tray = 1,
				/obj/item/stack/cable_coil = 5)
	time = 60
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/shank
	name = "shank"
	result =  /obj/item/shard/shank
	parts = list(/obj/item/shard = 1)
	reqs = list(/obj/item/stack/cable_coil = 1,
				/obj/item/stack/wrapping_paper = 1)
	time = 20
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
	time = 400
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/box_gun
	name = "Box gun"
	result = /obj/item/gun/ballistic/revolver/doublebarrel/contender/box_gun
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/cable_coil = 5,
				/obj/item/storage/box = 1,
				/obj/item/weaponcrafting/receiver = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 60
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/watcherproj
	name = "Watcher Projector"
	result = /obj/item/gun/energy/watcherprojector
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/ore/diamond = 5,
				/obj/item/stack/sheet/sinew = 3,
				/obj/item/weaponcrafting/receiver = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stock_parts/cell/high/plus/argent = 1,
				/obj/item/stock_parts/capacitor = 4,
				/obj/item/stock_parts/micro_laser = 1)
	time = 500
	category = CAT_PRIMAL

/datum/crafting_recipe/makeshiftlasrifle
	name = "makeshift laser rifle"
	result = /obj/item/gun/energy/laser/makeshiftlasrifle
	reqs = list(/obj/item/stack/cable_coil = 30,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/pipe = 1,
				/obj/item/stack/sheet/mineral/diamond = 3,
				/obj/item/weaponcrafting/receiver = 1,
				/obj/item/stock_parts/micro_laser = 1,
				/obj/item/stock_parts/capacitor = 4,
				/obj/item/assembly/igniter = 1)
	parts = list(/obj/item/stock_parts/cell = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_WRENCH)
	time = 250
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/lasermusket
	name = "laser musket"
	result = /obj/item/gun/energy/pumpaction/musket
	reqs = list(/obj/item/stack/cable_coil = 30,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/pipe = 1,
				/obj/item/pipe/bluespace = 1,
				/obj/item/stack/sheet/mineral/uranium = 10,
				/obj/item/stack/sheet/mineral/gold = 3,
				/obj/item/stack/sheet/plasmaglass = 5,
				/obj/item/stock_parts/cell/high = 2,
				/obj/item/assembly/igniter = 3,
				/obj/item/weaponcrafting/receiver = 2,
				/obj/item/stock_parts/micro_laser/high = 4,
				/obj/item/stock_parts/capacitor/adv = 2)
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//////////////////
///AMMO CRAFTING//
//////////////////

/datum/crafting_recipe/makeshiftmagazine
	name = "makeshift pistol magazine (10mm)"
	result = /obj/item/ammo_box/magazine/m10mm/makeshift
	reqs = list(/obj/item/pipe = 1,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/packageWrap = 1)
	time = 75
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/microfusion
	name = "Microfusion Cell"
	result = /obj/item/ammo_casing/microfusion
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stock_parts/cell = 1,
				/obj/item/stock_parts/capacitor = 2)
	tools = list(TOOL_WELDER, TOOL_WRENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

//////////////////
///DUMB CRAFTING//
//////////////////

/datum/crafting_recipe/batonstaff
	name = "Stun Baton Staff"
	result = /obj/item/melee/baton/staff
	reqs = list(/obj/item/melee/baton = 2,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/cable_coil = 5)
	parts = list(/obj/item/stock_parts/cell)
	tools = list(TOOL_WELDER)
	time = 75
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
/datum/crafting_recipe/lockermechdrill
	name = "Makeshift exosuit drill"
	result = /obj/item/mecha_parts/mecha_equipment/drill/makeshift
	reqs = list(/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/surgicaldrill = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 50
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechclamp
	name = "Makeshift exosuit clamp"
	result = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/makeshift
	reqs = list(/obj/item/stack/cable_coil = 5,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/wirecutters = 1) //Don't ask, its just for the grabby grabby thing
	tools = list(TOOL_SCREWDRIVER)
	time = 50
	category = CAT_ROBOT

/datum/crafting_recipe/lockermechchassis
	name = "Makeshift chassis"
	result = /obj/item/mecha_parts/chassis/makeshift
	reqs = list(/obj/item/stack/cable_coil = 10,
				/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 50
	category = CAT_ROBOT

/* it's now built like an actual mech. need to craft makeshift chassis though, which is here.
/datum/crafting_recipe/lockermech
	name = "Locker Mech"
	result = /obj/mecha/makeshift
	reqs = list(/obj/item/stack/cable_coil = 20,
				/obj/item/stack/sheet/metal = 10,
				/obj/item/storage/toolbox = 2, // For feet
				/obj/item/tank/internals/oxygen = 1, // For air
				/obj/item/electronics/airlock = 1, //You are stealing the motors from airlocks
				/obj/item/extinguisher = 1, //For bastard pneumatics
				/obj/item/stack/wrapping_paper = 5, //to make it airtight
				/obj/item/flashlight = 1, //For the mech light
				/obj/item/stack/rods = 4, //to mount the equipment
				/obj/item/pipe = 2) //For legs
	tools = list(/obj/item/weldingtool, /obj/item/screwdriver, /obj/item/wirecutters)
	time = 200
	category = CAT_ROBOT
*/


///////////////////////
///VG WEAPON CRAFTING//
///////////////////////
/datum/crafting_recipe/cylinder
	name = "Aluminum cylinder"
	result = /obj/item/aluminum_cylinder
	reqs = list(/obj/item/reagent_containers/food/drinks/soda_cans = 1)
	tools = list(TOOL_WIRECUTTER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/cylinder
	name = "Cylinder assembly"
	result = /obj/item/cylinder_assembly
	reqs = list(/obj/item/aluminum_cylinder = 2)
	tools = list(NONE)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/barrel
	name = "Makeshift gun barrel"
	result = /obj/item/gun_barrel
	reqs = list(/obj/item/cylinder_assembly = 1)
	tools = list(TOOL_WELDER)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/reservoir
	name = "Fuel reservoir"
	result = /obj/item/fuel_reservoir
	reqs = list(/obj/item/grenade/chem_grenade = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/blade
	name = "Metal blade"
	result = /obj/item/metal_blade
	reqs = list(/obj/item/kitchen/knife = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/largeblade
	name = "Large metal blade"
	result = /obj/item/metal_blade
	reqs = list(/obj/item/kitchen/knife/butcher = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/rails
	name = "Metal rails"
	result = /obj/item/rail_assembly
	reqs = list(/obj/item/wirerod = 1,\
				/obj/item/stack/rods = 5)
	tools = list(TOOL_WELDER)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/beakercylinder
	name = "Beaker cylinder"
	result = /obj/item/cylinder
	reqs = list(/obj/item/reagent_containers/beaker = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/assemblygeneral
	name = "General gun assembly"
	result = /obj/item/gun_assembly/stock_reservoir_assembly
	reqs = list(/obj/item/metal_gun_stock = 1,\
				/obj/item/fuel_reservoir = 1)
	tools = list(TOOL_WRENCH, TOOL_WELDER)
	time = 150
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/assemblygeneralbarreled
	name = "General barreled gun assembly"
	result = /obj/item/gun_assembly/stock_reservoir_barrel_assembly
	reqs = list(/obj/item/gun_assembly/stock_reservoir_assembly = 1,\
				/obj/item/gun_barrel = 1)
	tools = list(TOOL_WRENCH)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/blunderbuss
	name = "Blunderbuss"
	result = /obj/item/blunderbuss
	reqs = list(/obj/item/gun_assembly/stock_reservoir_barrel_assembly = 1,\
				/obj/item/assembly/igniter = 1)
	tools = list(TOOL_WRENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/wiredwrench
	name = "Wired wrench"
	result = /obj/item/wrench_wired
	reqs = list(/obj/item/stack/cable_coil = 5)
	tools = list(NONE)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/cannonassembly
	name = "Wheelchair assembly"
	result = /obj/vehicle/ridden/wheelchair/wheelchair_assembly
	reqs = list(/obj/item/stack/cable_coil = 5,\
				/obj/item/gun_barrel = 1,\
				/obj/vehicle/ridden/wheelchair = 1)
	tools = list(TOOL_WRENCH)
	time = 250
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/cannon
	name = "Wheelchair cannon"
	result = /obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon
	reqs = list(/obj/vehicle/ridden/wheelchair/wheelchair_assembly = 1)
	tools = list(TOOL_WELDER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
