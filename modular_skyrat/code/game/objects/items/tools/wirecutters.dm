/obj/item/wirecutters/collarremover
	name = "Collar Remover"
	desc = "A specialized wirecutter that can remove stuck collars."
	random_color = FALSE
	force = 0
	var/list/canremove = list(/obj/item/electropack/shockcollar, /obj/item/electropack/shockcollar/security, /obj/item/electropack/shockcollar/pacify/security/shock)

/obj/item/wirecutters/collarremover/Initialize()
	. = ..()
	icon_state = "cutters"
	var/our_color = "#ff0000"
	add_atom_colour(wirecutter_colors[our_color], FIXED_COLOUR_PRIORITY)
	update_icon()

/obj/item/wirecutters/collarremover/attack(mob/living/carbon/C, mob/user)
	if(istype(C))
		if(C.wear_neck)
			if(canremove.Find(C.wear_neck))
				user.visible_message("<span class='notice'>[user] cuts [C]'s [C.wear_neck]!</span>")
				qdel(C.wear_neck)
				return
	return