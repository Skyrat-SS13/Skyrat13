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

/obj/item/projectile/plasma/watcher
	name = "freezing blast"
	icon_state = "ice_2"
	damage = 0
	flag = "energy"
	damage_type = BURN
	range = 4 //terrible range
	mine_range = 4 //serves as a mining tool... a rather shit one
	var/temperature = 50 //half what a normal watcher does
	dismemberment = FALSE

/obj/item/projectile/plasma/watcher/on_hit(atom/target, blocked = 0)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.adjust_bodytemperature(((100-blocked)/100)*(temperature - L.bodytemperature)) // the new body temperature is adjusted by 100-blocked % of the delta between body temperature and the bullet's effect temperature
