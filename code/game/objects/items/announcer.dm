/obj/item/announcer
	name = "big red button"
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "bigred"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/announcer/ion
	desc = "Announces a fake ion storm."

/obj/item/announcer/ion/attack_self(mob/user)
	priority_announce("Ion storm detected near the station. Please check all AI-controlled equipment for errors.", "Anomaly Alert", 'sound/announcer/classic/ionstorm.ogg')
	message_admins("[key_name_admin(user)] made a fake ion storm announcement.")
	do_sparks(2, FALSE, src)
	qdel(src)

/obj/item/announcer/rodgod
	desc = "Announces a fake immovable rod."

/obj/item/announcer/rodgod/attack_self(mob/user)
	priority_announce("What the fuck was that?!", "General Alert")
	message_admins("[key_name_admin(user)] made a fake immovable rod announcement.")
	do_sparks(2, FALSE, src)
	qdel(src)

/obj/item/announcer/virus
	desc = "Announces a fake virus outbreak"

/obj/item/announcer/virus/attack_self(mob/user)
	priority_announce("Confirmed outbreak of level 7 viral biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", "outbreak7")
	message_admins("[key_name_admin(user)] made a fake virus announcement.")
	do_sparks(2, FALSE, src)
	qdel(src)

/obj/item/announcer/blob
	desc = "Announces a fake level 5 biohazard"

/obj/item/announcer/blob/attack_self(mob/user)
	priority_announce("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", "outbreak5")
	message_admins("[key_name_admin(user)] made a blob announcement.")
	do_sparks(2, FALSE, src)
	qdel(src)

/obj/item/announcer/meteor
	desc = "Announces a fake meteor storm."

/proc/fakemeteorannouncementstring()
	var/fakedirection = pick(1,4)
	switch(fakedirection)
		if(1)
			fakedirection = " towards the fore"
		if(2)
			fakedirection = " towards the aft"
		if(3)
			fakedirection = " towards starboard"
		if(4)
			fakedirection = " towards port"
	return "Meteors have been detected on a collision course with the station[fakedirection]. Estimated time until impact: [rand(100, 350)] seconds."

/obj/item/announcer/meteor/attack_self(mob/user)
	priority_announce(fakemeteorannouncementstring(), "Meteor Alert", 'sound/announcer/classic/meteors.ogg')
	message_admins("[key_name_admin(user)] made a fake meteor storm announcement.")
	do_sparks(2, FALSE, src)
	qdel(src)