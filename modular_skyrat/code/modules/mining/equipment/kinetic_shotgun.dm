//THE kinetic shotgunb
/obj/item/gun/ballistic/shotgun/kinetic_shotgun
	name = "Kinetic Shotgun"
	desc = "A popular alternative to the Kinetic Accelerator. This one relies on more powerful kinetic blasts being stored within shells, then loaded into the gun by hand. Of course, the falloff is more immense than an Accelerator, and it also has a wider spread to boot. Even still, it finds its niche market among the most foolhardy miners."
	icon_state = "shotgun"
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/shot/kinetic

obj/item/ammo_box/magazine/internal/shot/kinetic
	name = "kinetic shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = "kinetic"
	max_ammo = 5

//Starting Shells

/obj/item/ammo_casing/shotgun/k_buck
	name = "kinetic buckshot shell"
	desc = "A shell for your Kinetic Shotgun. Fires a massive amount of kinetic force in an arc."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/kinetic_b
	pellets = 5
	variance = 15
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron=500)

/obj/item/ammo_casing/shotgun/k_slug
	name = "kinetic slug shell"
	desc = "A shell for your Kinetic Shotgun. Fires a massive amount of kinetic force in a very small area, but at a closer range."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/kinetic_s
	pellets = 1
	variance = 0
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron=500)



//Kinetic Shotgun Starting "Bullets"

/obj/item/projectile/bullet/pellet/kinetic_b
	name = "kinetic tracer"
	icon_state = "ka_tracer"
	damage = 20
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	spread = 5

/obj/item/projectile/bullet/kinetic_s
	name = "kinetic tracer"
	icon_state = "ka_tracer"
	damage = 60
	damage_type = BRUTE
	flag = "bomb"
	range = 3
	spread = 0

//Augments


//Shells from Megafauna