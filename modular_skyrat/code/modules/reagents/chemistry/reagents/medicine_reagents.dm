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

//Trek Chems, used primarily by medibots. Only heals a specific damage type, but is very efficient.
// TIER 1

/datum/reagent/medicine/bicaridine
	name = "Bicaridine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 30
	pH = 5

/datum/reagent/medicine/bicaridine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-1*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/bicaridine/overdose_process(mob/living/M)
	M.adjustBruteLoss(2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotane
	name = "Kelotane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 30
	pH = 9

/datum/reagent/medicine/kelotane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-1*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotane/overdose_process(mob/living/M)
	M.adjustFireLoss(2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/antitoxin
	name = "Anti-Toxin"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 30
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/antitoxin/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-1*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,1)
	..()
	. = 1

/datum/reagent/medicine/antitoxin/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 30
	taste_description = "grossness"

/datum/reagent/medicine/tricordrazine/on_mob_life(mob/living/carbon/M)
	if(prob(70))
		M.adjustBruteLoss(-0.5*REM, FALSE)
		M.adjustFireLoss(-0.5*REM, FALSE)
		M.adjustOxyLoss(-0.5*REM, FALSE)
		M.adjustToxLoss(-0.5*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/tricordrazine/overdose_process(mob/living/M)
	M.adjustToxLoss(1*REM, FALSE)
	M.adjustOxyLoss(1*REM, FALSE)
	M.adjustBruteLoss(1*REM, FALSE)
	M.adjustFireLoss(1*REM, FALSE)
	..()
	. = 1

// "Newer" Medicine
// TIER 2

/datum/reagent/medicine/bicaridineplus
	name = "BicaridinePlus"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 20
	pH = 5

/datum/reagent/medicine/bicaridineplus/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/bicaridineplus/overdose_process(mob/living/M)
	M.adjustBruteLoss(4*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplus
	name = "KelotanePlus"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 20
	pH = 9

/datum/reagent/medicine/kelotaneplus/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplus/overdose_process(mob/living/M)
	M.adjustFireLoss(4*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplus
	name = "Anti-ToxinPlus"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 20
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/antitoxinplus/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-2*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,2)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplus/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/tricordrazineplus
	name = "TricordrazinePlus"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 20
	taste_description = "grossness"

/datum/reagent/medicine/tricordrazineplus/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-1*REM, FALSE)
		M.adjustFireLoss(-1*REM, FALSE)
		M.adjustOxyLoss(-1*REM, FALSE)
		M.adjustToxLoss(-1*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/tricordrazineplus/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, FALSE)
	M.adjustOxyLoss(2*REM, FALSE)
	M.adjustBruteLoss(2*REM, FALSE)
	M.adjustFireLoss(2*REM, FALSE)
	..()
	. = 1

// TRANSITIONING MEDICINE

/datum/reagent/medicine/tbasic
	name = "TBasic"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	overdose_threshold = 10
	taste_description = "poison"

/datum/reagent/medicine/tbasic/on_mob_life(mob/living/carbon/M)
	if(prob(25))
		M.adjustBruteLoss(2*REM, FALSE)
		M.adjustFireLoss(2*REM, FALSE)
		M.adjustOxyLoss(2*REM, FALSE)
		M.adjustToxLoss(2*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/tbasic/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, FALSE)
	M.adjustOxyLoss(2*REM, FALSE)
	M.adjustBruteLoss(2*REM, FALSE)
	M.adjustFireLoss(2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/tbrute
	name = "TBrute"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "poison"

/datum/reagent/medicine/tbrute/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(0.5*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()

/datum/reagent/medicine/tburn
	name = "TBurn"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "poison"

/datum/reagent/medicine/tburn/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(0.5*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()

/datum/reagent/medicine/ttoxic
	name = "TToxic"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "poison"

/datum/reagent/medicine/ttoxic/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(0.5*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()

// TIER 3

/datum/reagent/medicine/bicaridineplusplus
	name = "BicaridinePlusPlus"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 10
	pH = 5

/datum/reagent/medicine/bicaridineplusplus/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-5*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/bicaridineplusplus/overdose_process(mob/living/M)
	M.adjustBruteLoss(10*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplusplus
	name = "KelotanePlusPlus"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 10
	pH = 9

/datum/reagent/medicine/kelotaneplusplus/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-5*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplusplus/overdose_process(mob/living/M)
	M.adjustFireLoss(10*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplusplus
	name = "Anti-ToxinPlusPlus"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 10
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/antitoxinplusplus/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-5*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,4)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplusplus/overdose_process(mob/living/M)
	M.adjustToxLoss(10*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/tricordrazineplusplus
	name = "TricordrazinePlusPlus"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 10
	taste_description = "grossness"

/datum/reagent/medicine/tricordrazineplusplus/on_mob_life(mob/living/carbon/M)
	if(prob(90))
		M.adjustBruteLoss(-2*REM, FALSE)
		M.adjustFireLoss(-2*REM, FALSE)
		M.adjustOxyLoss(-2*REM, FALSE)
		M.adjustToxLoss(-2*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/tricordrazineplusplus/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REM, FALSE)
	M.adjustOxyLoss(4*REM, FALSE)
	M.adjustBruteLoss(4*REM, FALSE)
	M.adjustFireLoss(4*REM, FALSE)
	..()
	. = 1

// NULLIFYING MEDICINE

/datum/reagent/medicine/brutex
	name = "Brutex"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	pH = 5

/datum/reagent/medicine/brutex/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.1*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/brutex/overdose_process(mob/living/M)
	M.adjustBruteLoss(0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/burnex
	name = "Burnex"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	pH = 9

/datum/reagent/medicine/burnex/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-0.1*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/burnex/overdose_process(mob/living/M)
	M.adjustFireLoss(0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/toxicex
	name = "Toxicex"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/toxicex/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.1*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,0.5)
	..()
	. = 1

/datum/reagent/medicine/toxicex/overdose_process(mob/living/M)
	M.adjustToxLoss(0.2*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/allex
	name = "Allex"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	taste_description = "grossness"

/datum/reagent/medicine/allex/on_mob_life(mob/living/carbon/M)
	if(prob(50))
		M.adjustBruteLoss(-0.1*REM, FALSE)
		M.adjustFireLoss(-0.1*REM, FALSE)
		M.adjustOxyLoss(-0.1*REM, FALSE)
		M.adjustToxLoss(-0.1*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/allex/overdose_process(mob/living/M)
	M.adjustToxLoss(0.2*REM, FALSE)
	M.adjustOxyLoss(0.2*REM, FALSE)
	M.adjustBruteLoss(0.2*REM, FALSE)
	M.adjustFireLoss(0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/synthflesh
	description = "Instantly heals brute and burn damage when the chemical is applied via touch application, but also deals toxin damage relative to the brute and burn damage healed. Heals toxin damage on synths instead of harming them, unless overdosed."
	overdose_threshold = 20 //no synth species abusing

/datum/reagent/medicine/synthflesh/reaction_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)

	if(!iscarbon(M))
		return ..()

	if(M.stat == DEAD)
		show_message = 0

	switch(method)
		if(INJECT)
			return
		if(INGEST)
			var/mob/living/carbon/C = M
			C.emote("cough")
			C.vomit()
			if(show_message) to_chat(C, "<span class='danger'>Your stomach starts to hurt!</span>")
		if(PATCH,TOUCH,VAPOR)
			var/amount_healed = -(M.adjustBruteLoss(-1.25 * reac_volume) + M.adjustFireLoss(-1.25 * reac_volume))
			if(amount_healed && M.stat != DEAD)
				var/mob/living/carbon/human/ourguy = M
				if(ourguy)
					if(ourguy.dna.species.type != /datum/species/synth)
						ourguy.adjustToxLoss(amount_healed * 0.25)
					else
						if(!overdosed)
							ourguy.adjustToxLoss(-(amount_healed * 0.75)) //synths heal toxins with synthflesh
							ourguy.adjustCloneLoss(-(amount_healed * 1))
						else
							ourguy.adjustToxLoss(1)
				else
					M.adjustToxLoss(amount_healed * 0.25)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
				if(show_message) to_chat(M, "<span class='danger'>You feel your burns and bruises healing! It stings like hell!</span>")
			else if(!amount_healed && M.stat != DEAD) //synths can use it to heal toxins and cloning damage even without other injuries
				var/mob/living/carbon/human/ourguy = M
				if(ourguy)
					if(ourguy.dna.species.type == /datum/species/synth)
						ourguy.adjustToxLoss(-(reac_volume * 0.75))
						ourguy.adjustCloneLoss(-(reac_volume * 1))
			var/vol = reac_volume + M.reagents.get_reagent_amount(/datum/reagent/medicine/synthflesh)
			if(HAS_TRAIT_FROM(M, TRAIT_HUSK, "burn") && M.getFireLoss() < THRESHOLD_UNHUSK && (vol > overdose_threshold))
				M.cure_husk("burn")
				M.visible_message("<span class='nicegreen'>Most of [M]'s burnt off or charred flesh has been restored!")
	..()

/datum/reagent/medicine/synthflesh/overdose_start(mob/living/M)
	var/mob/living/carbon/human/H = M
	if(H)
		if((H.dna.species.type == /datum/species/synth) && (H.stat != DEAD))
			to_chat(H, "<span class='userdanger'>You feel like you took too much of [name]!</span>")
			overdosed = 1
