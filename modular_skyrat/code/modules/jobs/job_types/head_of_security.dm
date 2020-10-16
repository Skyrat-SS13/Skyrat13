/datum/job/hos/radio_help_message(mob/M)
	to_chat(M, "<span class='warning'>Do not forget the prisoners. Interact with them occasionally.</span>")

/datum/outfit/job/hos
	backpack_contents = list(/obj/item/pda/heads/hos=1,
							/obj/item/melee/mace=1,
							/obj/item/gun/ballistic/automatic/pistol/nangler=1,
							/obj/item/ammo_box/magazine/nangler=1)
	belt = /obj/item/storage/belt/sabre/hos
