//holorifle stuff
/datum/design/holorifle
	name = "Holorifle"
	desc = "A bastardization of a shotgun mixed with an energy gun."
	id = "holorifle"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 7500, /datum/material/glass = 2000, /datum/material/uranium = 1000, /datum/material/plasma = 500)
	build_path = /obj/item/gun/ballistic/shotgun/holorifle
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusion
	name = "Microfusion Cell"
	desc = "Ammo for the holorifle."
	id = "microfusion_cell"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 200, /datum/material/uranium = 200)
	build_path = /obj/item/ammo_casing/microfusion
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusionbox
	name = "Microfusion Cell Box"
	desc = "Ammo box for the holorifle."
	id = "microfusion_cell_box"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000, /datum/material/uranium = 1000) //10 times the shots, 10 times the price
	build_path = /obj/item/ammo_box/microfusion
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

//hardsuit armblade
/datum/design/armblade
	name = "Hardsuit Extendable Blade"
	desc = "An armblade attachment for hardsuits."
	id = "armblade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 1000, /datum/material/diamond = 500, /datum/material/gold = 1000, /datum/material/titanium = 2000)
	build_path = /obj/item/melee/transforming/armblade
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

//wt-550
/datum/design/oldsmg
	name = "WT-550 Semi-Auto SMG"
	desc = "An outdated design for a personal defense SMG."
	id = "oldsmg"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 6000, /datum/material/glass = 1000, /datum/material/titanium = 500, /datum/material/gold = 250)
	build_path = /obj/item/gun/ballistic/automatic/wt550
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
