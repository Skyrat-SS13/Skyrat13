//Overpowered synthetic construction
/datum/techweb_node/advanced_ipc_construction
	id = "advanced_ipc_construction"
	display_name = "Advanced Sapient Synthetics"
	description = "With experimental mechatronic technology, we are able to build near-perfect sapient beings."
	design_ids = list("android_chassis", "military_synth_chassis", "corporate_chassis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 16000)
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/hacking_equipment
	id = "hacking_equipment"
	display_name = "Advanced Technological Interfacing"
	description = "Experimental implants designed made to interface with and modify machines and technology better than anything thought of previously."
	prereq_ids = list("adv_cyber_implants")
	design_ids = list("ci-hacker")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 12000)
	hidden = TRUE
	experimental = TRUE
