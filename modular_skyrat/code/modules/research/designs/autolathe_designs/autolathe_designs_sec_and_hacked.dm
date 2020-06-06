///////////////////////////////////
//////////Autolathe Designs ///////
///////////////////////////////////

/////////////
////Secgear//
/////////////

/datum/design/c9mmrubber
	name = "9mm Rubber Box"
	id = "9mm_rubber_box"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 8000)
	build_path = /obj/item/ammo_box/c9mm/rubber
	category = list("initial", "Security")

/datum/design/c9mmrubbermag
	name = "9mm Rubber Magazine"
	id = "9mm_rubber_mag"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 7000)
	build_path = /obj/item/ammo_box/magazine/usp
	category = list("initial", "Security")

/datum/design/mag22
	name = ".22 Magnum Cartridge"
	id = "mag22_casing"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/mag22
	category = list("hacked", "Security")

/datum/design/mag22_box
	name = ".22 Magnum Box"
	id = "mag22_box"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 10000)
	build_path = /obj/item/ammo_box/mag22
	category = list("hacked", "Security")

////////////
//Crafting//
////////////

/datum/design/generic_receiver
	name = "Modular Receiver"
	id = "generic_receiver"
	build_type = AUTOLATHE | NO_PUBLIC_LATHE
	materials = list(/datum/material/iron = 12000)
	build_path = /obj/item/weaponcrafting/improvised_parts/generic_receiver
	category = list("hacked", "Security")
