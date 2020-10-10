//hardened soles
/datum/quirk/hard_soles
	name = "Hardened Soles"
	desc = "You're used to walking barefoot, and won't receive the negative effects of doing so."
	value = 2
	mob_trait = TRAIT_HARD_SOLES
	gain_text = "<span class='notice'>The ground doesn't feel so rough on your feet anymore.</span>"
	lose_text = "<span class='danger'>You start feeling the ridges and imperfections on the ground.</span>"
	medical_record_text = "Patient's feet are more resilient against traction."
/*
//punch shit
/datum/quirk/steel_fists
	name = "Fists of steel"
	desc = "You are exceptionally good at unarmed combat. Punching and clawing will deal more damage."
	value = 3
	medical_record_text = "Patient is skilled in hand to hand combat."

/datum/quirk/steel_fists/add()
	. = ..()
	if(.)
		var/mob/living/carbon/human/H = quirk_holder
		if(H && istype(H))
			H.dna.species.punchdamagehigh += 5
			H.dna.species.punchdamagelow += 5
			H.dna.species.punchstunthreshold += 5
*/
//pain man good
//(turns masochist into a proper non-meme quirk)
/datum/quirk/maso
	name = "Masochism"
	desc = "You are wired differently. While pain still has negative impacts on you, it also greatly improves your mood."
	mob_trait = TRAIT_PAINGOOD
	value = 1
