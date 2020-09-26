/*
* LOW WALLS
*/
/obj/structure/table/low_wall
	name = "low wall"
	desc = "A low wall, not made by famous band Pink Floyd."
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/glow_wall.dmi'
	icon_state = "low_wall"
	density = TRUE
	anchored = TRUE
	flags_1 = CONDUCT_1
	pressure_resistance = 5*ONE_ATMOSPHERE
	layer = BELOW_OBJ_LAYER
	armor = list("melee" = 50, "bullet" = 70, "laser" = 70, "energy" = 100, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	max_integrity = 50
	integrity_failure = 0.4
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	frame = null
	buildstackamount = 3
	plane = WALL_PLANE
	layer =	LOW_WALL_LAYER
	canSmoothWith = list(
	/obj/structure/window/fulltile,
	/obj/structure/window/reinforced/fulltile,
	/obj/structure/window/reinforced/tinted/fulltile,
	/obj/structure/window/plasma/fulltile,
	/obj/structure/window/plasma/reinforced/fulltile,
	/obj/structure/window/shuttle,
	/obj/structure/window/plastitanium/fulltile,
	/obj/structure/falsewall,
	/obj/structure/falsewall/brass,
	/obj/structure/falsewall/reinforced,
	/turf/closed/wall,
	/turf/closed/wall/r_wall,
	/turf/closed/wall/rust,
	/turf/closed/wall/r_wall/rust,
	/turf/closed/wall/clockwork,
	)
	var/low_type = /obj/structure/table/low_wall
	var/mutable_appearance/mutable_overlay

/obj/structure/table/low_wall/metal
	name = "metal low wall"
	icon = 'modular_skyrat/icons/eris/obj/smooth_structures/low_wall.dmi'
	icon_state = "low_wall"
	low_type = /obj/structure/table/low_wall/metal

/obj/structure/table/low_wall/metal/reinforced
	name = "reinforced metal low wall"
	buildstackamount = 5
	max_integrity = 85
	low_type = /obj/structure/table/low_wall/metal/reinforced

/obj/structure/table/low_wall/titanium
	name = "titanium low wall"
	buildstackamount = 4
	max_integrity = 100
	color = "#c7c7c7"
	low_type = /obj/structure/table/low_wall/titanium

/obj/structure/table/low_wall/plastitanium
	name = "plastitanium low wall"
	buildstackamount = 4
	max_integrity = 120
	color = "#555555"
	low_type = /obj/structure/table/low_wall/plastitanium

/obj/structure/table/low_wall/Initialize(mapload, direct)
	. = ..()
	if(length(canSmoothWith))
		canSmoothWith |= (typesof(/obj/machinery/door) - typesof(/obj/machinery/door/window) - typesof(/obj/machinery/door/firedoor) - typesof(/obj/machinery/door/poddoor))
		canSmoothWith |= typesof(/turf/closed/wall)
		canSmoothWith |= typesof(/obj/structure/falsewall)
		canSmoothWith |= typesof(/turf/closed/indestructible/riveted)
		canSmoothWith |= typesof(/obj/structure/table/low_wall)
	update_overlays()

/obj/structure/table/low_wall/proc/calculate_wall_adjacencies()
	var/adjacencies = 0

	var/atom/A = src
	var/atom/movable/AM
	if(ismovable(src))
		AM = src
		if(AM.can_be_unanchored && !AM.anchored)
			return 0

	for(var/direction in GLOB.cardinals)
		AM = find_type_in_direction(A, direction, /turf/closed/wall)
		if(AM == NULLTURF_BORDER)
			if((A.smooth & SMOOTH_BORDER))
				adjacencies |= 1 << direction
		else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
			adjacencies |= 1 << direction

	if(adjacencies & N_NORTH)
		if(adjacencies & N_WEST)
			AM = find_type_in_direction(A, NORTHWEST, /turf/closed/wall)
			if(AM == NULLTURF_BORDER)
				if((A.smooth & SMOOTH_BORDER))
					adjacencies |= N_NORTHWEST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_NORTHWEST
		if(adjacencies & N_EAST)
			AM = find_type_in_direction(A, NORTHEAST)
			if(AM == NULLTURF_BORDER)
				if((A.smooth & SMOOTH_BORDER))
					adjacencies |= N_NORTHEAST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_NORTHEAST

	if(adjacencies & N_SOUTH)
		if(adjacencies & N_WEST)
			AM = find_type_in_direction(A, SOUTHWEST, /turf/closed/wall)
			if(AM == NULLTURF_BORDER)
				if((A.smooth & SMOOTH_BORDER))
					adjacencies |= N_SOUTHWEST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_SOUTHWEST
		if(adjacencies & N_EAST)
			AM = find_type_in_direction(A, SOUTHEAST)
			if(AM == NULLTURF_BORDER)
				if((A.smooth & SMOOTH_BORDER))
					adjacencies |= N_SOUTHEAST
			else if( (AM && !istype(AM)) || (istype(AM) && AM.anchored) )
				adjacencies |= N_SOUTHEAST

	return adjacencies

/obj/structure/table/low_wall/proc/smooth_walls()
	. = list()
	//NW CORNER
	var/adjacencies = calculate_wall_adjacencies()
	var/nw = "1-i"
	if((adjacencies & N_NORTH) && (adjacencies & N_WEST))
		if(adjacencies & N_NORTHWEST)
			nw = "1-f"
		else
			nw = "1-nw"
	else
		if(adjacencies & N_NORTH)
			nw = "1-n"
		else if(adjacencies & N_WEST)
			nw = "1-w"

	//NE CORNER
	var/ne = "2-i"
	if((adjacencies & N_NORTH) && (adjacencies & N_EAST))
		if(adjacencies & N_NORTHEAST)
			ne = "2-f"
		else
			ne = "2-ne"
	else
		if(adjacencies & N_NORTH)
			ne = "2-n"
		else if(adjacencies & N_EAST)
			ne = "2-e"

	//SW CORNER
	var/sw = "3-i"
	if((adjacencies & N_SOUTH) && (adjacencies & N_WEST))
		if(adjacencies & N_SOUTHWEST)
			sw = "3-f"
		else
			sw = "3-sw"
	else
		if(adjacencies & N_SOUTH)
			sw = "3-s"
		else if(adjacencies & N_WEST)
			sw = "3-w"

	//SE CORNER
	var/se = "4-i"
	if((adjacencies & N_SOUTH) && (adjacencies & N_EAST))
		if(adjacencies & N_SOUTHEAST)
			se = "4-f"
		else
			se = "4-se"
	else
		if(adjacencies & N_SOUTH)
			se = "4-s"
		else if(adjacencies & N_EAST)
			se = "4-e"
	. |= list(nw, ne, sw, se)

//low walls have to create a brim, based on the high walls connected around them
/obj/structure/table/low_wall/update_overlays()
	. = ..()
	if(mutable_overlay)
		cut_overlay(mutable_overlay)
	mutable_overlay = mutable_appearance(icon, "metal_over", ABOVE_WALL_WINDOW_LAYER, plane, color)
	//Make the wall overlays
	for(var/i in smooth_walls())
		mutable_overlay.add_overlay("metal_over_[i]")
	add_overlay(mutable_overlay)
	for(var/obj/structure/window/W in loc)
		W.update_overlays()

/obj/structure/table/low_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 20, "cost" = 5)
		if(RCD_WINDOWGRILLE)
			if(the_rcd.window_type == /obj/structure/window/reinforced/fulltile)
				return list("mode" = RCD_WINDOWGRILLE, "delay" = 40, "cost" = 12)
			else
				return list("mode" = RCD_WINDOWGRILLE, "delay" = 20, "cost" = 8)
	return FALSE

