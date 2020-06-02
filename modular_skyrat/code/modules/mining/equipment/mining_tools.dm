/obj/item/shovel/wide
	name = "wide shovel"
	desc = "It's a shovel, but american."
	icon = 'modular_skyrat/icons/obj/shovel.dmi'
	icon_state = "shovel_wide"
	force = 10
	var/digrange = 1 //based on the view proc, so 0 equals only the tile you click on, etc
	var/widespeed = 0.30
	tool_behaviour = null //we use the afterattack to do this shit

/obj/item/shovel/wide/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(proximity_flag && istype(target, /turf/open/floor/plating/asteroid))
		var/turf/open/floor/plating/asteroid/ass = target
		if(ass && istype(ass) && ass.can_dig(user))
			if(do_after(user, 200 * widespeed, TRUE, src))
				for(var/turf/open/floor/plating/asteroid/steroid in view(digrange, ass))
					steroid.getDug()

/obj/item/shovel/titanium
	name = "titanium shovel"
	icon = 'modular_skyrat/icons/obj/shovel.dmi'
	icon_state = "shovel_titanium"
	force = 12
	throwforce = 5
	toolspeed = 0.05

/obj/item/shovel/wide/titanium
	name = "wide titanium shovel"
	icon = 'modular_skyrat/icons/obj/shovel.dmi'
	icon_state = "shovel_wide_titanium"
	force = 14
	throwforce = 4
	widespeed = 0.15

/obj/item/shovel/diamond
	name = "diamond shovel"
	icon = 'modular_skyrat/icons/obj/shovel.dmi'
	icon_state = "shovel_diamond"
	force = 14
	throwforce = 6
	toolspeed = 0.025

/obj/item/shovel/wide/diamond
	name = "wide diamond shovel"
	icon = 'modular_skyrat/icons/obj/shovel.dmi'
	icon_state = "shovel_wide_diamond"
	force = 16
	throwforce = 8
	widespeed = 0.075
