//BS miner
/datum/design/board/bluespace_miner
	name = "Machine Design (Bluespace Miner)"
	desc = "The circuit board for a Bluespace Miner."
	id = "bluespace_miner"
	build_path = /obj/item/circuitboard/machine/bluespace_miner
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

//telescience
/datum/design/board/telepad
	name = "Machine Design (Telepad Board)"
	desc = "The circuit board for a telescience telepad."
	id = "telepad"
	build_path = /obj/item/circuitboard/machine/telesci_pad
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/telesci_console
	name = "Computer Design (Telepad Control Console Board)"
	desc = "Allows for the construction of circuit boards used to build a telescience console."
	id = "telesci_console"
	build_path = /obj/item/circuitboard/computer/telesci_console
	category = list("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

//Cryptocurrency Miners
/datum/design/board/cryptominer
	name = "Machine Design (Cryptocurrency Miner)"
	desc = "The circuit board for a Cryptocurrency Miner."
	id = "cryptominer"
	build_path = /obj/item/circuitboard/machine/cryptominer
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/cryptominer/syndie
	name = "Machine Design (Syndicate Cryptocurrency Miner)"
	desc = "The circuit board for a Syndicate Cryptocurrency Miner."
	id = "cryptominersyndie"
	build_path = /obj/item/circuitboard/machine/cryptominer/syndie
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

//Wireless Chargers
/datum/design/board/wireless/cells
	name = "Machine Design (Wireless Cell Charger)"
	desc = "A circuitboard for wirelessly charging cells."
	id = "wireless_cells"
	build_path = /obj/item/circuitboard/machine/wirelesscharger/cells
	category = list("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/wireless/guns
	name = "Machine Design (Wireless Weapon Charger)"
	desc = "A circuitboard for wirelessly charging weapons."
	id = "wireless_guns"
	build_path = /obj/item/circuitboard/machine/wirelesscharger/guns
	category = list("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
