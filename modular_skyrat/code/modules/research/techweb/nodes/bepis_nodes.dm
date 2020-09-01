//Overpowered synthetic construction
/datum/techweb_node/advanced_ipc_construction
	id = "advanced_ipc_construction"
	display_name = "Advanced Sapient Synthetics"
	description = "With experimental mechatronic technology, we are able to build near-perfect sapient beings."
	design_ids = list("android_chassis", "military_synth_chassis", "corporate_chassis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 16000)
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/special_weapons_and_tactics
	id = "swat_weapons"
	display_name = "Special Weapons And Tactics"
	description = "Sometimes, standard protocol isn't enough."
	prereq_ids = list("ballistic_weapons", "NVGtech")
	design_ids = list("wt550", "tackle_combat", "blackbaton", "nv_helmet", "adv_armor_vest", "adv_armor_vest_tech")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 8000)
	hidden = TRUE
	experimental = TRUE
