/obj/item/clothing/under/syndicate/stealthsuit
	name = "MK.III Tactical Stealth Suit"
	desc = "A suspicious looking, tight-fitting suit that can make you invisible under the right conditions. Has a MI13 insignia blazoned upon it's forearm."
	icon = 'modular_skyrat/icons/obj/clothing/uniform.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/uniform.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "stealth"
	item_state = "stealth"
	has_sensor = NO_SENSORS
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 90, "wound" = 10)
	alt_covers_chest = TRUE
	can_adjust = FALSE
	var/effectapplied = /datum/status_effect/stealthsuit
	var/activated = FALSE
	actions_types = list(/datum/action/item_action/activatestealth)
	mutantrace_variation = STYLE_DIGITIGRADE

/datum/action/item_action/activatestealth
	name = "Activate"
	desc = "Activate/deactivate your suit's stealth mode."

/obj/item/clothing/under/syndicate/stealthsuit/emp_act(severity)
	for(var/mob/living/carbon/human/C in src.loc)
		if(C == get_wearer())
			C.alpha = 255
			visible_message("<span class='warning'>\the [src] malfunctions, revealing you!</span>", "<span class='warning'>\the [src] malfunctions, revealing [C]!</span>")
	var/datum/effect_system/spark_spread/S = new /datum/effect_system/spark_spread()
	S.set_up(5, 0, src)
	S.attach(src)
	S.start()

/obj/item/clothing/under/syndicate/stealthsuit/equipped(mob/living/M, slot)
	. = ..()
	if(slot == SLOT_W_UNIFORM)
		if(activated)
			M.apply_status_effect(effectapplied)
			animate(M, , alpha -= 75, time = 3)
		for(var/datum/action/item_action/A in actions_types)
			A.Grant(M, src)

/obj/item/clothing/under/syndicate/stealthsuit/Bumped(atom/movable/AM)
	if(!activated)
		return
	else
		if(istype(AM, /mob/living))
			src.visible_message("<span class='warning'>[src] malfunctions and reveals it's owner!</span>", "<span class='warning'>[src] malfunctions and reveals it's owner!</span>")
			var/mob/living/carbon/human/C = get_wearer()
			if(C)
				C.alpha = 255
				to_chat(C, "<span class='warning'><b>[src]:</b> Stealth module malfunction!%#&%%#&@ERROR$%!@&$&#</span>")
				to_chat(C, "<span class='warning'><b>[src]:</b> Resetting suit...</span>")
				src.ui_action_click(C, /datum/action/item_action/activatestealth)
				var/datum/effect_system/spark_spread/S = new /datum/effect_system/spark_spread()
				S.set_up(5, 0, src)
				S.attach(src)
				S.start()

/obj/item/clothing/under/syndicate/stealthsuit/proc/get_wearer()
	for(var/mob/living/carbon/human/C in loc)
		if(C.w_uniform)
			var/obj/item/clothing/under/U = C.w_uniform
			if(U == src)
				var/mob/living/carbon/ourguy = C
				return ourguy
	return FALSE

/obj/item/clothing/under/syndicate/stealthsuit/dropped(mob/living/M, slot)
	. = ..()
	M.remove_status_effect(effectapplied)
	activated = FALSE
	for(var/datum/action/item_action/A in actions_types)
		A.Remove(M, src)

/obj/item/clothing/under/syndicate/stealthsuit/ui_action_click(mob/living/user, action)
	if(istype(action, /datum/action/item_action/activatestealth))
		if(!activated)
			to_chat(user, "<span class='warning'><b>[src]:</b> Stealth module activated. Stand still to achieve maximum camouflage.</span>")
			activated = !activated
			user.apply_status_effect(effectapplied)
			animate(user, , alpha -= 75, time = 3)
		else if(activated)
			to_chat(user, "<span class='warning'><b>[src]:</b> Stealth module deactivated. You are now visible to your surroundings.</span>")
			activated = !activated
			user.remove_status_effect(effectapplied)
