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
	M.adjustBruteLoss(-2*REM, FALSE)
	M.nutrition -= 5
	..()
	. = 1

/datum/reagent/medicine/bicaridine/overdose_process(mob/living/M)
	M.adjustBruteLoss(2*REM, FALSE)
	M.nutrition -= 5
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
	M.adjustFireLoss(-2*REM, FALSE)
	M.nutrition -= 5
	..()
	. = 1

/datum/reagent/medicine/kelotane/overdose_process(mob/living/M)
	M.adjustFireLoss(2*REM, FALSE)
	M.nutrition -= 5
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
	M.adjustToxLoss(-2*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,1)
	M.nutrition -= 5
	..()
	. = 1

/datum/reagent/medicine/antitoxin/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	M.nutrition -= 5
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
		M.adjustBruteLoss(-1*REM, FALSE)
		M.adjustFireLoss(-1*REM, FALSE)
		M.adjustOxyLoss(-1*REM, FALSE)
		M.adjustToxLoss(-1*REM, FALSE)
		M.nutrition -= 5
		. = 1
	..()

/datum/reagent/medicine/tricordrazine/overdose_process(mob/living/M)
	M.adjustToxLoss(1*REM, FALSE)
	M.adjustOxyLoss(1*REM, FALSE)
	M.adjustBruteLoss(1*REM, FALSE)
	M.adjustFireLoss(1*REM, FALSE)
	M.nutrition -= 5
	..()
	. = 1

// START OF KOBECHEMS
// TIER 2

/datum/reagent/medicine/bicaridineplus
	name = "megaBicaridine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 20
	pH = 5

/datum/reagent/medicine/bicaridineplus/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-3*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/bicaridineplus/overdose_process(mob/living/M)
	M.adjustBruteLoss(3*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplus
	name = "megaKelotane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 20
	pH = 9

/datum/reagent/medicine/kelotaneplus/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-3*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplus/overdose_process(mob/living/M)
	M.adjustFireLoss(3*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplus
	name = "megaAnti-Toxin"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 20
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/antitoxinplus/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-3*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,2)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplus/overdose_process(mob/living/M)
	M.adjustToxLoss(3*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/tricordrazineplus
	name = "megaTricordrazine"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 20
	taste_description = "grossness"

/datum/reagent/medicine/tricordrazineplus/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-2*REM, FALSE)
		M.adjustFireLoss(-2*REM, FALSE)
		M.adjustOxyLoss(-2*REM, FALSE)
		M.adjustToxLoss(-2*REM, FALSE)
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
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	taste_description = "poison"

/datum/reagent/medicine/tbasic/on_mob_life(mob/living/carbon/M)
	if(prob(25))
		M.adjustBruteLoss(0.1*REM, FALSE)
		M.adjustFireLoss(0.1*REM, FALSE)
		M.adjustOxyLoss(0.1*REM, FALSE)
		M.adjustToxLoss(0.1*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/tbasic/overdose_process(mob/living/M)
	M.adjustToxLoss(0.1*REM, FALSE)
	M.adjustOxyLoss(0.1*REM, FALSE)
	M.adjustBruteLoss(0.1*REM, FALSE)
	M.adjustFireLoss(0.1*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/tbrute
	name = "TBrute"
	description = "Medicine that is used to create higher forms of individual medicine. Can be used to treat brute long-term."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 20

/datum/reagent/medicine/tbrute/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/tbrute/overdose_process(mob/living/M)
	M.adjustBruteLoss(0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/tburn
	name = "TBurn"
	description = "Medicine that is used to create higher forms of individual medicine. Can be used to treat burns long-term."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 20

/datum/reagent/medicine/tburn/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/tburn/overdose_process(mob/living/M)
	M.adjustFireLoss(0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/ttoxic
	name = "TToxic"
	description = "Medicine that is used to create higher forms of individual medicine. Can be used to treat poison long-term."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 20

/datum/reagent/medicine/ttoxic/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.2*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,0.5)
	..()
	. = 1

/datum/reagent/medicine/ttoxic/overdose_process(mob/living/M)
	M.adjustToxLoss(0.2*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

// TIER 3

/datum/reagent/medicine/bicaridineplusplus
	name = "ultiBicaridine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 10
	pH = 5

/datum/reagent/medicine/bicaridineplusplus/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-4*REM, FALSE)
	M.Dizzy(2)
	M.Jitter(2)
	..()
	. = 1

/datum/reagent/medicine/bicaridineplusplus/overdose_process(mob/living/M)
	M.adjustBruteLoss(4*REM, FALSE)
	M.Dizzy(5)
	M.Jitter(5)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplusplus
	name = "ultiKelotane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 10
	pH = 9

/datum/reagent/medicine/kelotaneplusplus/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-4*REM, FALSE)
	M.Dizzy(2)
	M.Jitter(2)
	..()
	. = 1

/datum/reagent/medicine/kelotaneplusplus/overdose_process(mob/living/M)
	M.adjustFireLoss(4*REM, FALSE)
	M.Dizzy(5)
	M.Jitter(5)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplusplus
	name = "ultiAnti-Toxin"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 10
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/antitoxinplusplus/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-4*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,4)
	M.Dizzy(2)
	M.Jitter(2)
	..()
	. = 1

/datum/reagent/medicine/antitoxinplusplus/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REM, FALSE)
	M.Dizzy(5)
	M.Jitter(5)
	..()
	. = 1

/datum/reagent/medicine/tricordrazineplusplus
	name = "ultiTricordrazine"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 10
	taste_description = "grossness"

/datum/reagent/medicine/tricordrazineplusplus/on_mob_life(mob/living/carbon/M)
	if(prob(90))
		M.adjustBruteLoss(-4*REM, FALSE)
		M.adjustFireLoss(-4*REM, FALSE)
		M.adjustOxyLoss(-4*REM, FALSE)
		M.adjustToxLoss(-4*REM, FALSE)
		. = 1
	M.Dizzy(2)
	M.Jitter(2)
	..()

/datum/reagent/medicine/tricordrazineplusplus/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REM, FALSE)
	M.adjustOxyLoss(4*REM, FALSE)
	M.adjustBruteLoss(4*REM, FALSE)
	M.adjustFireLoss(4*REM, FALSE)
	M.Dizzy(5)
	M.Jitter(5)
	..()
	. = 1

