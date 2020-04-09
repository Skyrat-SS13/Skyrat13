/obj/item/ammo_casing/charged
	name = "charged bullet casing"
	desc = "A unqiue, spacer-tech munition designed for charge weaponry. This one appears unfinished."
	icon = 'modular_skyrat/icons/obj/guns/chargeweapons.dmi'
	icon_state = "charge_casing"
	caliber = "chargednull"
	projectile_type = /obj/item/projectile/charged
	var/energy_cost = 200

/obj/item/ammo_casing/charged/riflecasing
	name = "CH1212-R bullet casing"
	desc = "A charged shot bullet casing designed for charge rifles."
	caliber = "CH1212-R"
	projectile_type = /obj/item/projectile/charged/rifle
	energy_cost = 200

/obj/item/ammo_casing/charged/pistolcasing
	name = "CH1212-P bullet casing"
	desc = "A charged small munition bullet casing designed for charge pistols."
	caliber = "CH1212-P"
	projectile_type = /obj/item/projectile/charged/pistol
	energy_cost = 200

/obj/item/ammo_casing/charged/smgcasing
	name = "CH1212-S bullet casing"
	desc = "A charged small munition bullet casing designed for charged SMGs."
	caliber = "CH1212-S"
	projectile_type = /obj/item/projectile/charged/smg
	energy_cost = 200

/obj/item/ammo_casing/charged/shotguncasing
	name = "CH1212-H buckshot"
	desc = "A charged multi-stored bullet casing designed for the power of a charged shotgun."
	icon = 'modular_skyrat/icons/obj/shomtgun.dmi'
	icon_state = "chshell"
	caliber = "CH1212-H"
	projectile_type = /obj/item/projectile/charged/shotgun
	pellets = 6
	variance = 35
	energy_cost = 200

/obj/item/ammo_casing/charged/shotguncasing/nonlethal
	name = "CH1212-NH buckshot"
	desc = "A charged multi-stored bullet casing designed ofr the power of a charged shotgun."
	icon_state = "nchshell"
	caliber = "CH1212-NH"
	projectile_type = /obj/item/projectile/charged/shotgun/nonlethal
	harmful = FALSE
	energy_cost = 200
