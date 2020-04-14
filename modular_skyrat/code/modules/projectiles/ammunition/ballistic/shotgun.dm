//animated shomtgun shells
/obj/item/ammo_casing/shotgun
	icon = 'modular_skyrat/icons/obj/shomtgun.dmi'

/obj/item/ammo_casing/shotgun/incendiary
	name = "incendiary slug"
	desc = "An incendiary-coated shotgun slug."
	icon_state = "ishell"
	projectile_type = /obj/item/projectile/bullet/incendiary/shotgun

/obj/item/ammo_casing/shotgun/incendiary/Initialize()
	icon_state = "ishell-live"