// Charged projectiles for charged weapons (Durr)
//All of these were nerfed into the fucking dirt. Right now, most of these are = to standard ballistic weapons with the added power draw.
/obj/item/projectile/charged
	name = "charged shot"
	icon = 'modular_skyrat/icons/obj/guns/chargeweapons.dmi'
	icon_state = "charged_projectile"
	hitsound = 'sounds/weapons/resonator_blast.ogg'
	hitsound_wall = 'sounds/weapons/effects/searwall.ogg'

/obj/item/projectile/charged/rifle
	name = "charged rifle shot"
	damage = 25

/obj/item/projectile/charged/pistol
	name = "charged pistol shot"
	icon_state = "charged_projectile_small"
	damage = 20

/obj/item/projectile/charged/smg
	name = "charged automatic shot"
	icon_state = "charged_projectile_small"
	damage = 15.5

/obj/item/projectile/charged/shotgun
	name = "charged shotgun pellet"
	damage = 20

/obj/item/projectile/charged/shotgun/nonlethal
	name = "nonlethal charged shotgun pellet"
	damage = 5
	stamina = 25

/obj/item/projectile/charged/super //Unused OP shot for like, varediting or some shit for right now.
	name = "hypercharged shot"
	damage = 75
	stamina = 25
