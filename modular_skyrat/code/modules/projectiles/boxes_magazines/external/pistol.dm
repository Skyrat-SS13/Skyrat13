//Pipe pistol
/obj/item/ammo_box/magazine/m10mm/makeshift
	name = "makeshift pistol magazine (10mm)"
	desc = "If this thing doesn't blow up when firing, it's a miracle."
	icon = 'modular_skyrat/icons/obj/ammo.dmi'
	icon_state = "9x19pms"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 3
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m10mm/makeshift/update_icon()
	..()
	icon_state = icon_state = "9x19pms-[ammo_count() ? "3" : "0"]"

//USP-Match
/obj/item/ammo_box/magazine/usp
	name = "USP magazine (9mm rubber)"
	desc = "A magazine for the security USP Match. Security systems lock it to be only able to load rubber 9mm rounds."
	icon = 'modular_skyrat/icons/obj/ammo.dmi'
	icon_state = "uspm-15"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	caliber = "9mm"
	var/locked = TRUE
	var/list/accepted_casings = list(/obj/item/ammo_casing/c9mm/rubber)
	max_ammo = 15

/obj/item/ammo_box/magazine/usp/give_round(obj/item/ammo_casing/R, replace_spent)
	. = ..()
	if(!(R.type in accepted_casings) && locked)
		return FALSE
	
/obj/item/ammo_box/magazine/usp/update_icon()
	..()
	icon_state = icon_state = "uspm-[ammo_count() ? "15" : "0"]"

/obj/item/ammo_box/magazine/usp/emag_act(mob/user)
	..()
	to_chat(user, "<span class='notice'>The [src]'s security lock gets fried.</span>")
	ammo_type = /obj/item/ammo_casing/c9mm
	locked = FALSE

/obj/item/ammo_box/magazine/usp/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, /obj/item/card/id))
		var/obj/item/card/id/authorize = I
		if(ACCESS_HOS in authorize.access)
			toggle_lock(user)
			locked = !locked

/obj/item/ammo_box/magazine/usp/proc/toggle_lock(var/mob/living/user)
	locked = !locked
	if(user)
		if(locked)
			to_chat(user, "<span class='notice'>The [src] is now unable to accept lethal rounds.</span>")
		else
			to_chat(user, "<span class='notice'>The [src] can now accept lethal 9mm rounds.</span>")
