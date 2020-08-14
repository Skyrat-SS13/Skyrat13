/mob/living/simple_animal/hostile/scp/scp173
	name = "SCP 173"
	desc = "Do not blink. Blink and you're dead."
	icon = 'modular_skyrat/icons/mob/scp/scp173.dmi'
	icon_state = "scp173"
	icon_living = "scp173"

	var/blink_cooldown

/mob/living/simple_animal/hostile/scp/scp173/Life(seconds, times_fired)
	. = ..()
	forceBlink()
	aiSnapNecks()
	
/mob/living/simple_animal/hostile/scp/scp173/proc/forceBlink()
	if(world.time < blink_cooldown)
		return
	for(var/mob/living/carbon/human/H in viewers(src))
		if(H.stat == DEAD)
			continue
		H.blind_eyes(3)
		H.blur_eyes(4)
	blink_cooldown = world.time + 10 SECONDS
	
/mob/living/simple_animal/hostile/scp/scp173/proc/aiSnapNecks()
	if(ckey && mind)
		return
	else
		for(var/directions in GLOB.cardinals)
			var/turf/T = get_step(src, directions)
			for(var/mob/living/L in T)
				if(L.stat == DEAD)
					continue
				AttackingTarget(L)

/mob/living/simple_animal/hostile/scp/scp173/proc/beingWatched()
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

/mob/living/simple_animal/hostile/scp/scp173/Move(atom/newloc, dir, step_x, step_y)
	if(beingWatched())
		return FALSE
	return ..()
	
/mob/living/simple_animal/hostile/scp/scp173/movement_delay()
	return -10
	
/mob/living/simple_animal/hostile/scp/scp173/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	return

/mob/living/simple_animal/hostile/scp/scp173/emote(act, m_type, message, intentional)
	return
	
/mob/living/simple_animal/hostile/scp/scp173/UnarmedAttack(atom/A)
	if(beingWatched())
		return
	. = ..()
	if(isliving(A))
		var/mob/living/L = A
		if(L.stat == DEAD)
			return
		L.death()
		L.adjustBruteLoss(200)
		playsound(loc, pick('modular_skyrat/sound/scp/NeckSnap1.ogg', 'modular_skyrat/sound/scp/NeckSnap2.ogg'), 50, 1, -1)
		visible_message("<span class='warning'>[src] snaps [L]'s neck!</span>")

/mob/living/simple_animal/hostile/scp/scp173/attacked_by(obj/item/I, mob/living/user, attackchain_flags, damage_multiplier)
	if(user.a_intent == INTENT_HARM)
		var/half_maxhealth = maxHealth / 2
		if(health <= half_maxhealth)
			src.UnarmedAttack(user)
	return ..()
