// Holorifle: energy pump action shotgun, but kinda shit. Original /tg/ PR made by necromanceranne.
/obj/item/gun/ballistic/shotgun/holorifle
	name = "holorifle"
	desc = "A shotgun-like weapon crafted to utilize holographic projectors like a laser firing lens. Its power expenditure requires dedicated microfusion cells to fire in place of standard ammunition."
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	icon_state = "holorifle"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/64x_guns_right.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/back.dmi'
	item_state = "holorifle"
	fire_sound = 'sound/weapons/pulse.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/holorifle
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

//Cane gun, chad mime and clown traitor item
/obj/item/gun/ballistic/shotgun/canegun
	name = "pimp stick"
	desc = "A gold-rimmed cane, with a gleaming diamond set at the top. Great for bashing in kneecaps."
	mag_type = /obj/item/ammo_box/magazine/internal/shot/canegun
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "pimpstick"
	item_state = "pimpstick"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/righthand.dmi'
	force = 15
	throwforce = 7
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("pimped", "smacked", "disciplined", "busted", "capped", "decked")
	resistance_flags = FIRE_PROOF
	var/mob/current_owner

/obj/item/gun/ballistic/shotgun/canegun/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_HANDS)
		if(!current_owner && user)
			current_owner = user
		if(current_owner && current_owner != user)
			current_owner = null

/obj/item/gun/ballistic/shotgun/canegun/sawoff(mob/user)
	to_chat(user, "<span class='warning'>Kinda defeats the purpose of a cane, doesn't it?</span>")
	return

/obj/item/gun/ballistic/shotgun/canegun/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is hitting [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to discipline [user.p_them()]self for being a mark-ass trick.</span>")
	return (BRUTELOSS)

/obj/item/ammo_box/magazine/internal/shot/canegun
	name = "cane-gun internal magazine"
	max_ammo = 3

//upgraded double barrel
/obj/item/gun/ballistic/revolver/doublebarrel/upgraded
	name = "upgraded double barreled shotgun"
	desc = "Two times the fun, at once."
	burst_size = 2
	burst_shot_delay = 4

/obj/item/gun/ballistic/revolver/doublebarrel/upgraded/sawoff(mob/user)
	to_chat(user, "<span class='warning'>Considering the modifications, sawing it off probably would break it entirely.</span>")
	return
