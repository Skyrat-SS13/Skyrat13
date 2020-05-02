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
	design_ids += "bot_chem_dis"
	. = ..()

/datum/techweb_node/integrated_HUDs/New()
	design_ids += "mining_hud"
	design_ids += "mining_hud_prescription"
	design_ids += "mining_hud_meson"
	design_ids += "mining_hud_fauna"
	. = ..()

/datum/techweb_node/illegal_mechs
	id = "illegal_mechs"
	display_name = "Illegal Combat Mechs"
	description = "Combat mechs that use syndicate, or otherwise illegal, technology."
	design_ids = list("killdozer_chassis", "killdozer_clamp", "killdozer_drill", "killdozer_pistol", "killdozer_pistol_ammo")
	prereq_ids = list("advanced_illegal_ballistics", "adv_mecha", "adv_mecha_tools", "mech_carbine")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 12500)

/datum/techweb_node/syndicate_basic/New()
	design_ids += "armblade"
	. = ..()

/datum/techweb_node/clarke
	id = "mecha_clarke"
	display_name = "EXOSUIT: Clarke"
	description = "Clarke is a fast, fire and lava proof, however not very tough, exo-suit."
	prereq_ids = list("adv_mecha")
	design_ids = list("clarke_chassis", "clarke_torso", "clarke_head", "clarke_left_arm", "clarke_right_arm", "clarke_main", "clarke_peri", "conveyor_belt_mechfab")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 6500)

/datum/techweb_node/buzz
	id = "mecha_buzz"
	display_name = "EXOSUIT: Buzz"
	description = "Buzz is a titanium armored civillian exo-suit made for space travel and exploration."
	prereq_ids = list("adv_mecha")
	design_ids = list("buzz_chassis", "buzz_harness", "buzz_cockpit", "buzz_left_arm", "buzz_right_arm", "buzz_left_leg", "buzz_right_leg", "buzz_main", "buzz_peri", "exogps")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
