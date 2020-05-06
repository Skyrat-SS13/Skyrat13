/obj/vehicle/ridden/forklift
	name = "Forklift"
	desc = "Ripleys are for wussies. Real cargonians drive forklifts."
	icon = 'modular_skyrat/icons/obj/vehicles.dmi'
	icon_state = "forklift"
	armor = list("melee" = 50, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 75, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 75)
	movedelay = 5
	key_type = /obj/item/key/forklift
	var/mutable_appearance/overlay
	var/mutable_appearance/underlay
	var/mutable_appearance/liftedoverlay
	var/mutable_appearance/liftedunderlay
	var/lifting = FALSE //used when lifting stuff. basically impedes the forklift from doing anything until it fully lifts something.
	var/list/lifted = list() //A list of mobs or objects being lifted

/obj/item/key/forklift 
	name = "Forklift key"
	desc = "Can't use a forklift without it."

/obj/vehicle/ridden/forklift/Initialize(mapload)
	..()
	overlay = mutable_appearance('modular_skyrat/icons/obj/vehicles.dmi', "forkliftover", ABOVE_MOB_LAYER)
	overlays += overlay
	underlay = mutable_appearance('modular_skyrat/icons/obj/vehicles.dmi', "forkliftunder", BELOW_MOB_LAYER)
	underlays += underlay
	liftedoverlay = mutable_appearance(src.icon, null, ABOVE_MOB_LAYER)
	liftedunderlay = mutable_appearance(src.icon, null, BELOW_MOB_LAYER)
	layer = ABOVE_MOB_LAYER
	new /obj/item/key/forklift(get_turf(src))

/obj/item/card/forkliftoperator
	name = "Forklift license"
	desc = "Approved by the FDA! (Forklift Drivers Association)."
	icon = 'modular_skyrat/icons/obj/vehicles.dmi'
	icon_state = "forkliftlicense"

/obj/vehicle/ridden/forklift/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(I.type == /obj/item/card/forkliftoperator)
		if(!lifted.len && !lifting)
			lift()
		else if(lifted.len && !lifting)
			unlift()
	else if(istype(I, /obj/item/weldingtool))
		var/obj/item/weldingtool/W = I
		if(obj_integrity < max_integrity)
			if(W.use_tool(src, user, 30, volume=50, amount=2))
				obj_integrity = max(max_integrity, obj_integrity + 25)
				to_chat(user, "<span class='notice'>You fix some of the damage on \the [src].</span>")

/obj/vehicle/ridden/forklift/attack_hand(mob/living/user)
	. = ..()
	if(user in lifted)
		user.forceMove(get_step(src, src.dir))
		lifted -= user
		liftedoverlay = null 
		liftedunderlay = null
		var/list/liftedboys
		for(var/atom/movable/A in lifted)
			var/image/mut1 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = NORTH)
			mut1.pixel_y += 5
			var/image/mut2 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = WEST)
			mut2.pixel_x -= 13
			mut2.pixel_y += 5
			var/image/mut3 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = EAST)
			mut3.pixel_x += 13
			mut3.pixel_y += 5
			var/image/mut4 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = SOUTH)
			mut4.pixel_y += 5
			liftedboys += list(mut1, mut2, mut3, mut4)
		for(var/image/mut in liftedboys)
			if(mut.dir == (NORTH))
				liftedunderlay |= mut
			else
				liftedoverlay |= mut

/obj/vehicle/ridden/forklift/proc/lift()
	if(!lifting)
		var/list/canbelifted = list()
		for(var/atom/movable/A in get_step(src, src.dir))
			if(istype(A, /obj/item || /obj/vehicle || /obj/mecha) || isliving(A))
				canbelifted += A
		lifting = TRUE
		for(var/atom/movable/A in canbelifted)
			A.forceMove(src)
			lifted += A
			var/image/mut1 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = NORTH)
			mut1.pixel_y += 1
			var/image/mut2 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = WEST)
			mut2.pixel_x -= 13
			mut2.pixel_y += 1
			var/image/mut3 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = EAST)
			mut3.pixel_x += 13
			mut3.pixel_y += 1
			var/image/mut4 = image(icon = A.icon, loc = src,icon_state = A.icon_state, dir = SOUTH)
			var/icon/monky = icon(src.icon, null)
			monky |= (mut2 | mut3 | mut4)
			var/icon/monky2 = icon(src.icon, null)
			monky |= (mut1)
			mut4.pixel_y += 1
			liftedunderlay |= monky2
			liftedoverlay |= monky
		animate(overlay, pixel_y += 4, 40)
		animate(underlay, pixel_y += 4, 40)
		overlays += liftedoverlay
		animate(liftedoverlay, pixel_y += 4, 40)
		underlays += liftedunderlay
		animate(liftedunderlay, pixel_y += 4, 40)
		sleep(40)
		lifting = FALSE

/obj/vehicle/ridden/forklift/proc/unlift()
	if(!lifting)
		lifting = TRUE
		animate(overlay, pixel_y -= 4, 40)
		animate(underlay, pixel_y -= 4, 40)
		animate(liftedoverlay, pixel_y -= 4, 40)
		animate(liftedunderlay, pixel_y -= 4, 40)
		sleep(40)
		lifting = FALSE
		for(var/atom/movable/A in lifted)
			A.forceMove(get_step(src, src.dir))
			lifted -= A
		overlays -= liftedoverlay
		underlays -= liftedunderlay
		liftedoverlay = null 
		liftedunderlay = null
		liftedoverlay = mutable_appearance(src.icon, null, ABOVE_MOB_LAYER)
		liftedunderlay = mutable_appearance(src.icon, null, BELOW_MOB_LAYER)
		lifting = FALSE 
