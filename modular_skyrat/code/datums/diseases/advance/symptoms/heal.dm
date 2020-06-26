/datum/symptom/oxygen	//It makes no sense for this one to be so punishing for viruses
	resistance = -1
	stage_speed = -1
	transmittable = -2

/datum/symptom/heal/starlight
	level = 6

/datum/symptom/heal/chem
	level = 6

/datum/symptom/heal/metabolism
	level = 6

/datum/symptom/heal/darkness
	level = 6

/datum/symptom/heal/coma
	stealth = 0
	resistance = 2
	stage_speed = -2
	transmittable = -2
	level = 8

/datum/symptom/heal/water
	level = 6

/datum/symptom/heal/radiation
	level = 6

/datum/symptom/heal/plasma
	stealth = 0
	resistance = 3
	stage_speed = -2
	transmittable = -2
	level = 6

/datum/symptom/heal/plasma/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	var/heal_amt = actual_power

	if(M.fire_stacks > 0)	//New hippie add, otherwise you die from plasma fires even if you're doing the suck on the plasma
		actual_power = actual_power + (M.fire_stacks*0.75)
	else
		actual_power = initial(actual_power)

	if(prob(5))
		to_chat(M, "<span class='notice'>You feel yourself absorbing plasma inside and around you...</span>")

	if(M.bodytemperature > BODYTEMP_NORMAL)
		M.adjust_bodytemperature(-20 * temp_rate * TEMPERATURE_DAMAGE_COEFFICIENT,BODYTEMP_NORMAL)
		if(prob(5))
			to_chat(M, "<span class='notice'>You feel less hot.</span>")
	else if(M.bodytemperature < (BODYTEMP_NORMAL + 1))
		M.adjust_bodytemperature(20 * temp_rate * TEMPERATURE_DAMAGE_COEFFICIENT,0,BODYTEMP_NORMAL)
		if(prob(5))
			to_chat(M, "<span class='notice'>You feel warmer.</span>")

	M.adjustToxLoss(-heal_amt)

	var/list/parts = M.get_damaged_bodyparts(TRUE,TRUE)
	if(!parts.len)
		return
	if(prob(5))
		to_chat(M, "<span class='notice'>The pain from your wounds fades rapidly.</span>")
	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, heal_amt/parts.len))
			M.update_damage_overlays()
	return TRUE

/datum/symptom/heal/toxin
	name = "Toxic Filter"
	desc = "The virus synthesizes regenerative chemicals in the bloodstream, repairing damage caused by toxins."
	stealth = 1
	resistance = -2
	stage_speed = -2
	transmittable = -2
	level = 4
	threshold_desc = list(
		"Stage Speed 6" = "Doubles healing speed.",
	)

/datum/symptom/heal/toxin/Start(datum/disease/advance/A)
	if(A.properties["stage_rate"] >= 6) //stronger healing
		power = 2

	 //100% chance to activate for slow but consistent healing
/datum/symptom/heal/toxin/Heal(mob/living/M, datum/disease/advance/A)
	var/heal_amt = 0.33 * power
	M.adjustToxLoss(-heal_amt)
	return TRUE

/datum/symptom/heal/supertoxin
	name = "Apoptoxin filter"
	desc = "The virus stimulates production of special stem cells in the bloodstream, causing rapid reparation of any damage caused by toxins."
	stealth = 0
	resistance = -2
	stage_speed = -2
	transmittable = -2
	level = 6
	threshold_desc = ""

/datum/symptom/heal/supertoxin/Heal(mob/living/M, datum/disease/advance/A)
	var/heal_amt = 0.7
	M.adjustToxLoss(-heal_amt)
	return TRUE

/datum/symptom/heal/brute
	name = "Regeneration"
	desc = "The virus stimulates the regenerative process in the host, causing faster wound healing."
	stealth = 1
	resistance = -2
	stage_speed = -2
	transmittable = -2
	level = 4
	threshold_desc = list(
	"Stage Speed 6" = "Doubles healing speed.",
	)

/datum/symptom/heal/brute/Start(datum/disease/advance/A)
	if(A.properties["stage_rate"] >= 6) //stronger healing
		power = 2

/datum/symptom/heal/brute/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 0.33 * power
	var/list/parts = M.get_damaged_bodyparts(TRUE,TRUE)

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, 0))
			M.update_damage_overlays()

	return TRUE

/datum/symptom/heal/superbrute
	name = "Flesh Mending"
	desc = "The virus rapidly mutates into body cells, effectively allowing it to quickly fix the host's wounds."
	stealth = 0
	resistance = 0
	stage_speed = -2
	transmittable = -2
	level = 6
	threshold_desc = list(
	"Stage Speed 6" = "Doubles healing speed.",
	)

/datum/symptom/heal/superbrute/Start(datum/disease/advance/A)
	if(A.properties["stage_rate"] >= 6) //stronger healing
		power = 2

/datum/symptom/heal/superbrute/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 0.7 * power

	var/list/parts = M.get_damaged_bodyparts(1,1) //1,1 because it needs inputs.

	if(M.getCloneLoss() > 0)
		M.adjustCloneLoss(-1)
		M.take_bodypart_damage(0, BURN) //Deals BURN damage, which is not cured by this symptom

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, 0))
			M.update_damage_overlays()

	return TRUE

/datum/symptom/heal/burn
	name = "Tissue Regrowth"
	desc = "The virus recycles dead and burnt tissues, speeding up the healing of damage caused by burns."
	stealth = 1
	resistance = -2
	stage_speed = -2
	transmittable = -2
	level = 6
	threshold_desc = list(
	"Stage Speed 6" = "Doubles healing speed.",
	)

