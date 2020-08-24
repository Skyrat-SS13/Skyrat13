/datum/techweb_node/special_weapons_and_tactics
	id = "swat_weapons"
	display_name = "Special Weapons And Tactics"
	description = "Sometimes, standard protocol isn't enough."
	prereq_ids = list("ballistic_weapons", "NVGtech")
	design_ids = list("wt550", "tackle_combat", "blackbaton", "nv_helmet", "adv_armor_vest")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 8000)
	hidden = TRUE
	experimental = TRUE
