//Makes strong actually useful. Somewhat.
/datum/mutation/human/strong
	name = "Strength"
	desc = "The user's muscles slightly expand, allowing them to move heavy objects easily."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You feel strong!</span>"
	text_lose_indication = "<span class='notice'>You feel fairly weak.</span>"
	difficulty = 16
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
		for(var/datum/reagent/toxin/T in M.reagents.reagent_list)
			owner.reagents.remove_all_type(T, STIMMED_PURGE_AMOUNT, FALSE, TRUE)
	if(prob(2)) //about once every 5 seconds?
		owner.adjustToxLoss(-2.5)