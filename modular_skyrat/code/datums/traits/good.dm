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

//gamer girl quirk
/datum/quirk/anti_ugly
	name = "Beautiful"
	desc = "Your face is considered attractive by most. People around you will have their mood positively impacted if your face is visible."
	value = 2
	mob_trait = TRAIT_BEAUTY
	medical_record_text = "Patient is considered exceptionally attractive by most standards."
	var/pcooldown = 0
	var/pcooldown_time = 20 SECONDS

/datum/quirk/anti_ugly/process()
	if(pcooldown > world.time)
		return
	pcooldown = world.time + pcooldown_time
	var/mob/living/carbon/human/H = quirk_holder
	if(H && istype(H))
		if(!H.is_mouth_covered())
			for(var/mob/living/carbon/human/disgusted in (view(7, H) - H))
				SEND_SIGNAL(disgusted, COMSIG_ADD_MOOD_EVENT, "beauty", /datum/mood_event/beauty)

