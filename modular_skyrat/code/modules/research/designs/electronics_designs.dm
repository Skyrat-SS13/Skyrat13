
///////////////////////////////////
///////////Techfab Stuff///////////
///////////////////////////////////

/datum/design/techfab
		materials = list(/datum/material/iron = 200, /datum/material/glass = 1000, /datum/material/plastic = 1000, /datum/material/silver = 1000)
		build_type = IMPRINTER
		construction_time = 100

/datum/design/techfab/cargo
	name = "cargo techfab circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_cargo"
	build_path = /obj/item/circuitboard/machine/techfab/department/cargo
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/med
	name = "medical techfab circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_sci"
	build_path = /obj/item/circuitboard/machine/techfab/department/medical
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/sci
	name = "science techfab circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_sci"
	build_path = /obj/item/circuitboard/machine/techfab/department/science
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/sec
	name = "security techfab circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_sec"
	build_path = /obj/item/circuitboard/machine/techfab/department/security
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/sup
	name = "service techfab circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_serve"
	build_path = /obj/item/circuitboard/machine/techfab/department/service
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE | DEPARTMENTAL_FLAG_SCIENCE
