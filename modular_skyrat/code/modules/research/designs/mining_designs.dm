//advanced shovel technology bro
/datum/design/titanium_shovel
	name = "Titanium Shovel"
	desc = "Dig dug."
	id = "titanium_shovel"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 1500, /datum/material/iron = 500)
	build_path = /obj/item/shovel/titanium
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/wide_titanium_shovel
	name = "Wide Titanium Shovel"
	desc = "Dig dug x3."
	id = "wide_titanium_shovel"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 4500, /datum/material/iron = 1500)
	build_path = /obj/item/shovel/wide/titanium
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/diamond_shovel
	name = "Diamond Shovel"
	desc = "Don't dig straight down."
	id = "diamond_shovel"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 1250, /datum/material/titanium = 4000)
	build_path = /obj/item/shovel/diamond
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/wide_diamond_shovel
	name = "Wide Diamond Shovel"
	desc = "Don't dig straight up."
	id = "wide_diamond_shovel"
	build_type = PROTOLATHE
	materials = list(/datum/material/diamond = 4000, /datum/material/titanium = 8000)
	build_path = /obj/item/shovel/wide/diamond
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO
