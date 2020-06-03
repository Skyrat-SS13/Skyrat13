/datum/techweb_node/techfab
	id = "adv_engi"
	display_name = "Advanced Fabrication"
	description = "Advanced fabrication methods.."
	prereq_ids = list("high_efficiency")
	design_ids = list("techfab_sec", "techfab_med", "techfab_serv", "techfab_sup", "techfab_sci",)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)



/datum/design/encryption
		materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 200)
		build_type = PROTOLATHE | IMPRINTER
		construction_time = 50

/datum/design/encryption/eng_key
	name = "Engineering radio encryption key"
	desc = "Encryption key for the Engineering channel."
	id = "eng_key"
	build_path = /obj/item/encryptionkey/headset_eng
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING
