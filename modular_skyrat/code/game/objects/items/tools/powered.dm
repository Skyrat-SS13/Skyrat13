/obj/item/crowbar/robopower //Yes yes, I know, copypasta, but this was the easiest way to do it that wouldn't involve changing an absolute metric fuckton of file pathways to make it a subtype.
	name = "claws of life"
	desc = "A set of jaws of life made for more general use, lacking enough power to pry airlocks. It's fitted with a prying head."
	icon = 'modular_skyrat/icons/obj/robotics_powertools.dmi'
	icon_state = "robojaws_pry"
	item_state = "jawsoflife"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_righthand.dmi'
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25)

	usesound = 'sound/items/jaws_pry.ogg'
	force = 15
	toolspeed = 0.25

/obj/item/crowbar/robopower/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is putting [user.p_their()] head in [src], it looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/items/jaws_pry.ogg', 50, 1, -1)
	return (BRUTELOSS)

/obj/item/crowbar/robopower/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, 1)
	var/obj/item/wirecutters/robopower/cutjaws = new /obj/item/wirecutters/robopower(drop_location())
	cutjaws.name = name
	to_chat(user, "<span class='notice'>You attach the cutting jaws to [src].</span>")
	qdel(src)
	user.put_in_active_hand(cutjaws)

/obj/item/wirecutters/robopower
	name = "claws of life"
	icon = 'modular_skyrat/icons/obj/robotics_powertools.dmi'
	desc = "A set of jaws of life made for more general use, lacking enough power to pry airlocks. It's fitted with a cutting head."
	icon_state = "robojaws_cutter"
	item_state = "jawsoflife"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_righthand.dmi'

	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25)
	usesound = 'sound/items/jaws_cut.ogg'
	toolspeed = 0.25
	random_color = FALSE

/obj/item/wirecutters/robopower/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is wrapping \the [src] around [user.p_their()] neck. It looks like [user.p_theyre()] trying to rip [user.p_their()] head off!</span>")
	playsound(loc, 'sound/items/jaws_cut.ogg', 50, 1, -1)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/obj/item/bodypart/BP = C.get_bodypart(BODY_ZONE_HEAD)
		if(BP)
			BP.drop_limb()
			playsound(loc,pick('sound/misc/desceration-01.ogg','sound/misc/desceration-02.ogg','sound/misc/desceration-01.ogg') ,50, 1, -1)
	return (BRUTELOSS)

/obj/item/wirecutters/robopower/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, 1)
	var/obj/item/crowbar/robopower/pryjaws = new /obj/item/crowbar/robopower(drop_location())
	pryjaws.name = name
	to_chat(user, "<span class='notice'>You attach the pry jaws to [src].</span>")
	qdel(src)
	user.put_in_active_hand(pryjaws)

/obj/item/wirecutters/robopower/attack(mob/living/carbon/C, mob/user)
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
	..() //END OF COPYPASTA

/obj/item/screwdriver/power/robotics
	icon = 'modular_skyrat/icons/obj/robotics_powertools.dmi'
	icon_state = "robodrill_screw"
	item_state = "drill"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_righthand.dmi'

/obj/item/screwdriver/power/robotics/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg',50,1)
	var/obj/item/wrench/power/b_drill = new /obj/item/wrench/power/robotics(drop_location())
	to_chat(user, "<span class='notice'>You attach the bolt driver bit to [src].</span>")
	qdel(src)
	user.put_in_active_hand(b_drill)

/obj/item/wrench/power/robotics
	icon = 'modular_skyrat/icons/obj/robotics_powertools.dmi'
	icon_state = "robodrill_bolt"
	item_state = "drill"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/robotics_powertools_righthand.dmi'

/obj/item/wrench/power/attack_self(mob/user)
	playsound(get_turf(user),'sound/items/change_drill.ogg',50,1)
	var/obj/item/wirecutters/power/s_drill = new /obj/item/screwdriver/power/robotics(drop_location())
	to_chat(user, "<span class='notice'>You attach the screw driver bit to [src].</span>")
	qdel(src)
	user.put_in_active_hand(s_drill)
