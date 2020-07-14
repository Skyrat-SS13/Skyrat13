/datum/techweb_node/illegal_mechs
	id = "illegal_mechs"
	display_name = "Illegal Combat Mechs"
	description = "Combat mechs that use syndicate, or otherwise illegal, technology."
	design_ids = list("killdozer_chassis", "killdozer_clamp", "killdozer_drill", "killdozer_pistol", "killdozer_pistol_ammo")
	prereq_ids = list("advanced_illegal_ballistics", "adv_mecha", "adv_mecha_tools", "mech_carbine")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 12500)

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
	design_ids = list("buzz_chassis", "buzz_harness", "buzz_cockpit", "buzz_left_arm", "buzz_right_arm", "buzz_left_leg", "buzz_right_leg", "buzz_main", "buzz_peri", "exogps", "buzz_clamp", "buzz_lance", "buzz_thrusters")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
