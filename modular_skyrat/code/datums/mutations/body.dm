/datum/mutation/human/thickskin
	name = "Thick skin"
	desc = "The user's skin acquires a leathery texture, and is more resilient to harm."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>Your skin feels dry and heavy.</span>"
	text_lose_indication = "<span class='notice'>Your skin feels soft again...</span>"
	difficulty = 18
	instability = 25

/datum/mutation/human/strong/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	if(owner.dna.species)
		owner.dna.species.brutemod *= 0.75
		owner.dna.species.burnmod *= 0.9

/datum/mutation/human/strong/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	if(owner.dna.species)
		owner.dna.species.brutemod = initial(owner.dna.species.brutemod)
		owner.dna.species.burnmod = initial(owner.dna.species.burnmod)

//Makes strong actually useful. Somewhat.
/datum/mutation/human/strong
	name = "Strength"
	desc = "The user's muscles slightly expand, allowing them to move heavy objects easily."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You feel strong!</span>"
	text_lose_indication = "<span class='notice'>You feel fairly weak.</span>"
	difficulty = 12
	instability = 10

/datum/mutation/human/strong/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_NOT_SLOWEDBYDRAG, "genetics") // Don't get slowed by dragging lockers or mobs

/datum/mutation/human/strong/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_NOT_SLOWEDBYDRAG, "genetics")

//Stimmed make you do the toxing purge dance
 #define STIMMED_PURGE_AMOUNT 0.25

/datum/mutation/human/stimmed
	name = "Stimmed"
	desc = "The user's chemical balance is more robust, allowing them to quickly remove toxins from their body."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You feel relaxed.</span>"
	text_lose_indication = "<span class='notice'>Your can feel your liver working harder again.</span>"
	difficulty = 16
	instability = 25 // the purging is quite powerful

/datum/mutation/human/stimmed/on_life()
	if(owner.reagents)
		for(var/datum/reagent/toxin/T in owner.reagents.reagent_list)
			owner.reagents.remove_all_type(T, STIMMED_PURGE_AMOUNT, FALSE, TRUE)
	if(prob(2)) //about once every 5 seconds?
		owner.adjustToxLoss(-2.5)

/datum/mutation/human/glow/anti
	glow = -5
	locked = FALSE //this is actually useful for shadowpeople, let em have it