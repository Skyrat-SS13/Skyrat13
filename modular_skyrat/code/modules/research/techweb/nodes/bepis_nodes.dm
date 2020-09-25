//Overpowered synthetic construction
/datum/techweb_node/advanced_ipc_construction
	id = "advanced_ipc_construction"
	display_name = "Advanced Sapient Synthetics"
	description = "With experimental mechatronic technology, we are able to build near-perfect sapient beings."
	design_ids = list("android_chassis", "military_synth_chassis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 16000)
	hidden = TRUE
	experimental = TRUE

//Auto-mender
/datum/techweb_node/automender
	id = "mki_automender"
	display_name = "Auto-mender"
	description = "Advanced, and very sticky, healing."
	prereq_ids = list("sticky_basic")
	design_ids = list("automender")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	hidden = TRUE
	experimental = TRUE
