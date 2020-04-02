/datum/species/human/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/language/solcommon)
	. = ..()