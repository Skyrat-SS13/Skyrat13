/datum/job/officer/radio_help_message(mob/M)
	to_chat(M, "<span class='warning'>Do not forget the prisoners. Interact with them occasionally.</span>")
	to_chat(M, "<span class='warning'>We are on the frontiers, so many things can be done to the prisoners without public note. However, do not torture them without OOC permission.</span>")

/datum/outfit/job/security
	backpack_contents = list(/obj/item/melee/baton/loaded=1,
							/obj/item/gun/ballistic/automatic/pistol/uspm = 1,
							/obj/item/ammo_box/magazine/usp = 1)