/obj/structure/table/low_wall/rcd_act(mob/user, var/obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, "<span class='notice'>You deconstruct \the [src].</span>")
			qdel(src)
			return TRUE
		if(RCD_WINDOWGRILLE)
			if(locate(/obj/structure/window) in loc)
				return FALSE
			to_chat(user, "<span class='notice'>You construct the window.</span>")
			var/obj/structure/window/WD = new the_rcd.window_type(drop_location())
			WD.setAnchored(TRUE)
			return TRUE
	return FALSE

/obj/structure/table/low_wall/Bumped(atom/movable/AM)
	if(!ismob(AM))
		return
	var/mob/M = AM
	shock(M, 70)

/obj/structure/table/low_wall/attack_animal(mob/user)
	. = ..()
	if(!shock(user, 70) && !QDELETED(src)) //Last hit still shocks but shouldn't deal damage to the low wall
		take_damage(rand(5,10), BRUTE, "melee", 1)

/obj/structure/table/low_wall/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/table/low_wall/hulk_damage()
	return 60

/obj/structure/table/low_wall/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)
	if(user.a_intent == INTENT_HARM)
		if(!shock(user, 70))
			..(user, 1)
		return TRUE

/obj/structure/table/low_wall/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src, ATTACK_EFFECT_KICK)
	user.visible_message("<span class='warning'>[user] hits [src].</span>", null, null, COMBAT_MESSAGE_RANGE)
	log_combat(user, src, "hit")
	if(!shock(user, 70))
		take_damage(rand(5,10), BRUTE, "melee", 1)

