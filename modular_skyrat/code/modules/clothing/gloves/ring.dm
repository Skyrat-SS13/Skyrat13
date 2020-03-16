/obj/item/clothing/gloves/ring/silver/fargoth
	name = "ring of fargoth"
	desc = "A tiny enchanted silver ring, from an annoying little elf."
	actions_types = list(/datum/action/item_action/fargoth)
	var/cooldown = 1200
	var/cooldowntime = 0

/datum/action/item_action/fargoth
	name = "Magic Healing"
	desc = "Heals some brute damage... not much."

/obj/item/clothing/gloves/ring/silver/fargoth/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/fargoth))
		if(world.time > cooldowntime)
			playsound(user, 'sound/effects/magic/Staff_Healing.ogg', 25)
			user.visible_message("[user] heals himself with [src]!", "<span class='notice'>You heal yourself with the [src].</span>")
			user.adjustBruteLoss(-5)
			cooldowntime = world.time + cooldown
		else
			to_chat(user, "<span class='notice'>The [src] just fizzles uselessly.</span>")