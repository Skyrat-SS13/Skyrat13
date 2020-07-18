/////////////////////////////////////////
/////////////////HUDs////////////////////
/////////////////////////////////////////

/datum/design/mining_hud
	name = "Ore Scanner HUD"
	desc = "A heads-up display that scans the surrounding ores and displays them to the user."
	id = "mining_hud"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 500, /datum/material/glass = 500, /datum/material/uranium = 500)
	build_path = /obj/item/clothing/glasses/hud/mining
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/mining_hud_prescription
	name = "Ore Scanner HUD (Prescription)"
	desc = "A heads-up display that scans the surrounding ores and displays them to the user. This one has a prescription lens."
	id = "mining_hud_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 850, /datum/material/glass = 500, /datum/material/uranium = 500)
	build_path = /obj/item/clothing/glasses/hud/mining/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/////////////////////////////////////////
/////////////////Tape////////////////////
/////////////////////////////////////////

/datum/design/sticky_tape
	name = "Sticky Tape"
	id = "sticky_tape"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	build_path = /obj/item/stack/sticky_tape
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/super_sticky_tape
	name = "Super Sticky Tape"
	id = "super_sticky_tape"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 3000)
	build_path = /obj/item/stack/sticky_tape/super
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/pointy_tape
	name = "Pointy Tape"
	id = "pointy_tape"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1500, /datum/material/plastic = 1000)
	build_path = /obj/item/stack/sticky_tape/pointy
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
