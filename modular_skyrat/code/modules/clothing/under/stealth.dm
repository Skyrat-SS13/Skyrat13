/obj/item/clothing/under/syndicate/stealthsuit
	name = "MK.1 Tactical Stealth Suit"
	desc = "A suspicious looking, tight-fitting suit that can make you invisible under the right conditions. Has a MI13 insignia blazoned upon it's back."
	icon = 'modular_skyrat/icons/obj/clothing/stealthsuit.dmi'
	icon_state = "stealth"
	item_state = "stealth"
	item_color = null
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = -10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 90)
	alt_covers_chest = TRUE
	can_adjust = FALSE
	var/effectapplied = /datum/status_effect/stealthsuit

/obj/item/clothing/under/syndicate/stealthsuit/equipped(mob/living/M, slot)
	. = ..()
	M.apply_status_effect(effectapplied)
	M.alpha -= 100

/obj/item/clothing/under/syndicate/stealthsuit/dropped(mob/living/M, slot)
	. = ..()
	M.remove_status_effect(effectapplied)
	M.alpha = 255