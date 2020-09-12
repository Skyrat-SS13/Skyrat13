/obj/item/implant/radio
	name = "internal radio implant"
	activated = TRUE
	var/obj/item/radio/internal/radio
	var/radio_key
	var/subspace_transmission = FALSE
	icon = 'icons/obj/radio.dmi'
	icon_state = "walkietalkie"

/obj/item/implant/radio/activate()
	. = ..()
	// needs to be GLOB.deep_inventory_state otherwise it won't open
	radio.ui_interact(usr, "main", null, FALSE, null, GLOB.deep_inventory_state)

/obj/item/implant/radio/implant(mob/living/target, mob/user, silent = FALSE)
	. = ..()
	if(!.)
		return
	if(radio)
		radio.forceMove(target)
		return
	radio = new(target)
	// almost like an internal headset, but without the
	// "must be in ears to hear" restriction.
	radio.name = "internal radio"
	radio.subspace_transmission = subspace_transmission
	radio.canhear_range = -1
	if(radio_key)
		radio.keyslot = new radio_key
	radio.recalculateChannels()

/obj/item/implant/radio/removed(mob/target, silent = FALSE, special = 0)
	. = ..()
	if(!.)
		return
	if(!special)
		qdel(radio)
	else
		radio?.moveToNullspace()

/obj/item/implant/radio/mining
	radio_key = /obj/item/encryptionkey/headset_cargo

/obj/item/implant/radio/syndicate
	desc = "Are you there God? It's me, Syndicate Comms Agent."
	radio_key = /obj/item/encryptionkey/syndicate
	subspace_transmission = TRUE

/obj/item/implant/radio/slime
	name = "slime radio"
	icon = 'icons/obj/surgery.dmi'
	icon_state = "adamantine_resonator"
	radio_key = /obj/item/encryptionkey/headset_sci
	subspace_transmission = TRUE

/obj/item/implant/radio/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Internal Radio Implant<BR>
				<b>Life:</b> 24 hours<BR>
				<b>Implant Details:</b> Allows user to use an internal radio, useful if user expects equipment loss, or cannot equip conventional radios."}
	return dat

/obj/item/implanter/radio
	name = "implanter (internal radio)"
	imp_type = /obj/item/implant/radio

/obj/item/implanter/radio/syndicate
	name = "implanter (internal syndicate radio)"
	imp_type = /obj/item/implant/radio/syndicate

/obj/item/implant/radio/syndicate/selfdestruct
	name = "hacked internal radio implant"

/obj/item/implant/radio/syndicate/selfdestruct/on_implanted(mob/living/user)
	if(!user.mind.has_antag_datum(/datum/antagonist/incursion))
		user.visible_message("<span class='warning'>[imp_in] starts beeping ominously!</span>", "<span class='userdanger'>You have a sudden feeling of dread. The implant is rigged to explode!</span>")
		playsound(user, 'sound/items/timer.ogg', 30, 0)
		sleep(50)
		playsound(user, 'sound/items/timer.ogg', 30, 0)
		sleep(40)
		playsound(user, 'sound/items/timer.ogg', 30, 0)
		sleep(30)
		playsound(user, 'sound/items/timer.ogg', 30, 0)
		sleep(20)
		playsound(user, 'sound/items/timer.ogg', 30, 0)
		sleep(10)
		playsound(user, 'sound/items/timer.ogg', 30, 0)
		user.gib(1)
		explosion(src,0,0,3,2, flame_range = 2)
		qdel(src)

obj/item/implanter/radio/syndicate/selfdestruct
	name = "implanter (modified internal syndicate radio)"
	imp_type = /obj/item/implant/radio/syndicate/selfdestruct