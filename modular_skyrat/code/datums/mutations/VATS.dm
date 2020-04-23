/datum/mutation/human/vats
	name = "V.A.T.S"
	desc = "The user gains incredible dexterity and agility, making their shots almost always hit where they aim."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You feel more comfortable using a gun.</span>"
	text_lose_indication = "<span class='notice'>You feel like you can't even play duck hunt anymore.</span>"
	difficulty = 14
	instability = 20 // Ain't that a kick in the head.

/datum/mutation/human/vats/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_VATS, "genetics")

/datum/mutation/human/vats/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_VATS, "genetics") // 18 karat run of bad DNA...