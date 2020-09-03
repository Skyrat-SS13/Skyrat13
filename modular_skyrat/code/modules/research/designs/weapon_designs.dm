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

//WT-550
/datum/design/wt550
	name = "WT-550"
	desc = "An outdated, but timeless, design for an SMG."
	id = "wt550"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2500, /datum/material/silver = 2000, /datum/material/titanium = 6000)
	build_path = /obj/item/gun/ballistic/automatic/wt550/nopin
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

//Advanced armor vest
/datum/design/adv_vest
	name = "Advanced Armor Vest"
	desc = "Future of law enforcement."
	id = "adv_armor_vest"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 5000, /datum/material/plasma = 5000, /datum/material/plastic = 2000)
	build_path = /obj/item/clothing/suit/armor/vest/advanced
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

//Advanced techarmor vest
/datum/design/adv_techvest
	name = "Advanced Techarmor Vest"
	desc = "Post-Future of law enforcement."
	id = "adv_armor_vest_tech"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 9000, /datum/material/plasma = 6000, /datum/material/plastic = 3000)
	build_path = /obj/item/clothing/suit/space/hardsuit/security_armor/cloaker
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

//Advanced night vision helmet
/datum/design/adv_helmet
	name = "Night-Vision Helmet"
	desc = "Fear of the dark."
	id = "nv_helmet"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 2000, /datum/material/uranium = 4000, /datum/material/plastic = 3000)
	build_path = /obj/item/clothing/head/helmet/advanced
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

//Combat tackle gloves
/datum/design/gorilla_gloves
	name = "Gorilla Gloves"
	desc = "The best way to tackle your problems."
	id = "tackle_combat"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 2000, /datum/material/gold = 3000, /datum/material/plastic = 5000)
	build_path = /obj/item/clothing/gloves/tackler/combat
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
