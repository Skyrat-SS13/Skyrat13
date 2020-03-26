//shock collars and etc
/datum/design/shockcollar
	name = "Shock Collar"
	desc = "A collar. That can be shocked."
	id = "shock_collar"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/electropack/shockcollar
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/shockcollarglue
	name = "Sticky Shock Collar"
	desc = "A collar. That can be shocked. And can't be taken off."
	id = "shock_collar_glue"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500)
	build_path = /obj/item/electropack/shockcollar/security
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/pacifyingcollar
	name = "Sticky Pacifying Collar"
	desc = "A collar. That pacifies. And can't be taken off."
	id = "pacify_collar"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/uranium = 500)
	build_path = /obj/item/electropack/shockcollar/pacify/security
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/pacifyingshockcollar
	name = "Sticky Pacifying Shock Collar"
	desc = "A collar. That pacifies. And shocks. And can't be taken off."
	id = "pacify_collar_shock"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 2000, /datum/material/diamond = 1000, /datum/material/uranium = 500)
	build_path = /obj/item/electropack/shockcollar/pacify/security/shock
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/collarremover
	name = "Collar Remover"
	desc = "A device to remove collars without harming it's user."
	id = "collar_remover"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500, /datum/material/silver = 1000, /datum/material/uranium = 500)
	build_path = /obj/item/wirecutters/collarremover
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY