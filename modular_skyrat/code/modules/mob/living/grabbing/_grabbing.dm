//Bobstation uses a different grabbing system
/atom/movable/proc/start_pulling(atom/movable/AM, state, force = move_force, supress_message = FALSE)
	if(QDELETED(AM))
		return FALSE
	if(!(AM.can_be_pulled(src, state, force)))
		return FALSE

	// If we're pulling something then drop what we're currently pulling and pull this instead.
	if(pulling)
		if(state == 0)
			stop_pulling()
			return FALSE
		// Are we trying to pull something we are already pulling? Then enter grab cycle and end.
		if(AM == pulling)
			setGrabState(state)
			if(istype(AM,/mob/living))
				var/mob/living/AMob = AM
				AMob.grabbedby(src)
			return TRUE
		stop_pulling()
	if(AM.pulledby)
		log_combat(AM, AM.pulledby, "pulled from", src)
		AM.pulledby.stop_pulling() //an object can't be pulled by two mobs at once.
	pulling = AM
	AM.pulledby = src
	setGrabState(state)
	if(ismob(AM))
		var/mob/M = AM
		log_combat(src, M, "grabbed", addition="passive grab")
		if(!supress_message)
			visible_message("<span class='warning'>[src] has pulled [M] passively!</span>")
	return TRUE

/atom/movable/proc/stop_pulling()
	if(!pulling)
		return
	pulling.pulledby = null
	var/mob/living/ex_pulled = pulling
	pulling = null
	setGrabState(GRAB_NOTGRABBING)
	if(isliving(ex_pulled))
		var/mob/living/L = ex_pulled
		L.update_mobility()// mob gets up if it was lyng down in a chokehold

/atom/movable/proc/Move_Pulled(atom/A)
	if(!pulling)
		return
	if(pulling.anchored || pulling.move_resist > move_force || !pulling.Adjacent(src))
		stop_pulling()
		return
	if(isliving(pulling))
		var/mob/living/L = pulling
		if(L.buckled && L.buckled.buckle_prevents_pull) //if they're buckled to something that disallows pulling, prevent it
			stop_pulling()
			return
	if(A == loc && pulling.density)
		return
	if(!Process_Spacemove(get_dir(pulling.loc, A)))
		return
	step(pulling, get_dir(pulling.loc, A))
	return TRUE

/atom/movable/proc/check_pulling()
	if(pulling)
		var/atom/movable/pullee = pulling
		if(pullee && get_dist(src, pullee) > 1)
			stop_pulling()
			return
		if(!isturf(loc))
			stop_pulling()
			return
		if(pullee && !isturf(pullee.loc) && pullee.loc != loc) //to be removed once all code that changes an object's loc uses forceMove().
			log_game("DEBUG:[src]'s pull on [pullee] wasn't broken despite [pullee] being in [pullee.loc]. Pull stopped manually.")
			stop_pulling()
			return
		if(pulling.anchored || pulling.move_resist > move_force)
			stop_pulling()
			return
	if(pulledby && moving_diagonally != FIRST_DIAG_STEP && get_dist(src, pulledby) > 1)		//separated from our puller and not in the middle of a diagonal move.
		pulledby.stop_pulling()

/atom/movable/proc/can_be_pulled(user, grab_state, force)
	if(src == user || !isturf(loc))
		return FALSE
	if(anchored || throwing)
		return FALSE
	if(force < (move_resist * MOVE_FORCE_PULL_RATIO))
		return FALSE
	return TRUE

/// Updates the grab state of the movable
/// This exists to act as a hook for behaviour
/atom/movable/proc/setGrabState(newstate)
	grab_state = newstate

/mob/living/proc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	if(user == anchored || !isturf(user.loc))
		return FALSE
	
	if(user == src)
		return attempt_self_grasp(user)
	
	if(user.a_intent == INTENT_HELP)
		return user.start_pulling(src, supress_message = supress_message)

	if(!(status_flags & CANPUSH) || HAS_TRAIT(src, TRAIT_PUSHIMMUNE))
		to_chat(user, "<span class='warning'>[src] can't be grabbed more aggressively!</span>")
		return FALSE

	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='notice'>You don't want to risk hurting [src]!</span>")
		return FALSE

	grippedby(user)

