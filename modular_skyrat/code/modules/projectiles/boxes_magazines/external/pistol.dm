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