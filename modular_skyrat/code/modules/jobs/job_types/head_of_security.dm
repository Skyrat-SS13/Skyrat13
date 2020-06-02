/datum/job/hos/radio_help_message(mob/M)
	to_chat(M, "<span class='warning'>Do not forget the prisoners. Interact with them occasionally.</span>")

/datum/outfit/job/hos
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1,
							/obj/item/gun/ballistic/automatic/pistol/uspm = 1,
							/obj/item/ammo_box/magazine/usp = 1)
