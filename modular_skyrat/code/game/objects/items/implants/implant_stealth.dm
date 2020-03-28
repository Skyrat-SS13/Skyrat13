/obj/structure/closet/cardboard/agent/Move() //moving won't make you less invisible
	. = ..()

/obj/structure/closet/cardboard/agent/reveal()
	alpha = 255
	addtimer(CALLBACK(src, .proc/go_invisible), 10, TIMER_OVERRIDE|TIMER_UNIQUE)
	for(var/mob/living/carbon/human/H in src.loc)
		if(H.w_uniform)
			var/obj/item/clothing/under/U = H.w_uniform
			if(U == /obj/item/clothing/under/syndicate/stealthsuit)
				H.alpha = 255
				U.ui_action_click(H, /datum/action/item_action/activatestealth)
