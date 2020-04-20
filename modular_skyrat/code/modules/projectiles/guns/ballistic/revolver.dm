/obj/item/conversion_kit
	name = "\improper Revolver Conversion Kit"
	desc = "A professional conversion kit used to convert any knock off revolver into the real deal capable of shooting lethal .357 rounds without the possibility of catastrophic failure. Comes packed with 7 rounds, too."
	icon = 'modular_skyrat/icons/obj/kit.dmi'
	icon_state = "kit"
	flags_1 =  CONDUCT_1
	w_class = WEIGHT_CLASS_SMALL
	var/open = 0

/obj/item/conversion_kit/Initialize()
	..()
	update_icon()

/obj/item/conversion_kit/update_icon()
	icon_state = "[initial(icon_state)]_[open]"

/obj/item/conversion_kit/attack_self(mob/user)
	open = !open
	to_chat(user, "<span class='notice'>You [open ? "open" : "close"] the conversion kit.</span>")
	update_icon()

/obj/item/conversion_kit/afterattack(atom/target, mob/user, proximity)
	if(istype(target, /obj/item/gun/ballistic/revolver/detective || /obj/item/gun/ballistic/revolver/russian) && open)
		var/obj/item/gun/ballistic/revolver/targetrev = target
		var/obj/item/gun/ballistic/revolver/newrev = new /obj/item/gun/ballistic/revolver(target.loc)
		newrev.name = targetrev.name
		newrev.desc = targetrev.desc + " This one seems a little odd."
		newrev.icon = targetrev.icon
		newrev.icon_state = targetrev.icon_state
		newrev.lefthand_file = targetrev.lefthand_file
		newrev.righthand_file = targetrev.righthand_file
		newrev.attack_verb = targetrev.attack_verb
		newrev.item_state = targetrev.item_state
		to_chat(user, "<span class='notice'>You succesfully convert the [targetrev] with \the [src].</span>")
		qdel(targetrev)
		qdel(src)
		return TRUE
	else if(istype(target, /obj/item/toy/gun) && open)
		var/obj/item/toy/gun/targetrev = target
		var/obj/item/gun/ballistic/revolver/newrev = new /obj/item/gun/ballistic/revolver(target.loc)
		newrev.name = targetrev.name
		newrev.desc = targetrev.desc + " This one seems a little odd."
		newrev.icon = targetrev.icon
		newrev.icon_state = targetrev.icon_state
		newrev.lefthand_file = targetrev.lefthand_file
		newrev.righthand_file = targetrev.righthand_file
		newrev.attack_verb = targetrev.attack_verb
		newrev.item_state = targetrev.item_state
		to_chat(user, "<span class='notice'>You succesfully convert the [targetrev] with \the [src]. Impressive, this kit can even work with a shitty toy!</span>")
		qdel(targetrev)
		qdel(src)
		return TRUE
	else if(istype(target, /obj/item/gun/ballistic/revolver/detective || /obj/item/gun/ballistic/revolver/russian) || istype(target, /obj/item/toy/gun) && !open)
		to_chat(user, "<span class='notice'>You have to open the conversion kit first.</span>")
		return FALSE

//detective revomlver changes
/obj/item/gun/ballistic/revolver/detective
	desc = "Although far surpassed by newer firearms, this revolver is still quite effective and popular as a self defense weapon, and as an oldschool styled sidearm for military contractors. Chambering .357 in it however, is not recommended."

//Contender, made by ArcLumin. Ported from hippie.
/obj/item/gun/ballistic/shotgun/doublebarrel/contender
	desc = "The Contender G13, a favorite amongst space hunters. An easily modified bluespace barrel and break action loading means it can use any ammo available.\
	The side has an engraving which reads 'Made by ArcWorks'."
	name = "Contender"
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "contender-s"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/contender
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = UNIQUE_RENAME
	unique_reskin = 0
	fire_delay = 2

/obj/item/gun/ballistic/shotgun/doublebarrel/contender/sawoff(mob/user)
	to_chat(user, "<span class='warning'>Why would you mutilate this work of art?</span>")
	return

/obj/item/ammo_box/magazine/internal/shot/contender
	name = "contender internal magazine"
	caliber = "all"
	ammo_type = /obj/item/ammo_casing
	start_empty = TRUE
	max_ammo = 2
	multiload = 0 // thou must load every shot individually

//Box gun - the shitty contender. Adapted from a rejected hippie pr.
/obj/item/gun/ballistic/revolver/doublebarrel/contender/box_gun
	name = "box gun"
	desc = "Assistant's favourite. The huge space inside the box means it can use any ammo available. Doesn't look very safe."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "box_gun"
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/contender/box_gun
	recoil = 3
	fire_delay = 5
	var/explodioprob = 33

/obj/item/gun/ballistic/revolver/doublebarrel/contender/box_gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(istype(user) && prob(explodioprob))
		var/obj/item/bodypart/l_arm = user.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/r_arm = user.get_bodypart(BODY_ZONE_R_ARM)
		user.visible_message("<span class='warning'>\The [src] explodes in [user]'s hand!</span>", "<span class='warning'>\The [src] explodes in your hand!</span>")
		explosion(user, 0, 0, 0, 1)
		if(prob(50) && (l_arm != null ))
			l_arm.dismember()
		else
			r_arm.dismember()
		qdel(src)

/obj/item/ammo_box/magazine/internal/shot/contender/box_gun
	name = "box gun internal magazine"
	caliber = "all"
	ammo_type = /obj/item/ammo_casing
	max_ammo = 1
