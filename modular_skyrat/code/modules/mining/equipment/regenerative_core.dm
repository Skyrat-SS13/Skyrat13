/obj/item/organ/regenerative_core/afterattack(atom/target, mob/user, proximity_flag)
	if(proximity_flag)
		if(iscarbon(target))
			apply_healing_core(target, user)
		else if(istype(target, /mob/living/simple_animal/hostile/megafauna/bubblegum))
			visible_message("<span class='notice>[user] tries forcing [src] onto [target]...</span>")
			if(!do_mob(user, target, 10))
				return
			new /mob/living/simple_animal/hostile/megafauna/bubblegum/hard(target.loc)
			visible_message("<span class='userdanger'>[user] turned [target] into an enraged [target]!</span>")
			qdel(target)
			qdel(src)
		else if(istype(target, /mob/living/simple_animal/hostile/megafauna/dragon))
			visible_message("<span class='notice>[user] tries forcing [src] onto [target]...</span>")
			if(!do_mob(user, target, 10))
				return
			new /mob/living/simple_animal/hostile/megafauna/dragon/hard(target.loc)
			visible_message("<span class='userdanger'>[user] turned [target] into an enraged [target]!</span>")
			qdel(target)
			qdel(src)
		else if(istype(target, /mob/living/simple_animal/hostile/megafauna/legion))
			visible_message("<span class='notice>[user] tries forcing [src] onto [target]...</span>")
			if(!do_mob(user, target, 10))
				return
			new /mob/living/simple_animal/hostile/megafauna/legion/hard(target.loc)
			visible_message("<span class='userdanger'>[user] turned [target] into an enraged [target]!</span>")
			qdel(target)
			qdel(src)

/obj/item/organ/regenerative_core/attack_self(mob/user)
	if(iscarbon(user))
		apply_healing_core(user, user)

/obj/item/organ/regenerative_core/proc/apply_healing_core(atom/target, mob/user)
	if(!user || QDELETED(src))
		return
	if(inert)
		to_chat(user, "<span class='notice'>[src] has decayed and can no longer be used to heal.</span>")
		return
	var/mob/living/carbon/C = target
	if(!istype(C))
		to_chat(user, "<span class='notice'>[src] are useless on the simple-minded.</span>")
		return
	if(C.stat == DEAD)
		to_chat(user, "<span class='notice'>[src] are useless on the dead.</span>")
		return
	if(user != C)
		user.visible_message("[user] forces [C] to apply [src]... Black tendrils entangle and reinforce [C.p_them()]!")
	else
		user.visible_message(user, "<span class='notice'>[C] starts applying \the [src] on themselves, disgusting tendrils enthralling them...","<span class='notice'>You start to smear [src] on yourself. The disgusting tendrils will hold you together and allow you to keep moving, but for how long?</span>")
	if(!do_mob(user, target, (user == target ? 1.5 SECONDS : 0.5 SECONDS)))
		return
	if(user != C)
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
	else
		SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
	if(!QDELETED(src))
		C.apply_status_effect(/datum/status_effect/regenerative_core)
	user.log_message("[user] used [src] to heal [C == user ? "[C.p_them()]self" : C]! Wake up Mr. Miner... Wake up, and smell the ash storms...", LOG_ATTACK, color="green") //Logging for 'old' style legion core use, when clicking on a sprite of yourself or another.
	qdel(src)
