/datum/species/shadow/nightmare/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.fully_replace_character_name(C.name,"[pick(GLOB.nightmare_names)]")