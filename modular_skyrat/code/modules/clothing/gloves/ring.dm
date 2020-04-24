/obj/item/clothing/gloves/ring/silver/fargoth
	name = "engraved silver ring"
	desc = "It seems to have something engraved on it, though you can't read it. You feel like this belonged to someone important, at some point."
	actions_types = list(/datum/action/item_action/fargoth)
	var/ringcooldown = 600
	var/cooldowntime = 0

/datum/action/item_action/fargoth
	name = "Use Ring"
	desc = "You feel like this ring could help you in a dire situation, though probably it's just your imagination."

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