//holorifle stuff
/datum/design/holorifle
	name = "Holorifle"
	desc = "A bastardization of a shotgun mixed with an energy gun."
	id = "holorifle"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000, /datum/material/uranium = 2000)
	build_path = /obj/item/gun/ballistic/shotgun/holorifle
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusion
	name = "Microfusion Cell"
	desc = "Ammo for the holorifle."
	id = "microfusion_cell"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 200, /datum/material/uranium = 250)
	build_path = /obj/item/ammo_casing/microfusion
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/microfusionbox
	name = "Microfusion Cell Box"
	desc = "Ammo box for the holorifle."
	id = "microfusion_cell_box"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000, /datum/material/uranium = 2500) //10 times the shots, 10 times the price
	build_path = /obj/item/ammo_box/microfusion
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

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

//Black police baton
/datum/design/blackbaton
	name = "Black Police Baton"
	desc = "A timeless classic of law enforcement."
	id = "blackbaton"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 5000, /datum/material/iron = 2000)
	build_path = /obj/item/melee/classic_baton/black
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
