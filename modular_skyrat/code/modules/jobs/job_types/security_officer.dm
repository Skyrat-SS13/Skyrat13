/datum/job/officer/radio_help_message(mob/M)
	to_chat(M, "<span class='warning'>Do not forget the prisoners. Interact with them occasionally.</span>")
	to_chat(M, "<span class='warning'>Being on the frontiers means that prisoners will not be looked after with a high degree of scrutiny and can be utilized for many things such as free labor where needed. This does not mean you are allowed to torture them without OOC consent.</span>")

/datum/outfit/job/security
	backpack_contents = list(/obj/item/melee/baton/loaded=1,
							/obj/item/gun/ballistic/automatic/pistol/uspm = 1,
							/obj/item/ammo_box/magazine/usp = 1)
