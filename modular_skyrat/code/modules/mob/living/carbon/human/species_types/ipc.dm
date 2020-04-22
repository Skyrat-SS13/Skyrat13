/datum/species/ipc

/datum/species/ipc/on_species_gain(mob/living/carbon/human/C)
	..()
	C.grant_language(/datum/language/machine)

/datum/species/ipc/on_species_loss(mob/living/carbon/human/C)
	..()
	C.remove_language(/datum/language/machine)
