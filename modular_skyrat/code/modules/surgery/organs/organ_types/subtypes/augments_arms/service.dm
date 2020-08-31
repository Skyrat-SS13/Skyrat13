
/obj/item/organ/cyberimp/arm/service
	name = "service toolset implant"
	desc = "A set of miscellaneous gadgets hidden behind a concealed panel on the user's arm."
	contents = newlist(/obj/item/extinguisher/mini, /obj/item/kitchen/knife/combat/bone/plastic, /obj/item/hand_labeler, /obj/item/pen, /obj/item/reagent_containers/dropper, /obj/item/kitchen/rollingpin, /obj/item/reagent_containers/glass/beaker/large, /obj/item/reagent_containers/syringe,/obj/item/reagent_containers/food/drinks/shaker, /obj/item/radio/off, /obj/item/camera, /obj/item/modular_computer/tablet/preset/cargo)

/obj/item/organ/cyberimp/arm/service/emag_act()
	. = ..()
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(usr, "<span class='notice'>You unlock [src]'s integrated real knife!</span>")
	items_list += new /obj/item/kitchen/knife/combat/cyborg(src)
	return TRUE
