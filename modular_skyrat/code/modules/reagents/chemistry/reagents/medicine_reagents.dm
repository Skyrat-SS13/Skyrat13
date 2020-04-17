/datum/reagent/medicine/strange_reagent
	description = "A miracle drug that can bring people back from the dead based on the dosage. For every 20 units of brute or burn damage, 1u of this reagent is required. Deals a small amount of damage on metabolism."

/datum/reagent/medicine/strange_reagent/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(M.stat == DEAD)
		var/true_reaction_volume = reac_volume + M.reagents.get_reagent_amount(/datum/reagent/medicine/strange_reagent)
		if(M.suiciding || M.hellbound) //they are never coming back
			M.visible_message("<span class='warning'>[M]'s body does not react... it seems they are not meant for this world.</span>")
			return
		if(M.getFireLoss() + M.getBruteLoss() >= true_reaction_volume*20) //body is too damaged to be revived
			//10u is required to heal 200 total damage.
			//20u is required to heal 400 total damage.
			//40u is required to heal 800 total damage.
			M.visible_message("<span class='warning'>[M]'s body convulses a bit, and then falls still once more.</span>")
			M.do_jitter_animation(10)
			return
		else
			M.visible_message("<span class='warning'>[M]'s body starts convulsing!</span>")
			M.notify_ghost_cloning(source = M)
			M.do_jitter_animation(10)
			addtimer(CALLBACK(M, /mob/living/carbon.proc/do_jitter_animation, 10), 40) //jitter immediately, then again after 4 and 8 seconds
			addtimer(CALLBACK(M, /mob/living/carbon.proc/do_jitter_animation, 10), 80)
			spawn(100) //so the ghost has time to re-enter
				if(iscarbon(M))
					var/mob/living/carbon/C = M
					if(!(C.dna && C.dna.species && (NOBLOOD in C.dna.species.species_traits)))
						C.blood_volume = max(C.blood_volume, BLOOD_VOLUME_NORMAL*C.blood_ratio) //so you don't instantly re-die from a lack of blood
					for(var/organ in C.internal_organs)
						var/obj/item/organ/O = organ
						if(O.damage > O.maxHealth/2)
							O.setOrganDamage(O.maxHealth/2) //so you don't instantly die from organ damage when being revived

				M.adjustOxyLoss(-20, 0)
				M.adjustToxLoss(-20, 0)
				M.updatehealth()
				if(M.revive())
					M.grab_ghost()
					M.emote("gasp")
					log_combat(M, M, "revived", src)
	..()

/datum/reagent/medicine/strange_reagent/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(0.5*REM, 0)
	M.adjustFireLoss(0.5*REM, 0)
	..()
	. = 1