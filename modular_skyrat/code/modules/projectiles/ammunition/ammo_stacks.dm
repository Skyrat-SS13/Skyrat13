//Ammo stacks
/obj/item/ammo_casing
	var/obj/item/ammo_box/magazine/ammo_stack = /obj/item/ammo_box/magazine/ammo_stack

/obj/item/ammo_casing/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/AC = I
		if(ammo_stack && AC.ammo_stack && (caliber == AC.caliber) && BB && AC.BB)
			var/obj/item/ammo_box/magazine/ammo_stack/AS = new(get_turf(src))
			AS.name = "[caliber] rounds"
			AS.caliber = caliber
			AS.give_round(src)
			AS.give_round(AC)
			user.put_in_hands(AS)
			to_chat(user, "<span class='notice'>[src] has been stacked into [AS].</span>")
		else if(!BB || !AC.BB)
			to_chat(user, "<span class='warning'>Fnord... I can't stack spent casings.</span>")
		else if(!ammo_stack)
			to_chat(user, "<span class='warning'>[src] can't be stacked.</span>")
		else if(!AC.ammo_stack)
			to_chat(user, "<span class='warning'>[AC] can't be stacked.</span>")

/obj/item/ammo_box/magazine/ammo_stack
	name = "ammo stack"
	desc = "A stack of ammo."
	icon = 'modular_skyrat/icons/obj/bobstation/ammo/stacks.dmi'
	icon_state = "bullet-stack"
	max_ammo = 12
	multiple_sprites = TRUE
	start_empty = TRUE

/obj/item/ammo_box/magazine/ammo_stack/get_round(keep)
	..()
	update_icon()

/obj/item/ammo_box/magazine/ammo_stack/give_round(obj/item/ammo_casing/R, replace_spent)
	..()
	if(ammo_count() <= 0)
		qdel(src)
	update_icon()

//fuck idk what to do with this
/obj/item/ammo_box/magazine/ammo_stack/shotgun
	icon_state = "shell-stack"
