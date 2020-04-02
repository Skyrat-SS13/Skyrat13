/datum/species/shadow/nightmare/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.fully_replace_character_name(C.name,"[pick(GLOB.nightmare_names)]")

/datum/species/shadow/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/modular_skyrat/language/shadowtongue)