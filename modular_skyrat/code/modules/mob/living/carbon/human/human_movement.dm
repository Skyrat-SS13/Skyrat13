/mob/living/carbon/human/slip(knockdown_amount, obj/O, lube, paralyze, forcedrop)
	if(HAS_TRAIT(src, TRAIT_NOSLIPALL))
		return 0
	if (!(lube & GALOSHES_DONT_HELP))
		if(HAS_TRAIT(src, TRAIT_NOSLIPWATER))
			return 0
		if(shoes && istype(shoes, /obj/item/clothing))
			var/obj/item/clothing/CS = shoes
			if (CS.clothing_flags & NOSLIP)
				return 0
	if (lube & SLIDE_ICE)
		if(shoes && istype(shoes, /obj/item/clothing))
			var/obj/item/clothing/CS = shoes
			if (CS.clothing_flags & NOSLIP_ICE)
				return 0
	return ..()