/datum/sprite_accessory/mam_body_markings/floof
	name = "BellyFloof"
	icon_state = "floof"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/mam_body_markings/floofer
	name = "BellyFloofTertiary"
	icon_state = "floofer"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/mam_body_markings/handsfeet_rat
	name = "Rat"
	icon_state = "rat"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/mam_body_markings/handsfeet_sloth
	name = "Sloth"
	icon_state = "sloth"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/body_markings/colorbelly
	name = "Coloured Belly"
	color_src = MATRIXED
	icon_state = "colorbelly"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

//VORE markings
/datum/sprite_accessory/adv_marking
	icon = 'modular_skyrat/icons/mob/adv_markings/markings.dmi'
	//Empty list is unrestricted. Should only restrict markings that make NO SENSE on non-specified species.
	var/list/species_allowed = list()
	//Body zones that this accessory can go on.
	var/list/body_parts = list()
	//Is this marking able to be recolored?
	var/has_colors = TRUE

/datum/sprite_accessory/adv_marking/tat_heart
	name = "Tattoo (Heart, Torso)"
	icon_state = "tat_heart"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/tat_hive
	name = "Tattoo (Hive, Back)"
	icon_state = "tat_hive"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/tat_nightling
	name = "Tattoo (Nightling, Back)"
	icon_state = "tat_nightling"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/tat_campbell
	name = "Tattoo (Campbell)"
	icon_state = "tat_campbell"
	body_parts = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)

/datum/sprite_accessory/adv_marking/tat_silverburgh
	name = "Tattoo (Silverburgh)"
	icon_state = "tat_silverburgh"
	body_parts = list (BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)

/datum/sprite_accessory/adv_marking/patchesface
	name = "Color Patches (Face)"
	icon_state = "patchesface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/bandsface
	name = "Color Bands (Face)"
	icon_state = "bandsface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/tigerhead
	name = "Tiger Stripes (Minor)"
	icon_state = "tigerhead"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/tigerface
	name = "Tiger Stripes (Major)"
	icon_state = "tigerface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/backstripe
	name = "Back Stripe"
	icon_state = "backstripe"
	body_parts = list(BODY_ZONE_CHEST)

/* not working well sadly
/datum/sprite_accessory/adv_marking/heterochromia
	name = "Heterochromia (Right Eye)"
	icon_state = "heterochromia"
	body_parts = list(BODY_ZONE_HEAD)
*/
