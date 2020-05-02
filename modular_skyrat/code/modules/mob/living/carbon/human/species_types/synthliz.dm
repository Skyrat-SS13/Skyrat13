/datum/species/synthliz
	species_traits = list(MUTCOLORS,NOTRANSSTING,EYECOLOR,LIPS,HAIR)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	exotic_bloodtype = "SY"

/datum/species/synthliz/on_species_gain(mob/living/carbon/human/C)
	..()
	C.grant_language(/datum/language/machine)

/datum/species/synthliz/on_species_loss(mob/living/carbon/human/C)
	..()
	C.remove_language(/datum/language/machine)
