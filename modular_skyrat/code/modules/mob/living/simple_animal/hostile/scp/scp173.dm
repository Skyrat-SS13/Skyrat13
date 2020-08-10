/mob/living/simple_animal/hostile/scp173
	name = "SCP 173"
	desc = "An SCP that is known to snap your neck if you look away."
	icon = 'modular_skyrat/icons/mob/scp/scp173.dmi'
	icon_state = "scp173"
	icon_living = "scp173"
	maxHealth = 5000
	health = 5000
	move_to_delay = 0
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS

	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS

	var/blink_cooldown

/mob/living/simple_animal/hostile/scp173/Life(seconds, times_fired)
	. = ..()
	forceBlink()
	aiSnapNecks()
	
/mob/living/simple_animal/hostile/scp173/proc/forceBlink()
	if(world.time < blink_cooldown)
		return
	for(var/mob/living/carbon/human/H in range(14, src))
		if(H.stat == DEAD)
			continue
		H.blind_eyes(2)
		H.blur_eyes(4)
	blink_cooldown = world.time + 15 SECONDS
	
/mob/living/simple_animal/hostile/scp173/proc/aiSnapNecks()
	if(ckey && mind)
		return
	else
		for(var/directions in GLOB.cardinals)
			var/turf/T = get_step(src, directions)
			for(var/mob/living/L in T)
				if(L.stat == DEAD)
					continue
				AttackingTarget(L)

/mob/living/simple_animal/hostile/scp173/proc/beingWatched()
	for(var/mob/living/carbon/human/H in viewers(src))
		if(is_blind(H) || H.eye_blind > 0)
			continue
		if(H.stat == DEAD)
			continue
		if(src in viewers(H))
			stop_automated_movement = TRUE
			return TRUE
	stop_automated_movement = FALSE
	return FALSE

/mob/living/simple_animal/hostile/scp173/Move(atom/newloc, dir, step_x, step_y)
	if(beingWatched())
		return FALSE
	return ..()
	
/mob/living/simple_animal/hostile/scp173/movement_delay()
	return -10
	
/mob/living/simple_animal/hostile/scp173/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	return

/mob/living/simple_animal/hostile/scp173/emote(act, m_type, message, intentional)
	return
	
/mob/living/simple_animal/hostile/scp173/MoveToTarget(list/possible_targets)
	if(beingWatched())
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/scp173/PickTarget(list/Targets)
	if(target != null)
		for(var/pos_targ in Targets)
			var/atom/A = pos_targ
			var/target_dist = get_dist(targets_from, target)
			var/possible_target_distance = get_dist(targets_from, A)
			if(target_dist < possible_target_distance)
				Targets -= A
			if(!ishuman(A) && !issilicon(A))
				Targets -= A
	if(!Targets.len)
		return
	var/chosen_target = pick(Targets)
	return chosen_target
	
/mob/living/simple_animal/hostile/scp173/UnarmedAttack(atom/A)
	if(beingWatched())
		return
	if(isstructure(A))
		var/obj/structure/S = A
		S.obj_integrity -= 10
	else if(istype(A, /obj/machinery/door))
		var/obj/machinery/door/D = A
		if(!D.density)
			return
		if(D.locked)
			if(!do_after(src, 5 SECONDS, FALSE, D))
				return
			D.locked = FALSE
			return
		if(D.welded)
			if(!do_after(src, 5 SECONDS, FALSE, D))
				return
			D.welded = FALSE
			return
		if(!do_after(src, 5 SECONDS, FALSE, D))
			return
		D.open()
	else if(isliving(A))
		var/mob/living/L = A
		if(L.stat == DEAD)
			return
		L.death()
		playsound(loc, pick('modular_skyrat/sound/scp/NeckSnap1.ogg', 'modular_skyrat/sound/scp/NeckSnap2.ogg'), 50, 1, -1)
		visible_message("<span class='warning'>[src] snaps [L]'s neck!</span>")
	
/mob/living/simple_animal/hostile/scp173/AttackingTarget()
	if(beingWatched())
		return
	if(!ishuman(target))
		qdel(target)
	var/mob/living/carbon/human/H = target
	if(H.stat == DEAD)
		return
	H.death()
	playsound(loc, pick('modular_skyrat/sound/scp/NeckSnap1.ogg', 'modular_skyrat/sound/scp/NeckSnap2.ogg'), 50, 1, -1)
	visible_message("<span class='warning'>[src] snaps [H]'s neck!</span>")
