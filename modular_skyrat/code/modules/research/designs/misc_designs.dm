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
	name = "Ore Scanner HUD"
	desc = "A heads-up display that scans the surrounding ores and displays them to the user. This one has a prescription lens."
	id = "mining_hud_prescription"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 850, /datum/material/glass = 500, /datum/material/uranium = 500)
	build_path = /obj/item/clothing/glasses/hud/mining/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/mining_hud_mesons
	name = "Meson Ore Scanner HUD"
	desc = "A heads-up display that scans the surrounding ores and displays them to the user. This one also doubles as mesons."
	id = "mining_hud_meson"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 850, /datum/material/glass = 500, /datum/material/uranium = 500)
	build_path = /obj/item/clothing/glasses/hud/mining/meson
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/mining_hud_fauna
	name = "Ore and Fauna Scanner HUD"
	desc = "A heads-up display that scans the surrounding ores and displays them to the user. This one is able to scan fauna and megafauna health statuses."
	id = "mining_hud_fauna"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 850, /datum/material/glass = 500, /datum/material/uranium = 500)
	build_path = /obj/item/clothing/glasses/hud/mining/fauna
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO
