/obj/item/radio/talk_into(mob/living/M, message, channel, list/spans,datum/language/language, direct=TRUE)
	if (!direct || !ismob(M) || M.mobility_flags & MOBILITY_USE) // if can't use items, you can't press the button
		return ..()
