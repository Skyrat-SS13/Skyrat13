/obj/item/organ/cyberimp/eyes
	name = "eye cerbimplant"
	desc = "artificial photoreceptors with specialized functionality"
	icon_state = "eye_implant"
	implant_overlay = "eye_implant_overlay"
	slot = ORGAN_SLOT_EYES
	zone = BODY_ZONE_PRECISE_EYES
	w_class = WEIGHT_CLASS_TINY

// HUD implants
/obj/item/organ/cyberimp/eyes/hud
	name = "HUD implant"
	desc = "These cybernetic eyes will display a HUD over everything you see. Maybe."
	slot = ORGAN_SLOT_HUD
	var/HUD_type = 0

/obj/item/organ/cyberimp/eyes/hud/Insert(var/mob/living/carbon/M, var/special = 0, drop_if_replaced = FALSE)
	..()
	if(HUD_type)
		var/datum/atom_hud/H = GLOB.huds[HUD_type]
		H.add_hud_to(M)

/obj/item/organ/cyberimp/eyes/hud/Remove(special = FALSE)
	if(!QDELETED(owner) && HUD_type)
		var/datum/atom_hud/H = GLOB.huds[HUD_type]
		H.remove_hud_from(owner)
	return ..()
