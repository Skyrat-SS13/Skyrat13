// Charged projectiles for charged weapons (Durr)

/obj/item/projectile/charged
	name = "charged shot"
	icon = 'modular_skyrat/icons/obj/guns/chargeweapons.dmi'
	icon_state = "charged_projectile"
	hitsound = "sounds/weapons/resonator_blast.ogg"
	hitsound_wall = "sounds/weapons/effects/searwall.ogg"

/obj/item/projectile/charged/rifle
	name = "charged rifle shot"
	damage = 75

/obj/item/projectile/charged/pistol
	name = "charged pistol shot"
	icon_state = "charged_projectile_small"
	damage = 40

/obj/item/projectile/charged/smg
	name = "charged automatic shot"
	icon_state = "charged_projectile_small"
	damage = 35

/obj/item/projectile/charged/shotgun
	name = "charged shotgun pellet"
	damage = 30
	dismemberment = 0.5

/obj/item/projectile/charged/shotgun/nonlethal
	name = "nonlethal charged shotgun pellet"
	damage = 5
	stamina = 25
	dismemberment = 0

/obj/item/projectile/charged/rifle/toy
	name = "toy charged shot"
	damage = 0
	nodamage = 1
	stamina = 5
	hitsound = "sounds/weapons/taser2.ogg"