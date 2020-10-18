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

/obj/item/ammo_box/magazine/m10mm/makeshift/update_icon_state()
	..()
	icon_state = "9x19pms-[ammo_count() ? "3" : "0"]"

//USP-Match
/obj/item/ammo_box/magazine/usp
	name = "USP magazine (9mm rubber)"
	desc = "A magazine for the security USP Match. Security systems lock it to be only able to load rubber 9mm rounds."
	icon = 'modular_skyrat/icons/obj/ammo.dmi'
	icon_state = "uspm-15"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 15

//Nangler
/obj/item/ammo_box/magazine/nangler
	name = "nangler magazine (9mm)"
	desc = "A low capacity magazine for compact pistols."
	icon = 'modular_skyrat/icons/obj/bobstation/ammo/pistol.dmi'
	icon_state = "pistol9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 8

/obj/item/ammo_box/magazine/nangler/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[ammo_count() ? "8" : "0"]"

//M1911
/obj/item/ammo_box/magazine/m45
	icon = 'modular_skyrat/icons/obj/bobstation/ammo/pistol.dmi'
	icon_state = "pistol45"

/obj/item/ammo_box/magazine/m45/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[ammo_count()]"
