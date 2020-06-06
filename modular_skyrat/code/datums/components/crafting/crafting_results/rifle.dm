//makeshift lever action rifle
/obj/item/gun/ballistic/shotgun/improvised_rifle
	name = "makeshift lever-action rifle"
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "irifle-lever"
	item_state = "shotgun"
	desc = "A lever action breechloaded rifle, able to load two cartridges."
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised/rifle/lever_rifle
	can_bayonet = TRUE
	var/obj/item/gun/sawn_type = /obj/item/gun/ballistic/shotgun/improvised_rifle/sawn
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

/obj/item/ammo_box/magazine/internal/shot/improvised/rifle/lever_rifle
	name = "7.62mm lever action rifle internal magazine"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = "a762"
	max_ammo = 1

/obj/item/gun/ballistic/shotgun/improvised_rifle/attackby(obj/item/A, mob/user, params)
	..()
	if(A.tool_behaviour == TOOL_SAW || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)
	if(istype)

/obj/item/gun/ballistic/shotgun/improvised_rifle/sawoff(mob/user)
	. = ..()
	if(!sawn_off && sawntype)
		if(.)
			if(slung)
				new /obj/item/stack/cable_coil(get_turf(src), 10)
				slung = 0
				update_icon()
			new sawntype(get_turf(user))
			return qdel(src)
	else
		to_chat(user, "<span class='warning'>\The [src] can't be sawn off!")
		return FALSE

/obj/item/gun/ballistic/shotgun/improvised_rifle/sawn
	name = "sawn-Off makeshift lever-action 7.62mm rifle"
	desc = "An actual affront against humanity."
	icon_state = "irifle-lever"
	item_state = "gun"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_BELT
	projectile_damage_multiplier = 0.8 //The sawn off needs to be shittier for ""balance"" because of ""alpha strikes""

/obj/item/gun/ballistic/shotgun/improvised_rifle/sawn/Initialize()
	. = ..()
	inaccuracy_modifier *= 2
	update_icon()

//makeshift over/under rifle
/obj/item/gun/ballistic/revolver/doublebarrel/improvised_rifle_ou
	name = "makeshift .22 magnum O/U rifle"
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "irifle-ou"
	item_state = "shotgun"
	desc = "An over under rifle, using .22 magnum cartridges."
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised/rifle/over_under
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = TRUE
	var/obj/item/gun/sawn_type = null
	burst_size = 2
	var/burst_size_toggled = 2
	burst_shot_delay = 2
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/ballistic/revolver/doublebarrel/improvised_rifle_ou/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_firemode))
		burst_select(user)

/obj/item/gun/ballistic/revolver/doublebarrel/improvised_rifle_ou/proc/burst_select(mob/user)
	if(burst_size == burst_size_toggled)
		burst_size = 1
		if(user)
			to_chat(user, "<span class='notice'>\The [src] will now fire one barrel at a time.")
	else
		burst_size = burst_size_toggled
		if(user)
			to_chat(user, "<span class='notice'>\The [src] will now fire all barrels at once.")

/obj/item/ammo_box/magazine/internal/shot/improvised/rifle/over_under
	name = "over under rifle internal magazine"
	ammo_type = /obj/item/ammo_casing/mag22
	caliber = "mag22"
	max_ammo = 2

/obj/item/gun/ballistic/revolver/doublebarrel/improvised_rifle_ou/sawoff(mob/user)
	. = ..()
	if(!sawn_off && sawn_type)
		if(.)
			if(slung)
				new /obj/item/stack/cable_coil(get_turf(src), 10)
				slung = 0
				update_icon()
			new sawn_type(get_turf(user))
			return qdel(src)
	else
		to_chat(user, "<span class='warning'>\The [src] can't be sawn off!")
		return FALSE

//sucky makeshift rifle
/obj/item/gun/ballistic/revolver/doublebarrel/improvised/bad_improvised_rifle
	name = "makeshift zip rifle"
	desc = "A large zip gun more or less that takes a single 7.62mm bullet."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "irifle"
	item_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised/rifle
	can_bayonet = TRUE
	sawn_type = /obj/item/gun/ballistic/revolver/doublebarrel/improvised/bad_improvised_rifle/sawn
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	explodes_on_dual = FALSE

/obj/item/ammo_box/magazine/internal/shot/improvised/rifle
	name = "7.62mm zip rifle internal magazine"
	ammo_type = /obj/item/ammo_casing/a762
	caliber = "a762"
	max_ammo = 1

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/bad_improvised_rifle/sawn
	name = "sawn-off makeshift zip rifle"
	desc = "A mangled zip rifle, chambered in 7.62mm."
	icon_state = "irifle"
	item_state = "gun"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_BELT
	projectile_damage_multiplier = 0.8 //The sawn off needs to be shittier for ""balance""

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/bad_improvised_rifle/sawn/Initialize()
	. = ..()
	inaccuracy_modifier *= 2
	update_icon()
