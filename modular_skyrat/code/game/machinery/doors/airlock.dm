/obj/machinery/door/airlock/bumpopen(mob/living/user)
	if(ishuman(user) && prob(35) && src.density)
		var/mob/living/carbon/human/H = user
		if(HAS_TRAIT(H, TRAIT_DUMB))
			H.visible_message("<span class='danger'>[user] looks at the airlock with a confused expression.</span>", \
								"<span class='danger'>You can't remember how to open the airlock!</span>")
			H.Stun(10)
			return
	. = ..()
