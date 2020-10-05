//blood splattering, taken from hippiestation
/obj/effect/decal/cleanable/blood/hitsplatter
	name = "blood splatter"
	pass_flags = PASSTABLE | PASSGRILLE
	icon = 'modular_skyrat/icons/effects/blood.dmi'
	icon_state = "hitsplatter1"
	random_icon_states = list("hitsplatter1", "hitsplatter2", "hitsplatter3")
	var/turf/prev_loc
	var/mob/living/blood_source
	var/skip = FALSE //Skip creation of blood when destroyed?
	var/amount = 3

/obj/effect/decal/cleanable/blood/hitsplatter/Initialize(mapload, list/blood)
	. = ..()
	if(blood)
		blood_DNA = blood.Copy()
	prev_loc = loc //Just so we are sure prev_loc exists

/obj/effect/decal/cleanable/blood/hitsplatter/proc/GoTo(turf/T, var/range)
	for(var/i in 1 to range)
		step_towards(src,T)
		sleep(1)
		prev_loc = loc
		for(var/atom/A in get_turf(src))
			if(istype(A,/obj/item))
				var/obj/item/I = A
				I.add_blood_DNA(blood_DNA)
				amount--
			if(istype(A, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = A
				if(H.wear_suit)
					H.wear_suit.add_mob_blood(blood_source)
					H.update_inv_wear_suit()    //updates mob overlays to show the new blood (no refresh)
				if(H.w_uniform)
					H.w_uniform.add_mob_blood(blood_source)
					H.update_inv_w_uniform()    //updates mob overlays to show the new blood (no refresh)
				amount--
		if(!amount) // we used all the puff so we delete it.
			qdel(src)
			break
	qdel(src)

/obj/effect/decal/cleanable/blood/hitsplatter/Bump(atom/A)
	if(!length(A.blood_DNA))
		A.visible_message("<span class='danger'><b>[A] gets splattered in blood!</b></span>")
	A.add_blood_DNA(blood_DNA)
	if(istype(A, /turf/closed/wall) || istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
		var/good = TRUE
		if(istype(A, /obj/structure/window))
			var/obj/structure/window/windos = A
			if(!windos.fulltile)
				good = FALSE
		if(istype(prev_loc) && good) //var definition already checks for type
			loc = A
			skip = TRUE
			var/obj/effect/decal/cleanable/blood/splatter/B = new(prev_loc)
			B.transfer_blood_dna(blood_DNA)
			B.layer = A.layer + 1
			B.plane = A.plane
			//Adjust pixel offset to make splatters appear on the wall
			B.pixel_x = (dir == EAST ? 32 : (dir == WEST ? -32 : 0))
			B.pixel_y = (dir == NORTH ? 32 : (dir == SOUTH ? -32 : 0))
	A.update_overlays()
	A.update_icon()
	qdel(src)

/obj/effect/decal/cleanable/blood/hitsplatter/Destroy()
	if(istype(loc, /turf) && !skip)
		loc.add_blood_DNA(blood_DNA)
	return ..()