//proc to upgrade a simple pull into a more aggressive grab, or just grabbing really
/mob/living/proc/grippedby(mob/living/carbon/user, instant = FALSE)
	//Self-grabbing uses snowflake cringe code
	if(user == src)
		return user.attempt_self_grasp(user)
	//Need to be pulling to grip someone
	if((user.pulling != src) || (pulledby != user))
		if(!user.start_pulling(src, GRAB_PASSIVE, supress_message = TRUE))
			return FALSE

	//Can't grip with items in our hand
	if(user.get_active_held_item())
		return FALSE
	
	user.changeNext_move(CLICK_CD_GRABBING)
	playsound(src.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	sound_hint(user, src)
	var/obj/item/grab/graspy = new()
	if(!user.put_in_active_hand(graspy) || !graspy.try_grasp(src, null, user))
		visible_message("<span class='danger'>[user] fails to grab [src]!</span>", "<span class='userdanger'>[user] fails to grab you!</span>", ignored_mobs = user)
		to_chat(user, "<span class='danger'>You fail to grab [src]!</span>")
		qdel(graspy)
		return FALSE
	return TRUE

/mob/living/carbon/grippedby(mob/living/carbon/user, instant = FALSE)
	if(user == src)
		return user.attempt_self_grasp(user)
	if((user.pulling != src) || (pulledby != user))
		if(!user.start_pulling(src, GRAB_PASSIVE, supress_message = TRUE))
			return FALSE
	
	//Can't grip with items in our hand
	if(user.get_active_held_item())
		return FALSE
	var/obj/item/bodypart/grasped_part = get_bodypart(check_zone(user.zone_selected))
	user.changeNext_move(CLICK_CD_GRABBING)
	playsound(src.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	sound_hint(user, src)
	if(!grasped_part)
		to_chat(user, "<span class='danger'>You can't grasp a missing bodypart!</span>")
		return FALSE
	if(user.lying && !lying && (grasped_part.body_zone in list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND)))
		visible_message("<span class='danger'>[user] fails to grab [src][grasped_part ? " by [p_their()] [grasped_part.name]" : ""]!</span>", "<span class='userdanger'>[user] fails to grab you[grasped_part ? " by your [grasped_part.name]" : ""]!</span>", ignored_mobs = user)
		to_chat(user, "<span class='danger'>You fail to grab [src][grasped_part ? " by [p_their()] [grasped_part.name]" : ""]! It's too high for you to reach it!</span>")
		return FALSE
	var/obj/item/grab/graspy = new()
	if(!user.put_in_active_hand(graspy) || !graspy.try_grasp(src, grasped_part, user))
		visible_message("<span class='danger'>[user] fails to grab [src][grasped_part ? " by [p_their()] [grasped_part.name]" : ""]!</span>", "<span class='userdanger'>[user] fails to grab you[grasped_part ? " by your [grasped_part.name]" : ""]!</span>", ignored_mobs = user)
		to_chat(user, "<span class='danger'>You fail to grab [src][grasped_part ? " by [p_their()] [grasped_part.name]" : ""]!</span>")
		qdel(graspy)
		return FALSE
	return TRUE

//We can grab ourselves
/mob/living/proc/attempt_self_grasp(mob/living/carbon/attempted_grasper)
	return

/mob/living/carbon/attempt_self_grasp(mob/living/carbon/attempted_grasper, forced_zone)
	playsound(src.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	sound_hint(src, attempted_grasper)
	var/obj/item/bodypart/grasped_part = attempted_grasper.get_bodypart((forced_zone ? forced_zone : check_zone(attempted_grasper.zone_selected)))
	if(!grasped_part)
		to_chat(attempted_grasper, "<span class='danger'>You can't grasp a missing bodypart!</span>")
		return
	
	if(attempted_grasper.active_hand_index == grasped_part.held_index)
		to_chat(attempted_grasper, "<span class='danger'>You can't grasp your [grasped_part.name] with itself!</span>")
		return
	
	for(var/i in grasped_part?.children_zones)
		var/obj/item/bodypart/child = attempted_grasper.get_bodypart(i)
		if(attempted_grasper.active_hand_index == child.held_index)
			to_chat(attempted_grasper, "<span class='danger'>You can't grasp your [grasped_part.name] with your [child.name]!</span>")
			return

	var/obj/item/grab/graspy = new()
	if(!attempted_grasper.put_in_active_hand(graspy) || !graspy.try_grasp(attempted_grasper, grasped_part, attempted_grasper))
		to_chat(attempted_grasper, "<span class='danger'>You fail to grasp your [grasped_part.name].</span>")
		qdel(graspy)
		return
	else
		to_chat(attempted_grasper, "<span class='notice'>You firmly grasp your [grasped_part.name].</span>")
	return TRUE

//Resisting grabbe
/mob/proc/do_resist_grab(moving_resist, forced, silent = FALSE)
	return FALSE

/mob/living/do_resist_grab(moving_resist, forced, silent = FALSE)
	. = FALSE
	if(pulledby.grab_state > GRAB_PASSIVE)
		if(next_move < world.time)
			if(CHECK_MOBILITY(src, MOBILITY_RESIST) && prob(30/pulledby.grab_state))
				pulledby.visible_message("<span class='danger'>[src] has broken free of [pulledby]'s grip!</span>",
					"<span class='danger'>[src] has broken free of your grip!</span>", target = src,
					target_message = "<span class='danger'>You have broken free of [pulledby]'s grip!</span>")
				pulledby.stop_pulling()
				return TRUE
			changeNext_move(CLICK_CD_RESIST)
			pulledby.visible_message("<span class='danger'>[src] resists against [pulledby]'s grip!</span>",
				"<span class='danger'>[src] resists against your grip!</span>", target = src,
				target_message = "<span class='danger'>You resist against [pulledby]'s grip!</span>")
	else
		pulledby.stop_pulling()
		return TRUE

/mob/living/carbon/human/do_resist_grab(moving_resist, forced, silent)
	. = FALSE
	if(pulledby.grab_state > GRAB_PASSIVE)
		if(next_move < world.time)
			if(CHECK_MOBILITY(src, MOBILITY_RESIST))
				var/grabber_str = 10
				if(ishuman(pulledby) && pulledby.mind)
					grabber_str = GET_STAT_LEVEL(pulledby, str)
				var/grabbed_str = 10
				if(mind)
					grabbed_str = GET_STAT_LEVEL(src, str)
				var/str_diff = grabbed_str - grabber_str
				if(mind?.diceroll(GET_STAT_LEVEL(src, str)*0.75, GET_SKILL_LEVEL(src, melee)*0.25, mod = 5*str_diff) >= DICE_SUCCESS)
					changeNext_move(CLICK_CD_RESIST)
					pulledby.visible_message("<span class='danger'>[src] has broken free of [pulledby]'s grip!</span>",
						"<span class='danger'>[src] has broken free of your grip!</span>", target = src,
						target_message = "<span class='danger'>You have broken free of [pulledby]'s grip!</span>")
					pulledby.stop_pulling()
					return TRUE
				changeNext_move(CLICK_CD_RESIST)
				pulledby.visible_message("<span class='danger'>[src] resists against [pulledby]'s grip!</span>",
					"<span class='danger'>[src] resists against your grip!</span>", target = src,
					target_message = "<span class='danger'>You resist against [pulledby]'s grip!</span>")
	else
		pulledby.stop_pulling()
		return TRUE

//Stop grabbe
/mob/living/carbon/setGrabState(newstate)
	..()
	if(grab_state <= GRAB_NOTGRABBING)
		SEND_SIGNAL(src, COMSIG_LIVING_STOP_GRABBING)
