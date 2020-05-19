
///////////////////////////////////
///////////Techfab Stuff///////////
///////////////////////////////////

/datum/design/techfab
		materials = list(/datum/material/glass = 900, /datum/material/silver = 1500)
		build_type = IMPRINTER
		construction_time = 200
		category = list("Misc. Machinery")

/datum/design/techfab/cargo
	name = "Cargo Techfab Circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_cargo"
	build_path = /obj/item/circuitboard/machine/techfab/department/cargo
	departmental_flags = DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/med
	name = "Medical Techfab Circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_med"
	build_path = /obj/item/circuitboard/machine/techfab/department/medical
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/sci
	name = "Science Techfab Circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_sci"
	build_path = /obj/item/circuitboard/machine/techfab/department/science
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/sec
	name = "Security Techfab Circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_sec"
	build_path = /obj/item/circuitboard/machine/techfab/department/security
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/techfab/sup
	name = "Service Techfab Circuitboard"
	desc = "Circuitboard used within tech fabricators."
	id = "techfab_serv"
	build_path = /obj/item/circuitboard/machine/techfab/department/service
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE | DEPARTMENTAL_FLAG_SCIENCE
