//Base bodyparts, all of them
/obj/item/bodypart/chest
	name = "chest"
	desc = "It's impolite to stare at a person's chest."
	icon_state = "default_human_chest"
	max_damage = 200
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 200
	amputation_point = "spine"
	children_zones = list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
	dismember_bodyzone = null
	specific_locations = list("upper chest", "lower abdomen", "midsection", "collarbone", "lower back")
	max_cavity_size = WEIGHT_CLASS_BULKY

/obj/item/bodypart/chest/can_dismember(obj/item/I)
	if(!((owner.stat == DEAD) || owner.InFullCritical()))
		return FALSE
	return ..()

/obj/item/bodypart/groin
	name = "groin"
	desc = "Some say groin came from  Grynde, which is middle-ages speak for depression. Makes sense for the situation."
	icon_state = "default_human_groin"
	max_damage = 100
	body_zone = BODY_ZONE_PRECISE_GROIN
	body_part = GROIN
	px_x = 0
	px_y = -3
	stam_damage_coeff = 1
	max_stamina_damage = 100
	amputation_point = "lumbar"
	parent_bodyzone = BODY_ZONE_CHEST
	dismember_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	specific_locations = list("left buttock", "right buttock", "inner left thigh", "inner right thigh", "perineum")
	max_cavity_size = WEIGHT_CLASS_NORMAL

/obj/item/bodypart/l_arm
	name = "left arm"
	desc = "Did you know that the word 'sinister' stems originally from the \
		Latin 'sinestra' (left hand), because the left hand was supposed to \
		be possessed by the devil? This arm appears to be possessed by no \
		one though."
	icon_state = "default_human_l_arm"
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_L_ARM
	body_part = ARM_LEFT
	body_damage_coeff = 0.75
	px_x = -6
	px_y = 0
	stam_heal_tick = 4
	amputation_point = "left shoulder"
	dismember_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_PRECISE_L_HAND)
	specific_locations = list("outer left forearm", "inner left wrist", "outer left wrist", "left elbow", "left bicep", "left shoulder")
	max_cavity_size = WEIGHT_CLASS_SMALL

/obj/item/bodypart/l_hand
	name = "left hand"
	desc = "In old english, left meant weak, guess they were onto something if you're finding this."
	icon_state = "default_human_l_hand"
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_PRECISE_L_HAND
	body_part = HAND_LEFT
	held_index = 1
	px_x = -6
	px_y = -3
	stam_heal_tick = 3
	parent_bodyzone = BODY_ZONE_L_ARM
	dismember_bodyzone = BODY_ZONE_L_ARM
	amputation_point = "left arm"
	children_zones = list()
	specific_locations = list("left palm", "left back palm")
	max_cavity_size = WEIGHT_CLASS_TINY

/obj/item/bodypart/r_arm
	name = "right arm"
	desc = "Over 87% of humans are right handed. That figure is much lower \
		among humans missing their right arm."
	icon_state = "default_human_r_hand"
	attack_verb = list("slapped", "punched")
	max_damage = 50
	body_zone = BODY_ZONE_R_ARM
	body_part = ARM_RIGHT
	body_damage_coeff = 0.75
	px_x = 6
	px_y = 0
	stam_heal_tick = STAM_RECOVERY_LIMB
	max_stamina_damage = 50
	amputation_point = "right shoulder"
	dismember_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_PRECISE_R_HAND)
	specific_locations = list("outer right forearm", "inner right wrist", "outer right wrist", "right elbow", "right bicep", "right shoulder")
	max_cavity_size = WEIGHT_CLASS_SMALL

/obj/item/bodypart/r_hand
	name = "right hand"
	desc = "It probably wasn't the right hand."
	icon_state = "default_human_r_hand"
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_PRECISE_R_HAND
	body_part = HAND_RIGHT
	held_index = 2
	px_x = 6
	px_y = -3
	stam_heal_tick = 4
	parent_bodyzone = BODY_ZONE_R_ARM
	dismember_bodyzone = BODY_ZONE_R_ARM
	amputation_point = "right arm"
	children_zones = list()
	specific_locations = list("right palm", "right back palm")
	max_cavity_size = WEIGHT_CLASS_TINY

/obj/item/bodypart/l_leg
	name = "left leg"
	desc = "Some athletes prefer to tie their left shoelaces first for good \
		luck. In this instance, it probably would not have helped."
	icon_state = "default_human_l_leg"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_L_LEG
	body_part = LEG_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	stam_heal_tick = STAM_RECOVERY_LIMB
	max_stamina_damage = 50
	dismember_bodyzone = BODY_ZONE_PRECISE_GROIN
	amputation_point = "groin"
	children_zones = list(BODY_ZONE_PRECISE_L_FOOT)
	specific_locations = list("inner left thigh", "outer left calf", "outer left hip", " left kneecap", "lower left shin")
	max_cavity_size = WEIGHT_CLASS_SMALL

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
	specific_locations = list("left sole", "left ankle", "left heel")
	max_cavity_size = WEIGHT_CLASS_TINY

//This is literally never ever used. Thank you, Pooj.
/obj/item/bodypart/l_leg/digitigrade
	name = "digitigrade left leg"
	use_digitigrade = FULL_DIGITIGRADE

/obj/item/bodypart/l_foot/digitigrade
	name = "digitigrade left foot"
	use_digitigrade = FULL_DIGITIGRADE

//back to the normal stuff
/obj/item/bodypart/r_leg
	name = "right leg"
	desc = "You put your right leg in, your right leg out. In, out, in, out, \
		shake it all about. And apparently then it detaches.\n\
		The hokey pokey has certainly changed a lot since space colonisation."
	icon_state = "default_human_r_leg"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	stam_heal_tick = 4
	amputation_point = "groin"
	dismember_bodyzone = BODY_ZONE_PRECISE_GROIN
	children_zones = list(BODY_ZONE_PRECISE_R_FOOT)
	specific_locations = list("right sole", "right ankle", "right heel")
	max_cavity_size = WEIGHT_CLASS_SMALL

/obj/item/bodypart/r_foot
	name = "right foot"
	desc = "You feel like someones gonna be needing a peg-leg."
	icon_state = "default_human_r_foot"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_PRECISE_R_FOOT
	body_part = FOOT_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 9
	stam_heal_tick = 4
	max_stamina_damage = 50
	children_zones = list()
	amputation_point = "right leg"
	parent_bodyzone = BODY_ZONE_R_LEG
	dismember_bodyzone = BODY_ZONE_R_LEG
	specific_locations = list("right sole", "right ankle", "right heel")
	max_cavity_size = WEIGHT_CLASS_TINY

//well fuck there you go back at it again with the poojcode
/obj/item/bodypart/r_leg/digitigrade
	name = "right digitigrade leg"
	use_digitigrade = FULL_DIGITIGRADE

/obj/item/bodypart/r_foot/digitigrade
	name = "right digitigrade foot"
	use_digitigrade = FULL_DIGITIGRADE
