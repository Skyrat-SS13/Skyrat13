datum/uplink_item/role_restricted/crusher
	name = "Harmful Crusher"
	desc = "A kinetic crusher with the ability to harm complex and small lifeforms. Looks like a normal crusher from a distance."
	item = /obj/item/twohanded/kinetic_crusher/harm
	cost = 15
	limited_stock = 1
	restricted_roles = list("Shaft Miner")

/datum/uplink_item/role_restricted/pka_tenmm
	name = "10mm Proto-Kinetic Accelerator"
	desc = "An accelerator loaded in 10mm bullets. Accepts normal PKA mods and suffers no pressure penalty, and looks like a normal accelerator from a distance."
	item = /obj/item/gun/energy/kinetic_accelerator/tenmm
	cost = 8
	limited_stock = 2
	restricted_roles = list("Shaft Miner")

/datum/uplink_item/role_restricted/independence
	name = "Declaration of independence"
	desc = "Free cargo from NT's grasp! Declares the independence of cargo and makes the Syndicate your new supplier for cargo."
	item = /obj/item/card/emag/independence
	cost = 20
	limited_stock = 1
	restricted_roles = list("Shaft Miner", "Cargo Technician", "Quartermaster")