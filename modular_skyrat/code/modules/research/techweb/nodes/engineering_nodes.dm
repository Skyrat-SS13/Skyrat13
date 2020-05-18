/datum/techweb_node/techfab
	id = "adv_engi"
	display_name = "Advanced Fabrication"
	description = "Advanced fabrication methods.."
	prereq_ids = list("high_efficiency")
	design_ids = list("techfab_sec", "techfab_med", "techfab_serv", "techfab_sup", "techfab_sci",)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)



	/datum/design/board/autoylathe
	name = "Machine Design (Autoylathe)"
	desc = "The circuit board for an autoylathe."
	id = "autoylathe"
	build_path = /obj/item/circuitboard/machine/autolathe/toy
	departmental_flags = DEPARTMENTAL_FLAG_ALL
	category = list("Misc. Machinery")
