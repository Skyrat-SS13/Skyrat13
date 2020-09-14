// C3D (Borgs)

/obj/item/projectile/bullet/c3d
	damage = 20

// Mech LMG

/obj/item/projectile/bullet/lmg
	damage = 20

// Mech FNX-99

/obj/item/projectile/bullet/incendiary/fnx99
	damage = 20

// Turrets

/obj/item/projectile/bullet/manned_turret
	damage = 20

/obj/item/projectile/bullet/syndicate_turret
	damage = 20

// 1.95x129mm (SAW)

/obj/item/projectile/bullet/mm195x129
	name = "1.95x129mm bullet"
	damage = 35 //Skyrat Edit: LMGs should be for suppressive fire, please no 3 shot crits on the 60 round gun.
	armour_penetration = 5

/obj/item/projectile/bullet/mm195x129_ap
	name = "1.95x129mm armor-piercing bullet"
	damage = 30       //Skyrat Edit: Less damage, but surpasses five points above the bulletproof gear.
	armour_penetration = 65

/obj/item/projectile/bullet/mm195x129_hp
	name = "1.95x129mm hollow-point bullet"
	damage = 40   //Skyrat Edit: 3 shot crits, but bulletproof gear completely negates it.
	armour_penetration = -60

/obj/item/projectile/bullet/incendiary/mm195x129
	name = "1.95x129mm incendiary bullet"
	damage = 15   //Skyrat Edit: 5 less damage, but double the firestacks. Burn baby burn!
	fire_stacks = 6

//skyrat edit
/obj/item/projectile/bullet/mm712x82/match
	name = "7.12x82mm match bullet"
	ricochets_max = 2
	ricochet_chance = 60
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 35
