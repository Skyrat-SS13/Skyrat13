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



//Parent Shell
/obj/item/ammo_casing/shotgun/k_shotgun
	name = "parent kinetic shell"
	desc = "you should not have this"
	icon_state = "cshell"
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron=500)


//Starting Shells

/obj/item/ammo_casing/shotgun/k_shotgun/buck
	name = "kinetic buckshot shell"
	desc = "A shell for your Kinetic Shotgun. Fires a massive amount of kinetic force in an arc."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/buck
	pellets = 4
	variance = 15

/obj/item/ammo_casing/shotgun/k_shotgun/slug
	name = "kinetic slug shell"
	desc = "A shell for your Kinetic Shotgun. Fires a massive amount of kinetic force in a very small area, but at a closer range."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/slug
	pellets = 1
	variance = 0

//Parent bullet
/obj/item/projectile/bullet/pellet/k_shotgun
	name = "kinetic tracer"
	icon_state = "ka_tracer"
	damage_type = BRUTE
	flag = "bomb"
	var/pressure_decrease_active = FALSE
	var/pressure_decrease = 0.6

/obj/item/projectile/bullet/pellet/k_shotgun/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)

/obj/item/projectile/bullet/pellet/k_shotgun/prehit(atom/target)
	if(!lavaland_equipment_pressure_check(get_turf(target)))
		name = "weakened [name]"
		damage = damage * pressure_decrease
		pressure_decrease_active = TRUE


//Kinetic Shotgun Starting "Bullets"

/obj/item/projectile/bullet/pellet/k_shotgun/buck
	damage = 20
	range = 4
	spread = 5



/obj/item/projectile/bullet/pellet/k_shotgun/slug
	damage = 60
	range = 3
	spread = 0




//Augments (Very WIP)




//Megafauna shells/projectiles

//BDM slug
/obj/item/ammo_casing/shotgun/k_shotgun/bdm
	name = "beastblood slug"
	desc = "A shell for your kinetic shotgun. This one is a finely crafted, single slug, soaked in the blood of Goliaths. This one is very close ranged, but very high damage."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/bdm
	pellets = 1
	variance = 0
	custom_materials = list(/datum/material/iron = 500, /datum/material/silver = 500)

/obj/item/projectile/bullet/pellet/k_shotgun/bdm
	name = "bloody tracer"
	damage = 80
	range = 2
	spread = 0

//Ash Drake shell
/obj/item/ammo_casing/shotgun/k_shotgun/bone
	name = "bone shard shell"
	desc = "A shell for your kinetic shotgun. This one is loaded with shards of bone within the hollow canister, giving it an extra punch against whatever unlucky foe is on the other side."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/bone
	pellets = 4
	variance = 6
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/projectile/bullet/pellet/k_shotgun/bone
	name = "bony tracer"
	damage = 25
	range = 4
	spread = 4


//Rogue Process shell
/obj/item/ammo_casing/shotgun/k_shotgun/rogue
	name = "plasma shell"
	desc = "A shell for your kinetic shotgun. This one has been loaded with modified, close range plasma bursts. It seems to do less damage, but makes for a good mining tool."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/rogue
	pellets = 5
	variance = 1
	custom_materials = list(/datum/material/plasma = 1000)


/obj/item/projectile/bullet/pellet/k_shotgun/rogue
	name = "plasma burst"
	icon_state = "plasma"
	damage = 15
	damage_type = BURN
	range = 5
	spread = 3


//Collosus shell
/obj/item/ammo_casing/shotgun/k_shotgun/bolter
	name = "bolter casing"
	desc = "A shell for your kinetic shotgun. This one is huge! It barely even fits in the magwell. This thing would rip through just about anything on Lavaland. Hope you invested in a good stock."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/bolter
	pellets = 1
	variance = 0
	caliber = "kinetic"
	custom_materials = list(/datum/material/iron = 1500)

/obj/item/projectile/bullet/pellet/k_shotgun/bolter
	name = "bolt"
	icon_state = "pulse1"
	damage = 100
	range = 3
	spread = 0


//Legion shell
/obj/item/ammo_casing/shotgun/k_shotgun/legion
	name = "ash shell"
	desc = "A shell for your kinetic shotgun. This one burns your hand just holding it. You can hear the sound of an angry wind from within it, radiating heat. One could only imagine what this does."
	icon_state = "cshell"
	projectile_type = /obj/item/projectile/bullet/pellet/k_shotgun/legion
	pellets = 4
	variance = 15
	custom_materials = list(/datum/material/iron = 2000)

/obj/item/projectile/bullet/pellet/k_shotgun/legion
	name = "burning tracer"
	damage_type = BURN
	damage = 20
	range = 5
	spread = 6







