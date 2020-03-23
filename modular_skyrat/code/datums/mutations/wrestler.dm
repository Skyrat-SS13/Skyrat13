/datum/mutation/human/wrestler
	name = "Wrestling"
	desc = "The user gains knowledge of wrestling."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>OH YEAH BROTHER!</span>"
	text_lose_indication = "<span class='notice'>You no longer feel like you can wrestle a bear...</span>"
	difficulty = 18
	instability = 35 // Steroids are pretty bad!
	var/datum/martial_art/wrestling/MA = /datum/martial_art/wrestling

/datum/mutation/human/wrestler/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	var/datum/martial_art/W = new MA()
	W.teach(owner)

/datum/mutation/human/wrestler/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	MA.remove(owner)
