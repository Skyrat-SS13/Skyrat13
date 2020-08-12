// Engineering Power Drill Resprite

/obj/item/screwdriver/power
	name = "power drill"
	icon = 'modular_skyrat/icons/obj/tools.dmi'
/obj/item/screwdriver/power/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "drill")

/obj/item/wrench/power
	name = "power drill"
	icon = 'modular_skyrat/icons/obj/tools.dmi'
/obj/item/wrench/power/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "drill")

// Green Power Drill (For Non-Engineers; it's a reskin)

/obj/item/screwdriver/power/green
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	icon_state = "gdrill_screw"
	item_state = "drill"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
/obj/item/screwdriver/power/green/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "green_drill")

/obj/item/wrench/power/green
	icon_state = "gdrill_bolt"
	item_state = "drill"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
/obj/item/wrench/power/green/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "green_drill")

// Electric Screwdriver

/obj/item/screwdriver/electric
	name = "electric screwdriver"
	desc = "A small compact electric screwdriver. It's faster than a normal one, at least. There's no bolt attachment."
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	icon_state = "electric_screwdriver"
	item_state = "electric_drill"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron=100,/datum/material/silver=10,/datum/material/titanium=5)
	force = 7 // It's one less than the power ones.
	attack_verb = list("drilled", "screwed", "jabbed","whacked")
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.3
	random_color = FALSE
/obj/item/screwdriver/electric/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "electric_screwdriver")

// Jaws of Life Resprite

/obj/item/crowbar/power
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
/obj/item/crowbar/power/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "jaws_pry")

/obj/item/wirecutters/power
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
/obj/item/wirecutters/power/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "jaws_cutter")

// Electric Cutter

/obj/item/crowbar/electric
	name = "power cutter"
	desc = "A compact electric prying and cutting tool. It's fitted with a prying head."
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	icon_state = "pry"
	item_state = "old_jawsoflife"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron=100,/datum/material/titanium=5)
/obj/item/crowbar/power/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "old_jaws_pry")

/obj/item/wirecutters/electric
	name = "power cutter"
	desc = "A compact electric prying and cutting tool. It's fitted with a cutting head."
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "old_jawsoflife"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'
	random_color = FALSE
	custom_materials = list(/datum/material/iron=100,/datum/material/titanium=5)
/obj/item/wirecutters/power/get_belt_overlay()
	return mutable_appearance('modular_skyrat/icons/obj/clothing/belt_overlays.dmi', "old_jaws_cutter")

///////////////// This is less intrusive than changing the try to pry proc in airlocks.dm /////////////////
/obj/item/crowbar/electric/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, 1)
	var/obj/item/wirecutters/electric/cutjaws = new /obj/item/wirecutters/electric(drop_location())
	cutjaws.name = name // Skyrat fix
	to_chat(user, "<span class='notice'>You attach the cutting jaws to [src].</span>")
	qdel(src)
	user.put_in_active_hand(cutjaws)

/obj/item/wirecutters/electric/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, 1)
	var/obj/item/crowbar/electric/pryjaws = new /obj/item/crowbar/electric(drop_location())
	pryjaws.name = name // Skyrat fix
	to_chat(user, "<span class='notice'>You attach the pry jaws to [src].</span>")
	qdel(src)
	user.put_in_active_hand(pryjaws)

/obj/item/screwdriver/power/green/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg',50,1)
	var/obj/item/wrench/power/b_drill = new /obj/item/wrench/power/green(drop_location())
	b_drill.name = name // Skyrat fix
	to_chat(user, "<span class='notice'>You attach the bolt driver bit to [src].</span>")
	qdel(src)
	user.put_in_active_hand(b_drill)

/obj/item/wrench/power/green/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg',50,1)
	var/obj/item/screwdriver/power/green/s_drill = new /obj/item/screwdriver/power/green(drop_location())
	s_drill.name = name // Skyrat fix
	to_chat(user, "<span class='notice'>You attach the screw driver bit to [src].</span>")
	qdel(src)
	user.put_in_active_hand(s_drill)

/obj/item/wirecutters/electric/attack(mob/living/carbon/C, mob/user)
	if(istype(C))
		if(C.handcuffed)
			user.visible_message("<span class='notice'>[user] cuts [C]'s restraints with [src]!</span>")
			qdel(C.handcuffed)
			return
		else if(C.has_status_effect(STATUS_EFFECT_CHOKINGSTRAND))
			var/man = C == user ? "your" : "[C]'\s"
			user.visible_message("<span class='notice'>[user] attempts to remove the durathread strand from around [man] neck.</span>", \
								"<span class='notice'>You attempt to remove the durathread strand from around [man] neck.</span>")
			if(do_after(user, 15, null, C))
				user.visible_message("<span class='notice'>[user] succesfuly removes the durathread strand.</span>",
									"<span class='notice'>You succesfuly remove the durathread strand.</span>")
				C.remove_status_effect(STATUS_EFFECT_CHOKINGSTRAND)
			return
	..()
///////////////// This is less intrusive than changing the try to pry proc in airlocks.dm /////////////////
