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
	pellets = 4
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

/obj/item/projectile/bullet/pellet/kinetic_b/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)


/obj/item/projectile/bullet/kinetic_s
	name = "kinetic tracer"
	icon_state = "ka_tracer"
	damage = 60
	damage_type = BRUTE
	flag = "bomb"
	range = 3
	spread = 0

/obj/item/projectile/bullet/kinetic_s/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)


//Augments (Very WIP)




//Megafauna shells/projectiles

//BDM slug
/obj/item/ammo_casing/shotgun/k_bdm_slug
	name = "beastblood slug"
	desc = "A shell for your kinetic shotgun. This one is a finely crafted, single slug, soaked in the blood of Goliaths. This one is very close ranged, but very high damage."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/kinetic_bdm_s
	pellets = 1
	variance = 0
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron = 500, /datum/material/silver = 500)

/obj/item/projectile/bullet/kinetic_bdm_s
	name = "bloody tracer"
	icon_state = "ka_tracer"
	damage = 80
	damage_type = BRUTE
	flag = "bomb"
	range = 2
	spread = 0

/obj/item/projectile/bullet/kinetic_bdm_s/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)

//Ash Drake shell
/obj/item/ammo_casing/shotgun/k_ash_buck
	name = "bone shard shell"
	desc = "A shell for your kinetic shotgun. This one is loaded with shards of bone within the hollow canister, giving it an extra punch against whatever unlucky foe is on the other side."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/kinetic_ash_b
	pellets = 4
	variance = 6
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/projectile/bullet/pellet/kinetic_ash_b
	name = "bony tracer"
	icon_state = "ka_tracer"
	damage = 25
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	spread = 4

/obj/item/projectile/bullet/pellet/kinetic_ash_b/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)

//Rogue Process shell
/obj/item/ammo_casing/shotgun/k_rogue_buck
	name = "plasma shell"
	desc = "A shell for your kinetic shotgun. This one has been loaded with modified, close range plasma bursts. It seems to do less damage, but makes for a good mining tool."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/kinetic_rogue_b
	pellets = 5
	variance = 1
	caliber = "kinetic"
	custom_materials = list(/datum/material/plasma = 1000)


/obj/item/projectile/bullet/pellet/kinetic_rogue_b
	name = "plasma burst"
	icon_state = "plasma"
	damage = 15
	damage_type = BURN
	range = 5
	spread = 3

/obj/item/projectile/bullet/pellet/kinetic_rogue_b/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)


//Collosus shell
/obj/item/ammo_casing/shotgun/k_colly_slug
	name = "bolter casing"
	desc = "A shell for your kinetic shotgun. This one is huge! It barely even fits in the magwell. This thing would rip through just about anything on Lavaland. Hope you invested in a good stock."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/kinetic_colly_s
	pellets = 1
	variance = 0
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron = 1500)

/obj/item/projectile/bullet/kinetic_colly_s
	name = "bolt"
	icon_state = "pulse1"
	damage = 100
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	spread = 0

/obj/item/projectile/bullet/kinetic_colly_s/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)

//Legion shell
/obj/item/ammo_casing/shotgun/k_legion_buck
	name = "ash shell"
	desc = "A shell for your kinetic shotgun. This one burns your hand just holding it. You can hear the sound of an angry wind from within it, radiating heat. One could only imagine what this does."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/kinetic_legion_b
	pellets = 4
	variance = 15
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron = 2000)

/obj/item/projectile/bullet/pellet/kinetic_legion_b
	name = "burning tracer"
	icon_state = "ka_tracer"
	damage_type = BURN
	damage = 20
	range = 5
	spread = 6

/obj/item/projectile/bullet/pellet/kinetic_legion_b/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)






