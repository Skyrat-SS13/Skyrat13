/mob/living/carbon/human/get_blocking_items()
	. = ..()
	if(wear_suit)
		. |= wear_suit
	if(w_uniform)
		. |= w_uniform
	//skyrat edit
	if(w_underwear)
		. |= w_underwear
	if(w_socks)
		. |= w_socks
	if(w_shirt)
		. |= w_shirt
	//
	if(wear_neck)
		. |= wear_neck