/datum/symptom/heal/burn/Start(datum/disease/advance/A)
	if(A.properties["stage_rate"] >= 6) //stronger healing
		power = 2

/datum/symptom/heal/burn/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 0.33 * power

	var/list/parts = M.get_damaged_bodyparts(TRUE,TRUE)

	if(!parts.len)
		return

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(0, heal_amt/parts.len))
			M.update_damage_overlays()

	return TRUE

/datum/symptom/heal/heatresistance
	name = "Heat Resistance"
	desc = "The virus quickly balances body heat, while also replacing tissues damaged by external sources, making the infected almost immune to burning."
	stealth = 0
	resistance = 0
	stage_speed = -2
	transmittable = -2
	level = 6
	threshold_desc = list(
	"Resistance 4" = "Doubles healing power.",
	)
	var/temp_rate = 1
	power = 1

/datum/symptom/heal/heatresistance/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/heal_amt = 0
	if(A.properties["resistance"] >= 4) //stronger healing
		power = 2
	var/list/parts = M.get_damaged_bodyparts(TRUE,TRUE)

	if(M.on_fire && M.fire_stacks > 0)
		heal_amt = 1.5 * (M.fire_stacks*0.25) * power
	else
		heal_amt = 0
	if(M.bodytemperature > BODYTEMP_NORMAL)	//Shamelessly stolen from plasma fixation, whew lad
		M.adjust_bodytemperature(-20 * temp_rate * TEMPERATURE_DAMAGE_COEFFICIENT,BODYTEMP_NORMAL)
	else if(M.bodytemperature < (BODYTEMP_NORMAL))
		M.adjust_bodytemperature(20 * temp_rate * TEMPERATURE_DAMAGE_COEFFICIENT,BODYTEMP_NORMAL)
	if(prob(10) && heal_amt && (M.getBruteLoss()  || M.getFireLoss()))
		to_chat(M, "<span class='notice'>The pain from your wounds fades rapidly.</span>") //this is where healing takes place
	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len, heal_amt/parts.len, null, BODYPART_ORGANIC))
			M.update_damage_overlays()
	return 1

/datum/symptom/heal/dna
	name = "Deoxyribonucleic Acid Restoration"
	desc = "The virus repairs the host's genome, purging negative mutations."
	stealth = -1
	resistance = -1
	stage_speed = 0
	transmittable = -1
	level = 5
	threshold_desc = list(
	"Resistance 6" = "Additionally heals brain damage.",
	)
	var/healing_brain = FALSE

/datum/symptom/heal/dna/Start(datum/disease/advance/A)
	if(A.properties["resistance"] >= 6) //stronger healing
		healing_brain = TRUE

/datum/symptom/heal/dna/Heal(mob/living/carbon/M, datum/disease/advance/A)
	var/amt_healed = 0.5
	if(healing_brain)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -(2 * amt_healed))
		var/mob/living/carbon/C = M
		if(prob(40))
			C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_LOBOTOMY)
	//Non-power mutations, excluding race, so the virus does not force monkey -> human transformations.
	var/list/unclean_mutations = GLOB.all_mutations[RACEMUT] - (GLOB.not_good_mutations|GLOB.bad_mutations)
	M.dna.remove_mutation_group(unclean_mutations)
	M.radiation = max(M.radiation - amt_healed, 0)
	return TRUE

//skyrat addition - alcohol healing disease thing
/datum/symptom/heal/alcohol
	name = "Booze Healing"
	desc = "The virus uses alcohol based reagents inside the host to heal them."
	stealth = 0
	resistance = -1
	stage_speed = 0
	transmittable = 1
	level = 7
	passive_message = "<span class='notice'>You really want a drink...</span>"
	var/absorption_coeff = 1.5
	threshold_desc = list(
		"Stealth 2" = "Alcohol is absorbed at a much slower rate.",
		"Stage Speed 6" = "Increases healing speed.",
	)

/datum/symptom/heal/alcohol/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 6)
		power = 2
	if(A.properties["stealth"] >= 2)
		absorption_coeff = initial(absorption_coeff)/2

/datum/symptom/heal/alcohol/CanHeal(datum/disease/advance/A) //warning: shitcode ahead
	. = 0
	var/mob/living/M = A.affected_mob
	if(M.reagents.has_reagent(/datum/reagent/consumable/ethanol))
		var/list/boozereagents = list()
		var/list/boozepowers = list(0)
		var/multiplier = 0
		for(var/datum/reagent/consumable/ethanol/E in M.reagents)
			boozereagents += E
		for(var/datum/reagent/consumable/ethanol/E in boozereagents)
			boozepowers += E.boozepwr
		multiplier = max(boozepowers)/100
		for(var/datum/reagent/consumable/ethanol/E in M.reagents)
			M.reagents.remove_reagent(E, 1 * absorption_coeff)
		. += (power * multiplier)/2

/datum/symptom/heal/alcohol/Heal(mob/living/carbon/M, datum/disease/advance/A, actual_power)
	var/heal_amt = actual_power

	var/list/parts = M.get_damaged_bodyparts(1,1) //more effective on burns

	if(!parts.len)
		return

	if(prob(5) && (M.getBruteLoss() || M.getFireLoss()))
		to_chat(M, "<span class='notice'>The alcohol makes you feel stronger.</span>")

	for(var/obj/item/bodypart/L in parts)
		if(L.heal_damage(heal_amt/parts.len * 0.5, heal_amt/parts.len))
			M.update_damage_overlays()

	return 1
