//i dont know what classifies a cargo thing as special.
/datum/supply_pack/security/armory/nangler
	name = "9mm Pistol Crate"
	desc = "Contains 3 loaded ML Nangler pistols, extra mag included for each."
	cost = 6000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/nangler,
					/obj/item/gun/ballistic/automatic/pistol/nangler,
					/obj/item/gun/ballistic/automatic/pistol/nangler,
					/obj/item/ammo_box/magazine/nangler,
					/obj/item/ammo_box/magazine/nangler,
					/obj/item/ammo_box/magazine/nangler)
	crate_name = "9mm pistols crate"

/datum/supply_pack/security/armory/nangler_ammo
	name = "9mm Pistol Ammo Crate"
	desc = "Contains 3 ML Nangler magazines."
	cost = 2000
	contains = list(/obj/item/ammo_box/magazine/nangler,
					/obj/item/ammo_box/magazine/nangler,
					/obj/item/ammo_box/magazine/nangler)
	crate_name = "9mm pistol ammo crate"

/datum/supply_pack/security/armory/blackbaton
	name = "Black Baton Crate"
	desc = "Contains 3 high quality police batons."
	cost = 2000
	contains = list(/obj/item/melee/classic_baton/black,
					/obj/item/melee/classic_baton/black,
					/obj/item/melee/classic_baton/black,
					)
	crate_name = "black baton crate"

/datum/supply_pack/emergency/syndicate
	name = "NULL_ENTRY"
	desc = "(#@&^$THIS PACKAGE CONTAINS 30TC WORTH OF SOME RANDOM SYNDICATE GEAR WE HAD LYING AROUND THE WAREHOUSE. GIVE 'EM HELL OPERATIVE@&!*() "
	hidden = TRUE
	cost = 20000
	contains = list()
	crate_name = "emergency crate"
	crate_type = /obj/structure/closet/crate/internals
	dangerous = TRUE

/datum/supply_pack/emergency/syndicate/fill(obj/structure/closet/crate/C)
	var/crate_value = 30
	var/list/uplink_items = get_uplink_items(SSticker.mode)
	while(crate_value)
		var/category = pick(uplink_items)
		var/item = pick(uplink_items[category])
		var/datum/uplink_item/I = uplink_items[category][item]
		if(!I.surplus_nullcrates || prob(100 - I.surplus_nullcrates))
			continue
		if(crate_value < I.cost)
			continue
		crate_value -= I.cost
		new I.item(C)

//maint energy crate
/datum/supply_pack/emergency/maint_energy
	name = "Maintenance Energy Freezer"
	desc = "A freezer, containing a six pack of maint energy to keep you hydrated and energized."
	contains = list()
	contraband = TRUE
	cost = 1000
	crate_name = "maintenance energy freezer"
	crate_type = /obj/structure/closet/crate/maint_energy

/datum/supply_pack/emergency/maint_energy/fill(obj/structure/closet/crate/C)
	var/list/drinktypepaths = typesof(/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy) - list(/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/blood_red)
	var/list/illegaldrinks = list(/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/blood_red)
	for(var/i in 1 to 6)
		var/chosen = pick(drinktypepaths)
		if(prob(1))
			chosen = pick(illegaldrinks)
		new chosen(C)

/obj/structure/closet/crate/maint_energy
	name = "maintenance energy freezer"
	desc = "<i>Sips.</i> Yep."
	icon = 'modular_skyrat/icons/obj/crates.dmi'
	icon_state = "maintenergy"

/obj/structure/closet/crate/maint_energy/loaded/PopulateContents()
	var/list/drinktypepaths = typesof(/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy) - list(/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/blood_red)
	var/list/illegaldrinks = list(/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/blood_red)
	for(var/i in 1 to 6)
		var/chosen = pick(drinktypepaths)
		if(prob(1))
			chosen = pick(illegaldrinks)
		new chosen(src)
