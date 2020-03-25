/obj/item/gun/ballistic/revolver/russian/emag_act(mob/user)
	to_chat(user, "<span class='notice'>You short-circuit the [src]'s safety mechanisms! Funny that a crappy russian-made firearm has that...</span>")
	var/obj/item/gun/ballistic/revolver/R = new /obj/item/gun/ballistic/revolver(src.loc)
	R.name = name
	R.desc = desc + "On closer inspection, this one has no safety mechanisms."
	R.icon = icon
	R.icon_state = icon_state
	for(var/i in 1 to R.magazine.stored_ammo.len)
		qdel(R.magazine.stored_ammo[i])
	qdel(src)
