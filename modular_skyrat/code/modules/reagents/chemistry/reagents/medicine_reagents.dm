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

/datum/reagent/medicine/brutaline
	name = "Brutaline"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 20
	pH = 5

/datum/reagent/medicine/brutaline/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/brutaline/overdose_process(mob/living/M)
	M.adjustBruteLoss(4*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/feuerane
	name = "Feuerane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 20
	pH = 9

/datum/reagent/medicine/feuerane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/feuerane/overdose_process(mob/living/M)
	M.adjustFireLoss(4*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/giftignicht
	name = "Giftignicht"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 20
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/giftignicht/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-2*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,2)
	..()
	. = 1

/datum/reagent/medicine/giftignicht/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/wundermittelone
	name = "Wundermittelone"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 20
	taste_description = "grossness"

/datum/reagent/medicine/wundermittelone/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-1*REM, FALSE)
		M.adjustFireLoss(-1*REM, FALSE)
		M.adjustOxyLoss(-1*REM, FALSE)
		M.adjustToxLoss(-1*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/wundermittelone/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, FALSE)
	M.adjustOxyLoss(2*REM, FALSE)
	M.adjustBruteLoss(2*REM, FALSE)
	M.adjustFireLoss(2*REM, FALSE)
	..()
	. = 1

// TRANSITIONING MEDICINE

/datum/reagent/medicine/linguaggiomedio
	name = "Linguaggiomedio"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	overdose_threshold = 10
	taste_description = "poison"

/datum/reagent/medicine/linguaggiomedio/on_mob_life(mob/living/carbon/M)
	if(prob(25))
		M.adjustBruteLoss(2*REM, FALSE)
		M.adjustFireLoss(2*REM, FALSE)
		M.adjustOxyLoss(2*REM, FALSE)
		M.adjustToxLoss(2*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/linguaggiomedio/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REM, FALSE)
	M.adjustOxyLoss(2*REM, FALSE)
	M.adjustBruteLoss(2*REM, FALSE)
	M.adjustFireLoss(2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/brutemedio
	name = "Brutemedio"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "poison"

/datum/reagent/medicine/brutemedio/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(0.5*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()

/datum/reagent/medicine/burnmedio
	name = "Burnmedio"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "poison"

/datum/reagent/medicine/burnmedio/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(0.5*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()

/datum/reagent/medicine/toxicmedio
	name = "Toxicmedio"
	description = "Medicine that is used to create higher forms of individual medicine. Do not consume."
	reagent_state = LIQUID
	color = "#808080"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "poison"

/datum/reagent/medicine/toxicmedio/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(0.5*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,2)
	..()

// TIER 3

/datum/reagent/medicine/obligerine
	name = "Obligerine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	overdose_threshold = 10
	pH = 5

/datum/reagent/medicine/obligerine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-5*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/obligerine/overdose_process(mob/living/M)
	M.adjustBruteLoss(10*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/croustillantane
	name = "Croustillantane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	overdose_threshold = 10
	pH = 9

/datum/reagent/medicine/croustillantane/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-5*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/croustillantane/overdose_process(mob/living/M)
	M.adjustFireLoss(10*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/nontoxique
	name = "Nontoxique"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	overdose_threshold = 10
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/nontoxique/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-5*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,4)
	..()
	. = 1

/datum/reagent/medicine/nontoxique/overdose_process(mob/living/M)
	M.adjustToxLoss(10*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/guerirone
	name = "Guerirone"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	overdose_threshold = 10
	taste_description = "grossness"

/datum/reagent/medicine/guerirone/on_mob_life(mob/living/carbon/M)
	if(prob(90))
		M.adjustBruteLoss(-2*REM, FALSE)
		M.adjustFireLoss(-2*REM, FALSE)
		M.adjustOxyLoss(-2*REM, FALSE)
		M.adjustToxLoss(-2*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/guerirone/overdose_process(mob/living/M)
	M.adjustToxLoss(4*REM, FALSE)
	M.adjustOxyLoss(4*REM, FALSE)
	M.adjustBruteLoss(4*REM, FALSE)
	M.adjustFireLoss(4*REM, FALSE)
	..()
	. = 1

// NULLIFYING MEDICINE

/datum/reagent/medicine/brutex
	name = "Obligerine"
	description = "Restores bruising. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#fc2626"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	pH = 5

/datum/reagent/medicine/brutex/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/brutex/overdose_process(mob/living/M)
	M.adjustBruteLoss(0.5*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/burnex
	name = "Croustillantane"
	description = "Restores fire damage. Overdose causes it instead."
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	pH = 9

/datum/reagent/medicine/burnex/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-0.2*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/burnex/overdose_process(mob/living/M)
	M.adjustFireLoss(0.5*REM, FALSE)
	..()
	. = 1

/datum/reagent/medicine/toxicex
	name = "Nontoxique"
	description = "Heals toxin damage and removes toxins in the bloodstream. Overdose causes toxin damage."
	reagent_state = LIQUID
	color = "#6aff00"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	taste_description = "a roll of gauze"
	pH = 10

/datum/reagent/medicine/toxicex/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.2*REM, FALSE)
	for(var/datum/reagent/toxin/R in M.reagents.reagent_list)
		M.reagents.remove_reagent(R.type,0.5)
	..()
	. = 1

/datum/reagent/medicine/toxicex/overdose_process(mob/living/M)
	M.adjustToxLoss(0.5*REM, FALSE) // End result is 2 toxin loss taken, because it heals 2 and then removes 4.
	..()
	. = 1

/datum/reagent/medicine/allex
	name = "Guerirone"
	description = "Has a high chance to heal all types of damage. Overdose instead causes it."
	reagent_state = LIQUID
	color = "#e650c0"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	overdose_threshold = 10
	taste_description = "grossness"

/datum/reagent/medicine/allex/on_mob_life(mob/living/carbon/M)
	if(prob(90))
		M.adjustBruteLoss(-0.1*REM, FALSE)
		M.adjustFireLoss(-0.1*REM, FALSE)
		M.adjustOxyLoss(-0.1*REM, FALSE)
		M.adjustToxLoss(-0.1*REM, FALSE)
		. = 1
	..()

/datum/reagent/medicine/allex/overdose_process(mob/living/M)
	M.adjustToxLoss(0.5*REM, FALSE)
	M.adjustOxyLoss(0.5*REM, FALSE)
	M.adjustBruteLoss(0.5*REM, FALSE)
	M.adjustFireLoss(0.5*REM, FALSE)
	..()
	. = 1