/datum/supply_pack
	var/ultracontraband = FALSE

/datum/supply_pack/emergency/nukeops
	name = "Nuclear Operative Starter Kit"
	desc = "Ever wanted to wear red and blow NT property up? This is your chance! Discounted nuke ops gear and an uplink!"
	cost = 50000
	ultracontraband = TRUE
	contains = list(/obj/item/storage/backpack/duffelbag/syndie/bulldogbundle,
					/obj/item/storage/backpack/duffelbag/syndie/c20rbundle,
					/obj/item/uplink/nuclear)
	crate_name = "nuclear crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/modularpistol
	name = "Modular Pistol Crate"
	desc = "A crate containing 2 modular pistols. For a discounted price!"
	cost = 12000
	ultracontraband = TRUE
	contains = list(/obj/item/gun/ballistic/automatic/pistol/modular,
					/obj/item/gun/ballistic/automatic/pistol/modular)
	crate_name = "modular pistol crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/telecrystals
	name = "Telecrystal Crate"
	desc = "Feeling a bit low on TC? We got your back! This crate contains 20tc."
	cost = 20000
	ultracontraband = TRUE
	contains = list(/obj/item/stack/telecrystal/twenty)
	crate_name = "telecrystals crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/sniper
	name = "Sniper Crate"
	desc = "Need some heavy weaponry? We got ya."
	cost = 20000
	ultracontraband = TRUE
	contains = list(/obj/item/storage/briefcase/sniperbundle)
	crate_name = "sniper crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/c20r
	name = "C20R Crate"
	desc = "Need some crowd control? We got ya."
	cost = 14000
	ultracontraband = TRUE
	contains = list(/obj/item/storage/backpack/duffelbag/syndie/c20rbundle)
	crate_name = "c20r crate"
	crate_type = /obj/structure/closet/crate/internals

/datum/supply_pack/emergency/bulldog
	name = "Bulldog Crate"
	desc = "Need some crowd control? We got ya."
	cost = 13000
	ultracontraband = TRUE
	contains = list(/obj/item/storage/backpack/duffelbag/syndie/bulldogbundle)
	crate_name = "bulldog crate"
	crate_type = /obj/structure/closet/crate/internals