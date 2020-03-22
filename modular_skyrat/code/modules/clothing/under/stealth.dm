/obj/item/clothing/under/syndicate/stealthsuit
	name = "stealth suit"
	desc = "A suspicious looking suit, that can make you invisible under the right conditions."
	icon = 'modular_skyrat/icons/obj/clothing/stealthsuit.dmi'
	icon_state = "stealth"
	item_state = "stealth"
	item_color = null
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	can_adjust = FALSE
	var/effectapplied = /datum/status_effect/stealthsuit

/obj/item/clothing/under/syndicate/stealthsuit/equipped(mob/M, slot)
	. = ..()
	M.apply_status_effect(effectapplied)
	M.alpha -= 100

/obj/item/clothing/under/syndicate/stealthsuit/dropped(mob/M, slot)
	. = ..()
	M.remove_status_effect(effectapplied)
	M.alpha = 255