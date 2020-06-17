/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	if(copytext_char(C.dna.features["spines"],1,4) == "Vox")
		C.dna.features["spines"] = "Short + Membrane" //Update body is called in the parent proc
	if(C.dna.features["legs"] == "Plantigrade")
		C.dna.features["legs"] = "Digitigrade"
	return ..()

/datum/species/lizard/ashwalker
	name = "Ash Walker"
	id = "ashlizard"
	limbs_id = "lizard"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,DIGITIGRADE,CAN_SCAR)
	inherent_traits = list(TRAIT_CHUNKYFINGERS)
	mutantlungs = /obj/item/organ/lungs/ashwalker
	mutanteyes = /obj/item/organ/eyes/night_vision
	burnmod = 0.7
	brutemod = 0.8
