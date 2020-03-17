/datum/techweb_node/cyborg_upg_util/New()
	design_ids += "borg_upgrade_xwelding"
	//design_ids += "borg_upgrade_plasma"
	. = ..()

/datum/techweb_node/bluespace_portal/New()
	design_ids += "bsrpd"
	design_ids += "borg_upgrade_bsrpd"
	. = ..()

/datum/techweb_node/bs_mining
	id = "bluespace_mining"
	display_name = "Bluespace Mining Technology"
	description = "Harness the power of bluespace to make materials out of nothing. Slowly."
	prereq_ids = list("practical_bluespace", "adv_mining")
	design_ids = list("bluespace_miner")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)