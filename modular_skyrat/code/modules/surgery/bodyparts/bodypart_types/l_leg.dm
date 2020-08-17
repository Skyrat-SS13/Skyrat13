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
	parent_bodyzone = BODY_ZONE_PRECISE_GROIN
	amputation_point = "groin"
	children_zones = list(BODY_ZONE_PRECISE_L_FOOT)
	heal_zones = list(BODY_ZONE_PRECISE_L_FOOT)
	specific_locations = list("inner left thigh", "outer left calf", "outer left hip", "left kneecap", "lower left shin")
	max_cavity_size = WEIGHT_CLASS_SMALL
	dismember_mod = 0.8
	disembowel_mod = 0.8

/obj/item/bodypart/l_leg/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_LEG))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/l_leg/set_disabled(new_disabled)
	. = ..()
	if(!. || owner.stat >= UNCONSCIOUS)
		return
	switch(disabled)
		if(BODYPART_DISABLED_DAMAGE)
			owner.emote("scream")
			to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		if(BODYPART_DISABLED_PARALYSIS)
			to_chat(owner, "<span class='userdanger'>You can't feel your [name]!</span>")

//This is literally never ever used. Thank you, Pooj.
/obj/item/bodypart/l_leg/digitigrade
	name = "digitigrade left leg"
	use_digitigrade = FULL_DIGITIGRADE
