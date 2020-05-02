////////////////////////////////////////
/////// SKYRAT Weapons & Ammo //////////
////////////////////////////////////////

/////////////////
// CHARGE AMMO //
/////////////////
/datum/design/chargepistolammo
	name = "Charged Pistol Magazine"
	desc = "A specialized magazine of charge-compatible ammunition designed for a charged pistol."
	id = "chargepistolammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000, /datum/material/silver = 500, /datum/material/uranium = 500)
	build_path = /obj/item/ammo_box/magazine/charged/chargepistol
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargesmgammo
	name = "Charged SMG Magazine"
	desc = "A specialized magazine of charge-compatible ammunition designed for a charged SMG."
	id = "chargesmgammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 700, /datum/material/uranium = 700)
	build_path = /obj/item/ammo_box/magazine/charged/chargesmg
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargerifleammo
	name = "Charged Rifle Magazine"
	desc = "A specialized magazine of charge-compatible ammunition designed for a charged rifle."
	id = "chargerifleammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 7000, /datum/material/silver = 800, /datum/material/uranium = 800)
	build_path = /obj/item/ammo_box/magazine/charged/chargerifle
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargeshotgunammo
	name = "Charged Shotgun Shot"
	desc = "A specialized charge-compatible buckshot shell designed for a charged shotgun."
	id = "chargeshotammo"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 2000, /datum/material/uranium = 2000)
	build_path = /obj/item/ammo_casing/charged/shotguncasing
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargeshotgunammo/nl
	name = "Nonlethal Charged Shotgun Shot"
	desc = "A specialized charge-compatible riot buckshot shell designed for a charged shotgun."
	id = "chargeshotammo-nl"
	materials = list(/datum/material/iron = 3000, /datum/material/silver = 1500, /datum/material/uranium = 2000)
	build_path = /obj/item/ammo_casing/charged/shotguncasing/nonlethal

//////////////////////
/// CHARGE WEAPONS ///
//////////////////////

/datum/design/chargepistol
	name = "Charged Pistol"
	desc = "An advanced sidearm energy pistol which charges projectiles with unstable energy as they leave the barrel, increasing the damage dealt."
	id = "chargepistol"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 7300, /datum/material/glass = 500, /datum/material/uranium = 950, /datum/material/titanium = 5000, /datum/material/silver = 2000)
	build_path = /obj/item/gun/ballistic/charged/chargepistol/nopin
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargesmg
	name = "Charged SMG"
	desc = "An advanced automatic submachine gun which charges projectiles with unstable energy as they leave the barrel, increasing the damage dealt."
	id = "chargesmg"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 9400, /datum/material/glass = 1000, /datum/material/uranium = 980, /datum/material/titanium = 7000, /datum/material/silver = 3000)
	build_path = /obj/item/gun/ballistic/charged/chargesmg/nopin
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargerifle
	name = "Charged Rifle"
	desc = "An advanced energy rifle which charges projectiles with unstable energy as they leave the barrel, increasing the damage dealt."
	id = "chargerifle"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 9900, /datum/material/glass = 1500, /datum/material/uranium = 2000, /datum/material/titanium = 11500, /datum/material/silver = 3500,)
	build_path = /obj/item/gun/ballistic/charged/chargerifle/nopin
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/chargeshotgun
	name = "Charged Shotgun"
	desc = "An advanced shotgun made in traditional style. Uses pulse technology to charge projectiles with unstable energy as they leave the barrel, increasing the damage dealt."
	id = "chargeshotgun"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 10000, /datum/material/uranium = 6000, /datum/material/titanium = 11500, /datum/material/silver = 8000,)
	build_path = /obj/item/gun/ballistic/shotgun/chargedshotgun/nopin
  
//hardsuit armblade
/datum/design/armblade
	name = "Hardsuit Extendable Blade"
	desc = "An armblade attachment for hardsuits."
	id = "armblade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 5000, /datum/material/diamond = 500, /datum/material/gold = 1500, /datum/material/titanium = 5000)
	build_path = /obj/item/melee/transforming/armblade
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
