//this is so synths and IPC's can only have their limbs repaired by cable if they're under X dmg
/obj/item/stack/cable_coil/attack(mob/living/carbon/human/H, mob/user)
	if(!istype(H))
		return ..()

	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(affecting && affecting.status == BODYPART_ROBOTIC && user.a_intent != INTENT_HARM && affecting.synthetic && affecting.burn_dam > 40)
		to_chat(user, "<span class='warning'>[H]'s [affecting.name] is too charred, it requires surgical precision to be fixed!</span>")
		return
	else
		return ..()