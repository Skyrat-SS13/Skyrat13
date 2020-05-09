/obj/structure/falsewall/attack_hand(mob/user)
	to_chat(user, "<span class='notice'>You push at the wall...</span>") 
	if(density)
		if (do_after(user, 4 SECONDS, target = src))
			if(opening)
				return
			. = ..()
			if(.)
				return

			opening = TRUE
			update_icon()
			if(!density)
				var/srcturf = get_turf(src)
				for(var/mob/living/obstacle in srcturf) //Stop people from using this as a shield
					opening = FALSE
					return
			addtimer(CALLBACK(src, /obj/structure/falsewall/proc/toggle_open), 5)
	else
		addtimer(CALLBACK(src, /obj/structure/falsewall/proc/toggle_open), 5)
