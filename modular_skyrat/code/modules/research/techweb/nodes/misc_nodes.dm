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

// Sticky tape
/datum/techweb_node/sticky_basic
	id = "sticky_basic"
	display_name = "Basic Sticky Technology"
	description = "The only thing left to do after researching this tech is to start printing out a bunch of 'kick me' signs."
	prereq_ids = list("adv_engi", "high_efficiency")
	design_ids = list("sticky_tape")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
	hidden = FALSE
	experimental = FALSE

// Can be researched after getting the basic sticky technology
/datum/techweb_node/sticky_advanced
	id = "sticky_advanced"
	display_name = "Advanced Sticky Technology"
	description = "Taking a good joke too far? Nonsense!"
	prereq_ids = list("sticky_basic")
	design_ids = list("super_sticky_tape", "pointy_tape", "surgical_sticky_tape")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)
	hidden = FALSE
	experimental = FALSE

// Nyanites
/datum/techweb_node/nanite_smart
	design_ids = list("purging_nanites", "research_nanites", "metabolic_nanites", "stealth_nanites", "memleak_nanites","sensor_voice_nanites", "voice_nanites", "signaler_nanites")
