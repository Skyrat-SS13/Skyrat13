/obj/item/projectile/bullet/mag22
	name = ".22 magnum bullet"
	desc = "Oh no."
	damage = 35
	impact_effect_type = /obj/effect/temp_visual/impact_effect

/obj/item/projectile/bullet/22mag/Initialize()
	. = ..()
	do_sparks(rand(1, 4), GLOB.all_dirs, src)
