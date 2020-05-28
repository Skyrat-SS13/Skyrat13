//hardened soles
/datum/quirk/hard_soles
	name = "Hardened Soles"
	desc = "You're used to walking barefoot, and won't receive the negative effects of doing so."
	value = 2
	mob_trait = TRAIT_HARD_SOLES
	gain_text = "<span class='notice'>The ground doesn't feel so rough on your feet anymore.</span>"
	lose_text = "<span class='danger'>You start feeling the ridges and imperfections on the ground.</span>"
	medical_record_text = "Patient's feet are more resilient against traction."

//kirk syndrome
/datum/quirk/kirk_syndrome
	name = "Xenophilia"
	desc = "You just love to be nearby different species, which might be a good trait on the stations like these."
	value = 1
	medical_record_text = "Patient exhibits an unnatural attraction for the people of differing species."
	var/xcooldown = 0
	var/xcooldown_time = 15 SECONDS
	var/sick_fug

/datum/quirk/kirk_syndrome/add()
	. = ..()
	var/mob/living/carbon/human/yellowcaptain = quirk_holder
	sick_fug = yellowcaptain.dna.species.type

/datum/quirk/kirk_syndrome/on_process()
	. = ..()
	if(xcooldown > world.time)
		return
	xcooldown = world.time + xcooldown_time
	var/mob/living/carbon/human/yellowcaptain = quirk_holder
	if(!sick_fug)
		sick_fug = yellowcaptain.dna.species.type
	var/yescount = 0
	for(var/mob/living/carbon/human/H in (view(5, yellowcaptain) - yellowcaptain))
		if(H.dna.species.type != sick_fug)
			yescount++
	if(yescount > 0)
		SEND_SIGNAL(yellowcaptain, COMSIG_ADD_MOOD_EVENT, "kirk_happy", /datum/mood_event/kirk_happy)
