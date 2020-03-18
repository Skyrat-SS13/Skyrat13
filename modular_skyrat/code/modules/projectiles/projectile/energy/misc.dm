/obj/item/projectile/energy/holo
	name = "holoprojectile"
	icon = 'modular_skyrat/icons/obj/projectiles.dmi'
	icon_state = "holo"
	damage = 40
	damage_type = BURN
	range = 14

/obj/item/projectile/energy/holo/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.apply_status_effect(STATUS_EFFECT_HOLOBURN, firer)