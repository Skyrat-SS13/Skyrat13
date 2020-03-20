/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	if(copytext_char(C.dna.features["spines"],1,4) == "Vox")
		C.dna.features["spines"] = "Short + Membrane" //Update body is called in the parent proc
	if(C.dna.features["legs"] == "Plantigrade")
		C.dna.features["legs"] = "Digitigrade"
	return ..()