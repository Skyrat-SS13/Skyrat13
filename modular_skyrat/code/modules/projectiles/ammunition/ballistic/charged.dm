/obj/item/ammo_casing/charged
	name = "charged bullet casing"
	desc = "A unqiue, spacer-tech munition designed for charge weaponry. This one appears unfinished."
	icon = 'modular_skyrat/icon/objguns/chargeweapons.dmi'
	icon_state = "charge_casing"
	caliber = "chargednull"
	projectile_type = /obj/item/projectile/charged
	var/energy_cost = 200

/obj/item/ammo_casing/charged/riflecasing
	name = "CH1212-R bullet casing"
	desc = "A charged shot bullet casing designed for charge rifles. Packs a hefty punch when used correctly."
	caliber = "CH1212-R"
	projectile_type = /obj/item/projectile/charged/rifle

/obj/item/ammo_casing/charged/pistolcasing
	name = "CH1212-P bullet casing"
	desc = "A charged small munition bullet casing designed for charge pistols."
	caliber = "CH1212-P"
	projectile_type = /obj/item/projectile/charged/pistol

/obj/item/ammo_casing/charged/smgcasing
	name = "CH1212-S bullet casing"
	desc = "A charged small munition bullet casing designed for charged SMGs. Less damaging, but the rapid nature of it more than makes up for that fact."
	caliber = "CH1212-S"
	projectile_type = /obj/item/projectile/charged/smg

/obj/item/ammo_casing/charged/shotguncasing
	name = "CH1212-H buckshot"
	desc = "A charged multi-stored bullet casing designed for the power of a charged shotgun. If you see this, hope you aren't on the wrong end of it."
	icon_state = "chshell-live"
	caliber = "CH1212-H"
	projectile_type = /obj/item/projectile/charged/shotgun
	pellets = 6
	variance = 35

/obj/item/ammo_casing/charged/shotguncasing/nonlethal
	name = "CH1212-NH buckshot"
	desc = "A charged multi-stored bullet casing designed ofr the power of a charged shotgun. This variant is much, much less lethal, but just as good at disabling a target."
	icon_state = "nchshell-live"
	caliber = "CH1212-NH"
	projectile_type = /obj/item/projectile/charged/shotgun/nonlethal
	harmful = FALSE

/obj/item/ammo_casing/charged/toy
	name = "toy charged shot casing"
	desc = "A little foam and plastic dart with holographic projectors. Looks almost like the real thing, if you squint."
	icon_state = "toy_charge_casing"
	caliber = "charged foam"
	projectile_type = /obj/item/projectile/charged/rifle/toy
