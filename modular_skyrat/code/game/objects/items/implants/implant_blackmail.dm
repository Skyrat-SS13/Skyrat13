/obj/item/implant/blackmail
	name = "blackmail implant"
	desc = "Blackmail with this."
	activated = FALSE

/obj/item/implant/blackmail/Initialize()
	. = ..()
	create_reagents(50, NO_REACT) // so it doesn't react until it's injected
	if(prob(65)) //65% for poison, smaller chance for explosive mix so doctors cant meta
		reagents.add_reagent_list(list(/datum/reagent/toxin/amatoxin = 15, /datum/reagent/toxin/formaldehyde = 15, /datum/reagent/toxin/cyanide = 10, /datum/reagent/toxin/anacea = 10))
	else
		reagents.add_reagent_list(list(/datum/reagent/water = 25, /datum/reagent/potassium = 25))

/obj/item/implant/blackmail/activate(cause)
	. = ..()
	if(!cause || !imp_in)
		return 0
	var/mob/living/carbon/R = imp_in
	reagents.trans_to(R, reagents.total_volume)
	to_chat(R, "<span class='italics'>You hear a faint beep.</span>")

/obj/item/implant/blackmail/removed(mob/living/source, silent = FALSE, special = 0)
	activate("removal")
	. = ..()

/obj/item/implanter/blackmail
	name = "implanter (blackmail)"
	desc = "A sterile automatic implant injector. There's a small label mentioning to not tamper with the implant once injected."
	imp_type = /obj/item/implant/blackmail

/obj/item/implanter/blackmail/attack(mob/living/M, mob/user) //Overrides the proc to make the injection longer
	if(!istype(M))
		return
	if(user && imp)
		if(M != user)
			M.visible_message("<span class='warning'>[user] is attempting to implant [M].</span>")

		var/turf/T = get_turf(M)
		if(T && (M == user || do_mob(user, M, 110)))
			if(src && imp)
				if(imp.implant(M, user))
					if (M == user)
						to_chat(user, "<span class='notice'>You implant yourself.</span>")
					else
						M.visible_message("[user] has implanted [M].", "<span class='notice'>[user] implants you.</span>")
					imp = null
					update_icon()
				else
					to_chat(user, "<span class='warning'>[src] fails to implant [M].</span>")