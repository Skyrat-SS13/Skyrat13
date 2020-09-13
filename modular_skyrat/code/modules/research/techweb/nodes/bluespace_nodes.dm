/datum/techweb_node/bs_mining
	id = "bluespace_mining"
	display_name = "Bluespace Mining Technology"
	description = "Harness the power of bluespace to make materials out of nothing. Slowly."
	prereq_ids = list("practical_bluespace", "adv_mining")
	design_ids = list("bluespace_miner")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/adv_bluetravel
	id = "advanced_bluetravel"
	display_name = "Advanced Bluespace Travel"
	description = "Using superior knowledge of bluespace, you can develop more finely-controlled teleportation equipment."
	prereq_ids = list("bluespace_warping")
	design_ids = list("telepad", "telesci_console")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 9000)

/datum/techweb_node/bluespace_portal/New()
	design_ids += "bsrpd"
	design_ids += "borg_upgrade_bsrpd"
	. = ..()

/datum/techweb_node/cryptominer
	id = "cryptominer"
	display_name = "Cryptocurrency Mining"
	description = "Harness the power of cryptocurrency to make credits for Cargo-- slowly."
	prereq_ids = list("bluespace_mining")
	design_ids = list("cryptominer")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
/*
/datum/techweb_node/cryptominersyndie
	id = "cryptominersyndie"
	display_name = "Illegal Cryptocurrency Mining"
	description = "Harness the power of bluespace to make credits for Cargo-- slowly."
	prereq_ids = list("cryptominer","syndicate_basic")
	design_ids = list("cryptominersyndie")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
*/
