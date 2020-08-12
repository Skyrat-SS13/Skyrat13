//THE kinetic shotgun
/obj/item/gun/ballistic/shotgun/kinetic_shotgun
	icon = "shotgun"
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	name = "Kinetic Shotgun"
	desc = "A popular alternative to the Kinetic Accelerator. This one relies on more powerful kinetic blasts being stored within shells, then loaded into the gun by hand. Of course, the falloff is more immense than an Accelerator, and it also has a wider spread to boot. Even still, it finds its niche market among the most foolhardy miners."
	force = 10
	mag_type = obj/item/ammo_box/magazine/internal/shot/kinetic

//custom mag for kinetic shells only
obj/item/ammo_box/magazine/internal/shot/kinetic
	name = "kinetic shotgun internal magazine"
	ammo_type = obj/item/ammo_casing/shotgun/kinetic
	max_ammo = 7



//ammo for gun
	//buckshot
/obj/item/ammo_casing/shotgun/kinetic/buckshot
	name = "kinetic buckshot shell"
	desc = "A shell for your Kinetic Shotgun. Fires a massive amount of kinetic force in an arc."
	icon_state =
	projectile_type = /obj/item/projectile/bullet/pellet/kinetic_buck

	//buckshot projectile
/obj/item/projectile/bullet/pellet/kinetic_buck
	name = "kinetic tracer"
	icon_state = "ka_tracer"
	damage = 20
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	spread = 3

	//atmos check
/obj/item/projectile/bullet/pellet/kinetic_buck/prehit(atom/target)
	. = ..()
	if(.)
		if(!lavaland_equipment_pressure_check(get_turf(target)))
			name = "weakened [name]"
			damage = damage * pressure_decrease
			pressure_decrease_active = TRUE
		else()
			pressure_decrease_active = FALSE

	//slug
/obj/item/ammo_casing/shotgun/kinetic/slug
	name = "kinetic slug shell"
	desc = "A shell for your Kinetic Shotgun. Fires a massive amount of kinetic force in a very small area, but at a closer range."
	icon_state =
	projectile_type = /obj/item/projectile/bullet/kinetic_slug

	//atmos check
/obj/item/projectile/bullet/pellet/kinetic_slug/prehit(atom/target)
	. = ..()
	if(.)
		if(!lavaland_equipment_pressure_check(get_turf(target)))
			name = "weakened [name]"
			damage = damage * pressure_decrease
			pressure_decrease_active = TRUE
		else()
			pressure_decrease_active = FALSE

	//slug projectile
/obj/item/projectile/bullet/kinetic_slug
	name = "kinetic tracer"
	icon_state = "ka_tracer"
	damage = 60
	damage_type = BRUTE
	flag = "bomb"
	range = 3
	spread = 0


//drops for gun to be made
