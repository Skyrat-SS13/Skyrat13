//i dont know what classifies a cargo thing as special.
/datum/supply_pack/security/armory/doublebarrels
	name = "Double-Barreled Shotgun Crate"
	desc = "For when the bartender spaces his one. Or, when you have a tight budget."
	cost = 3500
	contains = list(/obj/item/gun/ballistic/revolver/doublebarrel,
					/obj/item/gun/ballistic/revolver/doublebarrel,
					/obj/item/gun/ballistic/revolver/doublebarrel,
					/obj/item/storage/box/rubbershot,
					/obj/item/storage/box/beanbag)
	crate_name = "double barrel shotgun crate"

/datum/supply_pack/security/armory/revolver
	name = ".38 Revolver Crate"
	desc = "Sometimes, the mysterious stranger doesn't come. Then you do it yourself."
	cost = 12000
	contains = list(/obj/item/gun/ballistic/revolver/detective,
					/obj/item/gun/ballistic/revolver/detective,
					/obj/item/gun/ballistic/revolver/detective,
					/obj/item/ammo_box/c38,
					/obj/item/ammo_box/c38,
					/obj/item/ammo_box/c38)
	crate_name = "mars special crate"

/datum/supply_pack/security/armory/usp
	name = "USP pistol Crate"
	desc = "Why are 9mm guns still a thing? Well, you can still get them anyways."
	cost = 4500
	contains = list(/obj/item/gun/ballistic/automatic/pistol/uspm,
					/obj/item/gun/ballistic/automatic/pistol/uspm,
					/obj/item/gun/ballistic/automatic/pistol/uspm,
					/obj/item/ammo_box/magazine/usp,
					/obj/item/ammo_box/magazine/usp,
					/obj/item/ammo_box/magazine/usp)
	crate_name = "USP pistols crate"

/datum/supply_pack/security/armory/combine
	name = "Civil Protection Crate"
	desc = "With this crate, you'll never deadline on the frontlines. Contains full Civil Protection clothing (including hardsuit), a stun baton and an USP pistol with spare magazines."
	cost = 8000
	contains = list(/obj/item/clothing/under/rank/security/civilprotection,
					/obj/item/clothing/head/helmet/cphood,
					/obj/item/gun/ballistic/automatic/pistol/uspm,
					/obj/item/clothing/suit/armor/vest/cparmor,
					/obj/item/clothing/mask/gas/sechailer/cpmask,
					/obj/item/ammo_box/magazine/usp,
					/obj/item/ammo_box/magazine/usp,
					/obj/item/melee/baton,
					/obj/item/clothing/suit/space/hardsuit/security/metrocop)
	crate_name = "metrocop crate"