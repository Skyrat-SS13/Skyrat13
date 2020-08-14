/datum/techweb_node/ai/New()
	design_ids += "father_module"
	design_ids += "ranger_module"
	design_ids += "mallcop_module"
	design_ids += "godcomplex_module"
	. = ..()

/datum/techweb_node/powerarmor
	id = "powerarmor"
	display_name = "Full Body Exoskeleton"
	description = "Utilizing fluctuations in bluespace crystals, we can draw small amounts of energy to create self-powered body enhancing suits."
	prereq_ids = list("adv_biotech", "adv_bluespace", "adv_robotics")
	design_ids = list("powerarmor_skeleton","powerarmor_torso","powerarmor_helmet","powerarmor_armR","powerarmor_armL","powerarmor_legR","powerarmor_legL")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/ipc_construction
	id = "ipc_construction"
	display_name = "Sapient Synthetic Fabrication"
	description = "With enhanced artificial intelligence and mechatronic technology, we are able to build sapient synthetics from scratch."
	prereq_ids = list("ai", "posibrain", "adv_robotics", "mmi", "cyborg")
	design_ids = list("ipc_chassis", "synthliz_chassis", "synth_chassis", "ipc_heart", "ipc_lungs", "ipc_tongue", "ipc_stomach", "ipc_liver", "ipc_eyes", "ipc_ears", "cyborg_penis", "cyborg_testicles", "cyborg_breasts", "cyborg_vagina", "cyborg_womb")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 8000)

/datum/techweb_node/adv_robotics/New()
	design_ids += "borg_upgrade_premiumka"
	. = ..()

/datum/techweb_node/cyborg_upg_util/New()
	design_ids += "borg_upgrade_xwelding"
	design_ids += "borg_upgrade_shrink"
	//design_ids += "borg_upgrade_plasma"
	. = ..()
