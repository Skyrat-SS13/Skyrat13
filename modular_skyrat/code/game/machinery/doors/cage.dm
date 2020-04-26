/obj/machinery/door/cage
	name = "door"
	desc = "This door only opens when a key is used."
	icon = 'modular_skyrat/icons/obj/structures.dmi'
	icon_state = "cagedoor_closed"
	max_integrity = 200
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 5, "bio" = 5, "rad" = 5, "fire" = 5, "acid" = 5)
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	var/keyin = null

/obj/machinery/door/cage/Bumped(atom/movable/AM)
	return

/obj/machinery/door/cage/attack_hand(mob/user)
	return

/obj/machinery/door/cage/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/cagekey))
		var/obj/item/cagekey/K = I
		if(!keyin)
			keyin = K.keyout
			to_chat(user, "You set the door to the key.")
		else if(keyin)
			if(keyin == K.keyout)
				if(density)
					if(!do_after(user, 30, target = src))
						return
					open()
					return
				else if(!density)
					if(!do_after(user, 30, target = src))
						return
					close()
					return
				else
					return
			else if(keyin != K.keyout)
				to_chat(user, "Wrong key!")
				return
		else
			return
	else if(istype(I, /obj/item/hammerhook))
		var/obj/item/hammerhook/HH = I
		if(density)
			if(!do_after(user, 600, target = src))
				qdel(HH)
				to_chat(user, "The Hammer and Hook breaks apart!")
			open()
		else
			return
	else if(!(I.item_flags & NOBLUDGEON) && user.a_intent != INTENT_HARM)
		try_to_activate_door(user)
		return 1
	return ..()

/obj/machinery/door/cage/update_icon_state()
	if(density)
		icon_state = "cagedoor_closed"
	else
		icon_state = "cagedoor_open"

/obj/machinery/door/cage/do_animate(animation)
	switch(animation)
		if("opening")
			flick("cagedoor_opening", src)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, 1)
		if("closing")
			flick("cagedoor_closing", src)
			playsound(src, 'sound/machines/blastdoor.ogg', 30, 1)