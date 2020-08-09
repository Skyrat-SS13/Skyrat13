/obj/item/bodypart/l_foot
	name = "left foot"
	desc = "You feel like someones gonna be needing a peg-leg."
	icon_state = "default_human_r_foot"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_PRECISE_L_FOOT
	dismember_bodyzone = BODY_ZONE_L_LEG
	body_part = FOOT_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 9
	stam_heal_tick = 4
	max_stamina_damage = 50
	children_zones = list()
	amputation_point = "right leg"
	parent_bodyzone = BODY_ZONE_L_LEG
	heal_zones = list(BODY_ZONE_L_LEG)
	specific_locations = list("left sole", "left ankle", "left heel")
	max_cavity_size = WEIGHT_CLASS_TINY

//Thanks Pooj for this useless bodypart.
/obj/item/bodypart/l_foot/digitigrade
	name = "digitigrade left foot"
	use_digitigrade = FULL_DIGITIGRADE
