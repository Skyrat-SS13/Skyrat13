/obj/item/clothing/under/syndicate/stealthsuit
	name = "MK.1 Tactical Stealth Suit"
	desc = "A suspicious looking, tight-fitting suit that can make you invisible under the right conditions. Has a MI13 insignia blazoned upon it's back."
	icon = 'modular_skyrat/icons/obj/clothing/stealthsuit.dmi'
	alternate_worn_icon = 'modular_skyrat/icons/mob/stealth.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/stealth_digi.dmi'
	icon_state = "stealth"
	item_state = "stealth"
	item_color = null
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = -10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 90)
	alt_covers_chest = TRUE
	can_adjust = FALSE
	var/effectapplied = /datum/status_effect/stealthsuit
	var/activated = FALSE
	actions_types = list(/datum/action/item_action/activatestealth)

/datum/action/item_action/activatestealth
	name = "Activate"
	desc = "Activate/deactivate your suit's stealth mode."

/obj/item/clothing/under/syndicate/stealthsuit/equipped(mob/living/M, slot)
	. = ..()
	if(slot == SLOT_W_UNIFORM)
		if(activated)
			M.apply_status_effect(effectapplied)
			M.alpha -= 75
		for(var/datum/action/item_action/A in src)
			A.Grant(M, src)

/obj/item/clothing/under/syndicate/stealthsuit/dropped(mob/living/M, slot)
	. = ..()
	M.remove_status_effect(effectapplied)
	M.alpha = 255
	activated = 0
	for(var/datum/action/item_action/A in src)
		A.Remove(M, src)

/obj/item/clothing/under/syndicate/stealthsuit/ui_action_click(mob/living/user, action)
	if(istype(action, /datum/action/item_action/activatestealth))
		if(!activated)
			to_chat(user, "<span class='warning'>Stealth module activated.</span>")
			activated = !activated
			user.apply_status_effect(effectapplied)
			user.alpha -= 75
		else if(activated)
			to_chat(user, "<span class='warning'>Stealth module deactivated.</span>")
			activated = !activated
			user.remove_status_effect(effectapplied)
			user.alpha = 255