/obj/structure/table/low_wall/attack_alien(mob/living/user)
	user.do_attack_animation(src)
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message("<span class='warning'>[user] mangles [src].</span>", null, null, COMBAT_MESSAGE_RANGE)
	if(!shock(user, 70))
		take_damage(20, BRUTE, "melee", 1)

/obj/structure/table/low_wall/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return TRUE
	else
		if(istype(mover, /obj/item/projectile) && density)
			return prob(60)
		else
			return !density

/obj/structure/table/low_wall/CanAStarPass(ID, dir, caller)
	. = !density
	if(ismovable(caller))
		var/atom/movable/mover = caller
		. = . || (mover.pass_flags & PASSTABLE)

/obj/structure/table/low_wall/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(istype(W, /obj/item/wrench))
		if(!shock(user, 100) && do_after(user, 20, 1, src))
			W.play_tool_sound(src, 100)
			deconstruct()
	else if((istype(W, /obj/item/screwdriver)) && (isturf(loc) || anchored))
		if(!shock(user, 90))
			W.play_tool_sound(src, 100)
			setAnchored(!anchored)
			user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] [src].</span>", \
								 "<span class='notice'>You [anchored ? "fasten [src] to" : "unfasten [src] from"] the floor.</span>")
			return
	else if(istype(W, buildstack) && broken)
		var/obj/item/stack/R = W
		if(!shock(user, 90) && R.use(buildstackamount))
			user.visible_message("<span class='notice'>[user] rebuilds the broken low wall.</span>", \
								 "<span class='notice'>You rebuild the broken low wall.</span>")
			new low_type(loc)
			qdel(src)
			return

