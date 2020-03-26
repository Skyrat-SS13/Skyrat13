//shock collars and etc
/datum/design/shockcollar
	name = "Shock Collar"
	desc = "A collar. That can be shocked."
	id = "shock_collar"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500)
	build_path = /obj/item/electropack/shockcollar/security
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/pacifyingcollar
	name = "Pacifying Collar"
	desc = "A collar. That pacifies."
	id = "pacify_collar"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/uranium = 500)
	build_path = /obj/item/electropack/shockcollar/pacify/security
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/pacifyingshockcollar
	name = "Pacifying Shock Collar"
	desc = "A collar. That pacifies. And shocks."
	id = "pacify_collar_shock"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 2000, /datum/material/diamond = 1000, /datum/material/uranium = 500)
	build_path = /obj/item/electropack/shockcollar/pacify/security/shock
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY