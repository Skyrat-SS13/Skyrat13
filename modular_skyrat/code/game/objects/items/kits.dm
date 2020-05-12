//revolver conversion kit
/obj/item/conversion_kit
	name = "\improper Revolver Conversion Kit"
	desc = "A professional conversion kit used to convert any knock off revolver into the real deal capable of shooting lethal .357 rounds without the possibility of catastrophic failure. Comes packed with 7 rounds, too."
	icon = 'modular_skyrat/icons/obj/kit.dmi'
	icon_state = "kit"
	flags_1 =  CONDUCT_1
	w_class = WEIGHT_CLASS_SMALL
	var/open = 0

/obj/item/conversion_kit/Initialize()
	..()
	update_icon()

/obj/item/conversion_kit/update_icon()
	icon_state = "[initial(icon_state)]_[open]"

/obj/item/conversion_kit/attack_self(mob/user)
	open = !open
	to_chat(user, "<span class='notice'>You [open ? "open" : "close"] the conversion kit.</span>")
	update_icon()

/obj/item/conversion_kit/afterattack(atom/target, mob/user, proximity)
	if(istype(target, /obj/item/gun/ballistic/revolver/detective || /obj/item/gun/ballistic/revolver/russian) && open)
		var/obj/item/gun/ballistic/revolver/targetrev = target
		var/obj/item/gun/ballistic/revolver/newrev = new /obj/item/gun/ballistic/revolver(get_turf(user))
		newrev.name = targetrev.name
		newrev.desc = targetrev.desc + " This one seems a little odd."
		newrev.icon = targetrev.icon
		newrev.icon_state = targetrev.icon_state
		newrev.lefthand_file = targetrev.lefthand_file
		newrev.righthand_file = targetrev.righthand_file
		newrev.attack_verb = targetrev.attack_verb
		newrev.item_state = targetrev.item_state
		to_chat(user, "<span class='notice'>You succesfully convert the [targetrev] with \the [src].</span>")
		qdel(targetrev)
		qdel(src)
		return TRUE
	else if(istype(target, /obj/item/toy/gun) && open)
		var/obj/item/toy/gun/targetrev = target
		var/obj/item/gun/ballistic/revolver/newrev = new /obj/item/gun/ballistic/revolver(get_turf(user))
		newrev.name = targetrev.name
		newrev.desc = targetrev.desc + " This one seems a little odd."
		newrev.icon = targetrev.icon
		newrev.icon_state = targetrev.icon_state
		newrev.lefthand_file = targetrev.lefthand_file
		newrev.righthand_file = targetrev.righthand_file
		newrev.attack_verb = targetrev.attack_verb
		newrev.item_state = targetrev.item_state
		to_chat(user, "<span class='notice'>You succesfully convert the [targetrev] with \the [src]. Impressive, this kit can even work with a shitty toy!</span>")
		qdel(targetrev)
		qdel(src)
		return TRUE
	else if(istype(target, /obj/item/gun/ballistic/revolver/detective || /obj/item/gun/ballistic/revolver/russian) || istype(target, /obj/item/toy/gun) && !open)
		to_chat(user, "<span class='notice'>You have to open the conversion kit first.</span>")
		return FALSE

//clothing reskinning kit
/obj/item/skin_kit
	name = "\improper General Modification Kit"
	desc = "Also known as a crochet kit with spray paint on the side. Able to modify many objects."
	icon = 'modular_skyrat/icons/obj/kit.dmi'
	icon_state = "clothing_kit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/skin_kit/afterattack(atom/target, mob/user, proximity)
	if(istype(target, /obj))
		var/obj/O = target
		if(O.unique_reskin_stored)
			O.unique_reskin = O.unique_reskin_stored
			if(current_skin && !always_reskinnable)
				to_chat(user, "<span class='notice'>[target] cannot be reskinned, or has been reskinned already.</span>")
			if(O.reskin_obj(user))
				qdel(src)
				return TRUE
			else
				O.unique_reskin = initial(O.unique_reskin)
				return FALSE
		else
			to_chat(user, "<span class='notice'>[target] cannot be reskinned, or has been reskinned already.</span>")
