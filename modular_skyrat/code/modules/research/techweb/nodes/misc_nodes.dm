/datum/techweb_node/computermath
	id = "computermath"
	display_name = "Problem Computer"
	description = "Solve problems for either cargo credits or research points."
	prereq_ids = list("base")
	design_ids = list("computermath")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

/datum/techweb_node/encryption
	id = "encryption_key"
	display_name = "Communication Encryption"
	description = "Study into usage of frequencies within headsets and their repoduction."
	prereq_ids = list("telecomms")
	design_ids = list("eng_key", "sci_key", "med_key", "supply_key", "serv_key")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)

/datum/techweb_node/nanite_smart
	design_ids = list("purging_nanites", "research_nanites", "metabolic_nanites", "stealth_nanites", "memleak_nanites","sensor_voice_nanites", "voice_nanites", "signaler_nanites")
