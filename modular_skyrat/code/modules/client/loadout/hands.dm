/datum/gear/skinkit
	name = "General Modification Kit"
	category = SLOT_HANDS
	path = /obj/item/skin_kit

/datum/gear/paicard
	name = "Personal AI device"
	description = "A device, that let you browse and download various AIs."
	category = SLOT_HANDS
	path = /obj/item/paicard
	cost = 2

/datum/gear/miniwelder
	name = "Emergency welding tool"
	category = SLOT_HANDS
	path = /obj/item/weldingtool/mini
	cost = 4
	restricted_desc = "All, barring Service and Civilian"
	restricted_roles = list("Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Research Director", "Chief Medical Officer", "Quartermaster",
							"Medical Doctor", "Chemist", "Virologist", "Geneticist", "Scientist", "Roboticist",
							"Atmospheric Technician", "Station Engineer", "Warden", "Detective", "Security Officer",
							"Cargo Technician", "Shaft Miner")
