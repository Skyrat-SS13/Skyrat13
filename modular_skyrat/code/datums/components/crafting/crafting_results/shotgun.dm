//improv shotgun
/obj/item/gun/ballistic/revolver/doublebarrel/improvised
	name = "improvised shotgun"
	desc = "A shoddy break-action breechloaded shotgun."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "ishotgun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	force = 10
	slot_flags = null
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	sawn_desc = "I'm just here for the gasoline."
	unique_reskin = null
	projectile_damage_multiplier = 1
	var/slung = FALSE
	var/obj/item/gun/sawn_type = /obj/item/gun/ballistic/revolver/doublebarrel/improvised/sawn
	explodes_on_dual = TRUE

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		if(A.use_tool(src, user, 0, 10, max_level = JOB_SKILL_BASIC))
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, "<span class='notice'>You tie the lengths of cable to the shotgun, making a sling.</span>")
			slung = TRUE
			update_icon()
		else
			to_chat(user, "<span class='warning'>You need at least ten lengths of cable if you want to make a sling!</span>")

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/update_icon()
	..()
	if(slung)
		icon_state += "sling"

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/sawoff(mob/user)
	. = ..()
	if(.) //sawing off the gun removes the sling
		if(slung)
			new /obj/item/stack/cable_coil(get_turf(src), 10)
			slung = 0
			update_icon()
		new sawn_type(get_turf(user))
		return qdel(src)

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/sawn
	name = "sawn-off improvised shotgun"
	desc = "I'm just here for the gasoline."
	icon_state = "ishotgun"
	item_state = "gun"
	w_class = WEIGHT_CLASS_NORMAL
	sawn_off = TRUE
	weapon_weight = WEAPON_LIGHT
	slot_flags = ITEM_SLOT_BELT
	projectile_damage_multiplier = 0.8 //The sawn off needs to be shittier for ""balance"" because of ""alpha strikes""
	explodes_on_dual = TRUE

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/sawn/Initialize()
	. = ..()
	inaccuracy_modifier *= 2
	update_icon()

//pocket shotgun
/obj/item/gun/ballistic/revolver/doublebarrel/improvised/sawn/pocket
	name = "pocket shotgun"
	desc = "The weapon of an absolutely insane man, fits even in the smallest pockets at a heavy cost."
	icon_state = "ishotgun-sawn"
	item_state = "gun"
	w_class = WEIGHT_CLASS_TINY
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_POCKET | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	projectile_damage_multiplier = 0.4 //why
	projectile_ap_multiplier = 0.5 //god why
	explodes_on_dual = TRUE
