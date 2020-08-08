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
	heal_zones = list(BODY_ZONE_PRECISE_GROIN)
	dismember_bodyzone = null
	specific_locations = list("upper chest", "lower abdomen", "midsection", "collarbone", "lower back")
	max_cavity_size = WEIGHT_CLASS_BULKY
	dismember_mod = 0.3
	disembowel_mod = 0.6

/obj/item/bodypart/chest/can_dismember(obj/item/I)
	if(!((owner.stat == DEAD) || owner.InFullCritical()))
		return FALSE
	return ..()
