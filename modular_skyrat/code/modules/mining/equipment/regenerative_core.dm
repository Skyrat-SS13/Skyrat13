/obj/item/organ/regenerative_core/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag && ishuman(target) && !is_station_level(target.z))
		var/mob/living/carbon/human/H = target
		if(inert)
			to_chat(user, "<span class='notice'>[src] has decayed and can no longer be used to heal.</span>")
			return
		if(AmBloodsucker(user))
			to_chat(user, "<span class='notice'>[src] breaks down as it fails to heal your unholy self</span>")
			return
		else
			if(H.stat == DEAD)
				to_chat(user, "<span class='notice'>[src] are useless on the dead.</span>")
				return
			if(H != user)
				H.visible_message("[user] forces [H] to apply [src]... [H.p_they()] quickly regenerate all injuries!")
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "other"))
			else
				to_chat(user, "<span class='notice'>You start to smear [src] on yourself. It feels and smells disgusting, but you feel amazingly refreshed in mere moments.</span>")
				SSblackbox.record_feedback("nested tally", "hivelord_core", 1, list("[type]", "used", "self"))
			H.revive(full_heal = 1)
			qdel(src)
			user.log_message("[user] used [src] to heal [H]! Wake the fuck up, Samurai!", LOG_ATTACK, color="green") //Logging for 'old' style legion core use, when clicking on a sprite of yourself or another.
	if(proximity_flag && ishuman(target) && is_station_level(target.z))
		var/mob/living/carbon/human/H = target
		if(!inert)
			H.AdjustStun(-25, 0)
			H.AdjustKnockdown(-25, 0)
			H.AdjustUnconscious(-25, 0)
			H.adjustStaminaLoss(-25, 0)
			H.adjustBruteLoss(-25, 0)
			H.adjustFireLoss(-25, 0)
			H.adjustOxyLoss(-25, 0)
			H.adjustToxLoss(-25, 0)
			H.adjustCloneLoss(-25, 0)
			for(var/obj/item/organ/O in H.internal_organs)
				O.damage = 0
			H.log_message("[H] used [src] to heal [H] on-station!", LOG_ATTACK, color="green")
			qdel(src)
		else
			to_chat(user, "<span class='notice'>[src] has decayed and can no longer be used to heal.</span>")
	if(isliving(target))
		var/mob/living/M = target
		if(istype(M, /mob/living/simple_animal/hostile/megafauna/bubblegum) && !istype(M, /mob/living/simple_animal/hostile/megafauna/bubblegum/hard) && (M.stat != DEAD))
			new /mob/living/simple_animal/hostile/megafauna/bubblegum/hard(M.loc)
			visible_message("[user] turned [M] into an enraged [M]!")
			qdel(M)
			qdel(src)
		if(istype(M, /mob/living/simple_animal/hostile/megafauna/dragon) && !istype(M, /mob/living/simple_animal/hostile/megafauna/dragon/hard) && (M.stat != DEAD))
			new /mob/living/simple_animal/hostile/megafauna/dragon/hard(M.loc)
			visible_message("[user] turned [M] into an enraged [M]!")
			qdel(M)
			qdel(src)
		if(istype(M, /mob/living/simple_animal/hostile/megafauna/legion) && !istype(M, /mob/living/simple_animal/hostile/megafauna/legion/hard) && (M.stat != DEAD))
			new /mob/living/simple_animal/hostile/megafauna/legion/hard(M.loc)
			visible_message("[user] turned [M] into an enraged [M]!")
			qdel(M)
			qdel(src)

/obj/item/organ/regenerative_core/attack_self(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!is_station_level(H.z))
			if(!inert)
				H.revive(full_heal = 1)
				qdel(src)
				H.log_message("[H] used [src] to heal themselves off-station!", LOG_ATTACK, color="green")
			else
				to_chat(user, "<span class='notice'>[src] has decayed and can no longer be used to heal.</span>")
		else
			if(!inert)
				H.AdjustStun(-25, 0)
				H.AdjustKnockdown(-25, 0)
				H.AdjustUnconscious(-25, 0)
				H.adjustStaminaLoss(-25, 0)
				H.adjustBruteLoss(-25, 0)
				H.adjustFireLoss(-25, 0)
				H.adjustOxyLoss(-25, 0)
				H.adjustToxLoss(-25, 0)
				H.adjustCloneLoss(-25, 0)
				for(var/obj/item/organ/O in H.internal_organs)
					O.damage = 0
				H.log_message("[H] used [src] to heal themselves on-station!", LOG_ATTACK, color="green")
				qdel(src)
			else
				to_chat(user, "<span class='notice'>[src] has decayed and can no longer be used to heal.</span>")