/obj/item/radio/talk_into(mob/living/M, message, channel, list/spans,datum/language/language, direct=TRUE)
	if (!direct || !ismob(M) || M.mobility_flags & MOBILITY_USE) // if can't use items, you can't press the button
		return ..()

//Makes it so syndicate borgs dont transmit their radio so well. Due to how comms work there isn't really a better way unless you were to touch comms
/obj/item/radio/borg/syndicate
	canhear_range = 0

/obj/item/radio/headset
	slot_flags = ITEM_SLOT_EARS
