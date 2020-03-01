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
	name = "USP Match magazine (9mm rubber)"
	desc = "A magazine for the security USP Match, refitted to only be loadable with non-lethal rounds."
	icon = 'modular_skyrat/icons/obj/ammo.dmi'
	icon_state = "uspm"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	caliber = "9mm"
	max_ammo = 15

/obj/item/ammo_box/magazine/usp/update_icon()
	..()
	icon_state = icon_state = "uspm-[ammo_count() ? "15" : "0"]"