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
