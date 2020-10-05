/obj/item/organ/lungs/slime
	name = "vacuole"
	desc = "A large organelle designed to store oxygen and other important gasses."

	safe_toxins_max = 0 //We breathe this to gain POWER.

	cold_level_1_threshold = 285 // Remember when slimes used to be succeptable to cold? Well....
	cold_level_2_threshold = 260
	cold_level_3_threshold = 230

	maxHealth = 250

/obj/item/organ/lungs/slime/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H)
	. = ..()
	if (breath && breath.gases[/datum/gas/plasma])
		var/plasma_pp = breath.get_breath_partial_pressure(breath.gases[/datum/gas/plasma])
		owner.blood_volume += (0.2 * plasma_pp) // 10/s when breathing literally nothing but plasma, which will suffocate you.
