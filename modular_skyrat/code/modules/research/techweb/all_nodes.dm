/datum/techweb_node/cyborg_upg_util/New()
	design_ids += "borg_upgrade_xwelding"
	design_ids += "borg_upgrade_shrink"
	//design_ids += "borg_upgrade_plasma"
	. = ..()

/datum/techweb_node/bluespace_portal/New()
	design_ids += "bsrpd"
	design_ids += "borg_upgrade_bsrpd"
	. = ..()

/datum/techweb_node/adv_robotics/New()
	design_ids += "borg_upgrade_premiumka"
	. = ..()

/datum/techweb_node/bs_mining
	id = "bluespace_mining"
	display_name = "Bluespace Mining Technology"
	description = "Harness the power of bluespace to make materials out of nothing. Slowly."
	prereq_ids = list("practical_bluespace", "adv_mining")
	design_ids = list("bluespace_miner")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/cryptominer
	id = "cryptominer"
	display_name = "Cryptocurrency Mining"
	description = "Harness the power of cryptocurrency to make credits for Cargo-- slowly."
	prereq_ids = list("bluespace_mining")
	design_ids = list("cryptominer")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/cryptominersyndie
	id = "cryptominersyndie"
	display_name = "Illegal Cryptocurrency Mining"
	description = "Harness the power of bluespace to make credits for Cargo-- slowly."
	prereq_ids = list("cryptominer","syndicate_basic")
	design_ids = list("cryptominersyndie")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/radioactive_weapons/New()
	design_ids += "holorifle"
	design_ids += "microfusion_cell"
	design_ids += "microfusion_cell_box"
	. = ..()

/datum/techweb_node/adv_bluetravel
	id = "advanced_bluetravel"
	display_name = "Advanced Bluespace Travel"
	description = "Using superior knowledge of bluespace, you can develop more finely-controlled teleportation equipment."
	prereq_ids = list("bluespace_warping")
	design_ids = list("telepad", "telesci_console")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 9000)

/datum/techweb_node/powerarmor
	id = "powerarmor"
	display_name = "Full Body Exoskeleton"
	description = "Utilizing fluctuations in bluespace crystals, we can draw small amounts of energy to create self-powered body enhancing suits."
	prereq_ids = list("adv_biotech", "adv_bluespace", "adv_robotics")
	design_ids = list("powerarmor_skeleton","powerarmor_torso","powerarmor_helmet","powerarmor_armR","powerarmor_armL","powerarmor_legR","powerarmor_legL")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/ai/New()
	design_ids += "father_module"
	design_ids += "ranger_module"
	design_ids += "mallcop_module"
	design_ids += "godcomplex_module"
	. = ..()

/datum/techweb_node/botany/New()
	design_ids += "prisonerbiogenerator"
	. = ..()


/datum/techweb_node/syndicate_basic/New()
	design_ids += "armblade"
	. = ..()

/datum/techweb_node/illegal_mechs
	id = "illegal_mechs"
	display_name = "Illegal Combat Mechs"
	description = "Combat mechs that use syndicate, or otherwise illegal, technology."
	design_ids = list("killdozer_chassis", "killdozer_clamp", "killdozer_drill", "killdozer_pistol", "killdozer_pistol_ammo")
	prereq_ids = list("advanced_illegal_ballistics", "adv_mecha", "adv_mecha_tools", "mech_carbine")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 12500)

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

/datum/techweb_node/computer_board_gaming/New()
	design_ids += "tetris"
	. = ..()

/datum/techweb_node/wireless
	id = "wireless_charging"
	display_name = "Wireless charging"
	description = "Learn about the ability to send power through the air."
	prereq_ids = list("adv_power", "adv_engi")
	design_ids = list("wireless_guns", "wireless_cells")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
