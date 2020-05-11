//the buzz's energy lance to fend off space wildlife
/obj/item/mecha_parts/mecha_equipment/energylance
	name = "buzz type exosuit energy lance"
	desc = "A lance - capable of dealing with assailants in any situation, but especially effective in low pressures."
	icon = 'modular_skyrat/icons/mecha/mecha_equipment.dmi'
	icon_state = "buzzlance"
	equip_cooldown = 10
	var/cooldown = 0
	energy_drain = 10
	force = 5
	var/stabhalf = 20
	var/stabfull = 80
	harmful = TRUE
	tool_behaviour = TOOL_SCALPEL
	toolspeed = 0.7 //doesn't really matter unless a madman uses this for fucking surgery

/obj/item/mecha_parts/mecha_equipment/energylance/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 50, 100, null, null, TRUE)

/obj/item/mecha_parts/mecha_equipment/energylance/action(atom/target)
	if(isliving(target))
		var/obj/mecha/M = chassis
		if(M)
			var/mob/living/U = M.occupant
			if(HAS_TRAIT(U, TRAIT_PACIFISM))
				to_chat(U, "<span class='warning'>You don't want to harm other living beings!</span>")
				return FALSE
			return stab(target, M, U)
		else
			return FALSE
	return TRUE

//the default mech attack proc is crap. we do it our own way.
/obj/item/mecha_parts/mecha_equipment/energylance/proc/stab(var/mob/living/stabbed, var/obj/mecha/usermecha, var/mob/living/user)
	if(world.time < cooldown)
		return
	cooldown = world.time + equip_cooldown
	var/stabbyforce = lavaland_equipment_pressure_check(get_turf(usermecha)) ? stabfull : stabhalf
	var/defzone = check_zone(user.zone_selected)
	usermecha.do_attack_animation(stabbed, null, null)
	var/dirtotarget = get_dir(usermecha, stabbed)
	var/turf/T = get_step(user, dirtotarget)
	var/obj/effect/temp_visual/mechaenergylance/S = new /obj/effect/temp_visual/mechaenergylance(T)
	switch(dirtotarget)
		if(WEST)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = -4, pixel_y = -2, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(EAST)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)),time = 0)
			animate(S, pixel_x = 4, pixel_y = 2, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(NORTH)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = -1, pixel_y = -2, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(SOUTH)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = 1, pixel_y = 2, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(SOUTHWEST)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = -4, pixel_y = 4, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(SOUTHEAST)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = 4, pixel_y = 4, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(NORTHWEST)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = -4, pixel_y = -4, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
		if(NORTHEAST)
			animate(S, transform = turn(matrix(), (dir2angle(dirtotarget) - 45)), time = 0)
			animate(S, pixel_x = 4, pixel_y = -4, time = 0)
			animate(S, pixel_x = 0, pixel_y = 0, time = 4)
	for(var/mob/living/M in T.contents)
		M.apply_damage(damage = stabbyforce,damagetype = BRUTE, def_zone = defzone)
	playsound(usermecha, 'sound/weapons/sear.ogg', stabbyforce == stabfull ? 100 : 40)

/obj/effect/temp_visual/mechaenergylance
	name = "energy lance attack"
	desc = "Ouch."
	icon = 'modular_skyrat/icons/mecha/mecha_equipment.dmi'
	icon_state = "buzzlance"
	duration = 5
	alpha = 122
	layer = ABOVE_MOB_LAYER
