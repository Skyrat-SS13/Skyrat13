/datum/dynamic_ruleset/event/tiger_carp_frenzy
	name = "Tiger Carp Frenzy"
	config_tag = "tiger_carp_frenzy"
	typepath = /datum/round_event/tiger_carp_frenzy
	weight = 6
	repeatable_weight_decrease = 3
	cost = 4
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	high_population_requirement = 15
	earliest_start = 10 MINUTES
	repeatable = TRUE
	property_weights = list("extended" = 1)
