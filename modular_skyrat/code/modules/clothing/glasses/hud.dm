//base hud changes to accomodate fauna mining hud
/obj/item/clothing/glasses
	var/datum/atom_hud/ourhud
	var/storehud = FALSE

/obj/item/clothing/glasses/hud/equipped(mob/living/carbon/human/user, slot)
	..()
	if(hud_type && slot == SLOT_GLASSES)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.add_hud_to(user)
		if(storehud)
			ourhud = H

/obj/item/clothing/glasses/hud/dropped(mob/living/carbon/human/user)
	..()
	if(hud_type && istype(user) && user.glasses == src)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user)
	if(storehud)
		ourhud = null

//prescription huds
/obj/item/clothing/glasses/hud/health/prescription
	icon = 'modular_skyrat/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_healthhud"
	item_state = "glasses_healthhud"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/diagnostic/prescription
	icon = 'modular_skyrat/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_diagnostichud"
	item_state = "glasses_diagnostichud"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/prescription
	icon = 'modular_skyrat/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_securityhud"
	item_state = "glasses_securityhud"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/eyes.dmi'
