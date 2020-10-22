// Crawling
/turf/open/attack_hand(mob/user)
	. = ..()
	if(user.lying)
		//do_after to prevent speedcrawling
		if(INTERACTING_WITH(user, src))
			to_chat(user, "<span class='warning'>I am already trying to crawl to [src]!</span>")
			return
		if(do_after(user, 7, TRUE, src))
			user.Move(get_step(user, get_dir(user, src)), get_dir(user, src))

// Knockdown stuff i guess
/turf/Bumped(atom/movable/AM)
	. = ..()
	if(density && iscarbon(AM))
		var/mob/living/carbon/C = AM
		//Ram into wall
		if(C.combat_flags & COMBAT_FLAG_SPRINT_ACTIVE)
			C.visible_message("<span class='warning'>[C] runs face-first into [src]!</span>", \
							"<span class='danger'>You ram your head face-first into [src]!</span>", \
							"<span class='warning'>You hear a loud, meaty thud!</span>")
			C.disable_sprint_mode()
			if(C.mind)
				//Dexterity roll
				switch(C.mind.diceroll(STAT_DATUM(dex)))
					//Critical success - stunned but half the time
					if(DICE_CRIT_SUCCESS)
						C.Stun(25)
					//Success - We get stunned, but not knocked down
					if(DICE_SUCCESS)
						C.Stun(50)
					//Failure - We get knocked down
					if(DICE_FAILURE)
						C.DefaultCombatKnockdown(200)
					//Critical failure - We get knocked unconscious
					if(DICE_CRIT_FAILURE)
						C.Unconscious(300)
				//Endurance roll
				switch(C.mind.diceroll(STAT_DATUM(end)))
					//Failure - We get minor brute damage on the head
					if(DICE_FAILURE)
						var/obj/item/bodypart/head = C.get_bodypart(BODY_ZONE_HEAD)
						if(head)
							head.receive_damage(rand(3, 7))
						else
							C.adjustBruteLoss(rand(3, 7))
					//Critical failure - We get a concussio as well as brute damage
					if(DICE_CRIT_FAILURE)
						var/obj/item/bodypart/head = C.get_bodypart(BODY_ZONE_HEAD)
						if(head)
							head.receive_damage(rand(3, 7))
						else
							C.adjustBruteLoss(rand(3, 7))
						C.gain_trauma_type(/datum/brain_trauma/mild/concussion)
			else
				C.DefaultCombatKnockdown(200)
				var/obj/item/bodypart/head = C.get_bodypart(BODY_ZONE_HEAD)
				if(head)
					head.receive_damage(rand(3, 7))
				else
					C.adjustBruteLoss(rand(3, 7))
			var/smash_sound = pick('modular_skyrat/sound/gore/smash1.ogg',
						'modular_skyrat/sound/gore/smash2.ogg',
						'modular_skyrat/sound/gore/smash3.ogg')
			playsound(src, smash_sound, 75)
			//0.25% chance to play the charger theme if you bonk into a wall
			if(prob(1) && prob(25))
				playsound(C, 'modular_skyrat/sound/music/mortification.ogg', 40, 0, -3)
