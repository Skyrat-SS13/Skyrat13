//Pipe pistol
/obj/item/gun/ballistic/automatic/pistol/makeshift
	name = "pipe pistol"
	desc = "A somewhat bulky aberration of pipes and wood, in the form of a pistol. It probably should get the job done, still."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "pistolms"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m10mm/makeshift
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 3
	actions_types = list()

/obj/item/gun/ballistic/automatic/pistol/makeshift/update_icon()
	..()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

//USP pistol - Universal Self Protection pistol
/obj/item/gun/ballistic/automatic/pistol/uspm
	name = "USP 9mm"
	desc = "USP - Universal Self Protection. A standard-issue low cost handgun, chambered in 9x19mm and fitted with a smart lock for LTL rounds."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	item_state = "usp-m"
	icon_state = "usp-m"
	fire_sound = 'modular_skyrat/sound/weapons/uspshot.ogg'
	mag_type = /obj/item/ammo_box/magazine/usp
	can_suppress = FALSE
	unique_reskin = list("USP Match" = "usp-m",
						"Stealth" = "stealth",
						"P9" = "p9",
						"M92FS" = "beretta")
	obj_flags = UNIQUE_RENAME
	req_access = list(ACCESS_HOS)

/obj/item/gun/ballistic/automatic/pistol/uspm/update_icon()
	..()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][chambered ? "" : "-e"]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/uspm/emag_act(mob/user)
	if(magazine)
		var/obj/item/ammo_box/magazine/M = magazine
		M.emag_act(user)

/obj/item/gun/ballistic/automatic/pistol/uspm/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(check_access(A))
		if(magazine)
			magazine.attackby(A, user)

//Seccie pistol
/obj/item/gun/ballistic/automatic/pistol/nangler
	name = "9mm pistol"
	desc = "ML Nangler - Standard issue security firearm, widely used by low tier corporate militias. \
			Unreliable at best, this small sidearm is chambered in 9mm."
	icon = 'modular_skyrat/icons/obj/bobstation/projectile.dmi'
	icon_state = "smallpistol"
	fire_sound = 'modular_skyrat/sound/guns/pistoln1.ogg'
	mag_type = /obj/item/ammo_box/magazine/nangler
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/pistol/nangler/update_icon_state()
	..()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"][magazine ? "" : "-nomag"][safety ? "-safe" : ""]"

/obj/item/gun/ballistic/automatic/pistol/nangler/toggle_safety(mob/user)
	..()
	update_icon_state()
