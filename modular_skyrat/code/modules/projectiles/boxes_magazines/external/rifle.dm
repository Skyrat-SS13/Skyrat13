//pee pee poo poo
/obj/item/ammo_box/magazine/m10mm/rifle
	icon = 'modular_skyrat/icons/obj/bobstation/ammo/rifle.dmi'
	icon_state = "surplus"
	max_ammo = 7

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon()
	icon_state = "[initial(icon_state)]-[ammo_count() ? 7 : 0]"