// ADDITIONAL CHEMS (OXYGEN AND ORGAN)

// --OXYGEN
/datum/reagent/medicine/toxygen
	name = "TOxygen"
	description = "Medicine that is used to create higher forms of individual medicine. If a patient cant breathe, this is your medicine."
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 20
	pH = 12

/datum/reagent/medicine/rebreath/on_mob_life(mob/living/carbon/M)
	M.losebreath = 0
	M.nutrition -= 5
	..()

// --ORGANS
/datum/reagent/medicine/relung
	name = "reLung"
	description = "Efficiently restores lung damage."
	color = "#DCDCFF"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	pH = 10.4

/datum/reagent/medicine/mannitol/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_LUNGS, -2*REM)
	..()

/datum/reagent/medicine/reheart
	name = "reHeart"
	description = "Efficiently restores heart damage."
	color = "#DCDCFF"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	pH = 10.4

/datum/reagent/medicine/mannitol/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_HEART, -2*REM)
	..()

/datum/reagent/medicine/reliver
	name = "reLiver"
	description = "Efficiently restores liver damage."
	color = "#DCDCFF"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	pH = 10.4

/datum/reagent/medicine/mannitol/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_LIVER, -2*REM)
	..()

// END OF KOBECHEMS

/datum/reagent/medicine/synthflesh
	description = "Instantly heals brute and burn damage when the chemical is applied via touch application, but also deals toxin damage relative to the brute and burn damage healed."

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
				M.adjustToxLoss( amount_healed * 0.25 )
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
				if(show_message) to_chat(M, "<span class='danger'>You feel your burns and bruises healing! It stings like hell!</span>")
			var/vol = reac_volume + M.reagents.get_reagent_amount(/datum/reagent/medicine/synthflesh)
			if(HAS_TRAIT_FROM(M, TRAIT_HUSK, "burn") && M.getFireLoss() < THRESHOLD_UNHUSK && (vol > overdose_threshold))
				M.cure_husk("burn")
				M.visible_message("<span class='nicegreen'>Most of [M]'s burnt off or charred flesh has been restored!")
	..()
