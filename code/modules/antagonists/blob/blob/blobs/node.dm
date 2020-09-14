/obj/structure/blob/node
	name = "blob node"
	icon = 'icons/mob/blob.dmi'
	icon_state = "blank_blob"
	desc = "A large, pulsating yellow mass."
	max_integrity = 150	// Skyrat Edit: 200 to 150.
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 65, "acid" = 90)
	health_regen = 3
	point_return = 25


/obj/structure/blob/node/Initialize()
	GLOB.blob_nodes += src
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/blob/node/scannerreport()
	return "Gradually expands and sustains nearby blob spores and blobbernauts."

/obj/structure/blob/node/update_icon()
	cut_overlays()
	color = null
	var/mutable_appearance/blob_overlay = mutable_appearance('icons/mob/blob.dmi', "blob")
	if(overmind)
		blob_overlay.color = overmind.blobstrain.color
	add_overlay(blob_overlay)
	add_overlay(mutable_appearance('icons/mob/blob.dmi', "blob_node_overlay"))

/obj/structure/blob/node/Destroy()
	GLOB.blob_nodes -= src
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/blob/node/process()
	if(overmind)
		Pulse_Area(overmind, 10, 3, 2)
	// SKYRAT EDIT START - BLOB
	for(var/obj/structure/blob/normal/B in range(1, src))
		if(prob(0.1))
			B.change_to(/obj/structure/blob/shield/core, overmind)
	// SKYRAT EDIT END - Probability to make blob around a node from 0% to 0.1%. It was once 5%, and this was rolled so frequently it resulted in constant upgrades.
