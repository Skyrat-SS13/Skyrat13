//detective revomlver changes
/obj/item/gun/ballistic/revolver/detective
	desc = "Although far surpassed by newer firearms, this revolver is still quite effective and popular as a self defense weapon, and as an oldschool styled sidearm for military contractors. Chambering .357 in it however, is not recommended."

//Contender, made by ArcLumin. Ported from hippie.
/obj/item/gun/ballistic/revolver/doublebarrel/contender
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

/obj/item/gun/ballistic/revolver/doublebarrel/contender/sawoff(mob/user)
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
	var/explodioprob = 50
	var/list/blacklist = list("40mm", ".50")

/obj/item/gun/ballistic/revolver/doublebarrel/contender/box_gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if((istype(user) && prob(explodioprob)) || (blacklist.Find(chambered.caliber)))
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



//
///////////////
// REVOLVERS //
///////////////
//		Revolving rifles! We have three versions. An improvised slower firing one, a normal one, and a golden premium one that fires .45 instead of .38
//		The gold rifle uses .45, it's only 5 more points of damage unfortunately. Fun hint: A box of .45 bullets functions the same as a speedloader.
//

/obj/item/gun/ballistic/revolver/rifle
	name = "\improper .38 Revolving Rifle"
	desc = "A revolving rifle chambered in .38. "
	icon = 'modular_skyrat/icons/obj/guns/projectile40x32.dmi'
	icon_state = "revolving-rifle"
	item_state = "revolving"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38	//This is just a detective's revolver but it's too big for bags..
	pixel_x = -4	// It's centred on a 40x32 pixel spritesheet.
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY // The entire purpose of this is that it's a bulky rifle instead of a revolver.
	slot_flags = ITEM_SLOT_BELT
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/64x_guns_right.dmi'
	pixel_x = -4

/obj/item/gun/ballistic/revolver/rifle/improvised
	name = "\improper Improvised .38 Revolving Rifle"
	desc = "A crudely made revolving rifle. It fires .38 rounds. The cylinder doesn't rotate very well."
	icon_state = "revolving-rifle"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38	//As far as improvised weapons go, this is fairly decent, this isn't half bad.
	fire_delay = 15
	recoil = 1

/obj/item/gun/ballistic/revolver/rifle/gold
	name = "\improper .45 Revolving Rifle"
	desc = "A gold trimmed revolving rifle! It fires .45 bullets."
	icon_state = "revolving-rifle-gold"
	item_state = "revolving_gold"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45	//Gold! We're using .45 because TG's 10mm does 40 damage, this does 30.
	w_class = WEIGHT_CLASS_BULKY

// .45 Cylinder

/obj/item/ammo_box/magazine/internal/cylinder/rev45
	name = "revolver .45 cylinder"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = list(".45")
	max_ammo = 6

//
///////////////
// REVOLVERS //
///////////////
//
