/obj/item/clothing/gloves/ring/silver/fargoth
	name = "Fargoth's Engraved Ring of Healing"
	desc = "A tiny enchanted silver ring, from an annoying little elf."
	actions_types = list(/datum/action/item_action/fargoth)
	var/ringcooldown = 600
	var/cooldowntime = 0

/datum/action/item_action/fargoth
	name = "Magic Healing"
	desc = "Heals some brute damage... not much."

/obj/item/clothing/gloves/ring/silver/fargoth/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/fargoth))
		var/mob/living/carbon/human/H = user
		if(world.time > cooldowntime && H)
			playsound(user, 'sound/magic/Staff_Healing.ogg', 25)
			H.visible_message("[user] heals himself with [src]!", "<span class='notice'>You heal yourself with the [src].</span>")
			H.adjustBruteLoss(-5)
			cooldowntime = world.time + ringcooldown
		else
			to_chat(user, "<span class='notice'>The [src] just fizzles uselessly.</span>")

/obj/item/clothing/gloves/thief/khajiiti
	name = "gold ring"
	desc = "From a distance, this seems like a normal golden ring. Upon further inspection, you can see it's actually inscribed with... cats? You can also see the name \"Rajhin\" inscribed on it."
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	strip_delay = 80
	transfer_prints = FALSE
	strip_mod = 7.5
	strip_silence = TRUE
	attack_verb = list("proposed")
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	siemens_coefficient = 0