//window placing begin
	else if(is_glass_sheet(W))
		if (!broken)
			var/obj/item/stack/ST = W
			if (ST.get_amount() < 2)
				to_chat(user, "<span class='warning'>You need at least two sheets of glass for that!</span>")
				return
			var/dir_to_set = SOUTHWEST
			if(!anchored)
				to_chat(user, "<span class='warning'>[src] needs to be fastened to the floor first!</span>")
				return
			for(var/obj/structure/window/WINDOW in loc)
				to_chat(user, "<span class='warning'>There is already a window there!</span>")
				return
			to_chat(user, "<span class='notice'>You start placing the window...</span>")
			if(do_after(user,20, target = src))
				if(!src.loc || !anchored) //Low wall broken or unanchored while waiting
					return
				for(var/obj/structure/window/WINDOW in loc) //Another window already installed on low wall
					return
				var/obj/structure/window/WD
				if(istype(W, /obj/item/stack/sheet/plasmarglass))
					WD = new/obj/structure/window/plasma/reinforced/fulltile(drop_location()) //reinforced plasma window
				else if(istype(W, /obj/item/stack/sheet/plasmaglass))
					WD = new/obj/structure/window/plasma/fulltile(drop_location()) //plasma window
				else if(istype(W, /obj/item/stack/sheet/rglass))
					WD = new/obj/structure/window/reinforced/fulltile(drop_location()) //reinforced window
				else if(istype(W, /obj/item/stack/sheet/titaniumglass))
					WD = new/obj/structure/window/shuttle(drop_location())
				else if(istype(W, /obj/item/stack/sheet/plastitaniumglass))
					WD = new/obj/structure/window/plastitanium(drop_location())
				else
					WD = new/obj/structure/window/fulltile(drop_location()) //normal window
				WD.setDir(dir_to_set)
				WD.ini_dir = dir_to_set
				WD.setAnchored(FALSE)
				WD.state = 0
				ST.use(2)
				to_chat(user, "<span class='notice'>You place [WD] on [src].</span>")
			return
//window placing end

	else if(istype(W, /obj/item/shard) || !shock(user, 70))
		return ..()

/obj/structure/table/low_wall/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/grillehit.ogg', 80, 1)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, 1)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 80, 1)

/obj/structure/table/low_wall/deconstruct(disassembled = TRUE)
	if(!loc) //if already qdel'd somehow, we do nothing
		return
	if(!(flags_1&NODECONSTRUCT_1))
		var/obj/R = new buildstack(drop_location(), buildstackamount)
		transfer_fingerprints_to(R)
		qdel(src)
	..()

/obj/structure/table/low_wall/do_climb(atom/movable/A)
	. = ..()
	if(ismob(A))
		//climbing on electrified low wall will fry your ass
		shock(A, 100)
		if(prob(50))
			shock(A, 100)
		if(prob(50))
			shock(A, 100)

// shock user with probability prb (if all connections & power are working)
// returns 1 if shocked, 0 otherwise

/obj/structure/table/low_wall/proc/shock(mob/user, prb)
	if(!anchored || broken)		// anchored/broken low walls are never connected
		return FALSE
	if(!prob(prb))
		return FALSE
	if(!in_range(src, user))//To prevent TK and mech users from getting shocked
		return FALSE
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src, 1, TRUE))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			return TRUE
		else
			return FALSE
	return FALSE

/obj/structure/table/low_wall/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(!broken)
		if(exposed_temperature > T0C + 1500)
			take_damage(1, BURN, 0, 0)
	..()

/obj/structure/table/low_wall/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(isobj(AM))
		if(prob(10) && anchored && !broken)
			var/obj/O = AM
			if(O.throwforce != 0 && O.damtype != STAMINA)//don't want to let people spam tesla bolts, this way it will break after time
				var/turf/T = get_turf(src)
				var/obj/structure/cable/C = T.get_cable_node()
				if(C)
					playsound(src, 'sound/magic/lightningshock.ogg', 100, 1, extrarange = 5)
					tesla_zap(src, 3, C.newavail() * 0.01, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_ALLOW_DUPLICATES) //Zap for 1/100 of the amount of power. At a million watts in the grid, it will be as powerful as a tesla revolver shot.
					C.add_delayedload(C.newavail() * 0.0375) // you can gain up to 3.5 via the 4x upgrades power is halved by the pole so thats 2x then 1X then .5X for 3.5x the 3 bounces shock.
	return ..()

/obj/structure/table/low_wall/get_dumping_location(datum/component/storage/source,mob/user)
	return null
