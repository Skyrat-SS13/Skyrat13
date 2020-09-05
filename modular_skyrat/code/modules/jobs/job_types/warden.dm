/datum/outfit/job/warden
	backpack_contents = list(/obj/item/melee/baton/loaded=1, /obj/item/ammo_box/shotgun/loaded/rubbershot=1, /obj/item/choice_beacon/warden=1)
	suit_store = null

/datum/job/warden/radio_help_message(mob/M)
	to_chat(M, "<span class='warning'>Do not forget the prisoners. Interact with them occasionally.</span>")
	to_chat(M, "<span class='warning'>Being on the frontiers means that prisoners will not be looked after with a high degree of scrutiny and can be utilized for many things such as free labor where needed. This does not mean you are allowed to torture them without OOC consent.</span>")
	to_chat(M, "<span class='warning'>We may control the prison, however, you cannot do it alone. Security officers are there to help keep the prisoners in line. Use them to provide activities for the prisoners to keep them content.</span>")

/obj/item/choice_beacon/warden
	name = "warden's shotgun beacon"
	desc = "A beacon, allowing the warden to select between two available models of personal shotguns."

/obj/item/choice_beacon/warden/generate_display_names()
	var/static/list/shotties
	if(!shotties)
		shotties = list()
		shotties["Compact Combat Shotgun"] = /obj/item/gun/ballistic/shotgun/automatic/combat/compact/warden
		shotties["Particle Defender"] = /obj/item/gun/energy/pumpaction/defender
	return shotties
