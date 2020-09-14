/obj/item/organ/cyberimp/arm/janitor
	name = "janitorial tools implant"
	desc = "A set of janitorial tools on the user's arm."
	contents = newlist(/obj/item/lightreplacer, /obj/item/holosign_creator, /obj/item/soap/nanotrasen, /obj/item/reagent_containers/spray/cyborg_drying, /obj/item/mop/advanced, /obj/item/paint/paint_remover, /obj/item/reagent_containers/glass/beaker/large, /obj/item/reagent_containers/spray/cleaner) //Beaker if for refilling sprays

/obj/item/organ/cyberimp/arm/janitor/emag_act()
	. = ..()
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(usr, "<span class='notice'>You unlock [src]'s integrated deluxe cleaning supplies!</span>")
	items_list += new /obj/item/soap/syndie(src) //We add not replace.
	items_list += new /obj/item/reagent_containers/spray/cyborg_lube(src)
	return TRUE
