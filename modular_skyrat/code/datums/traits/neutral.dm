/datum/quirk/gigantism
	name = "Gigantism"
	desc = "You are exceptionally big."
	value = 0
	mob_trait = TRAIT_GIGANTISM
	medical_record_text = "Patient's body is exceptionally large."

/datum/quirk/gigantism/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(1.25, 1.25)

/datum/quirk/gigantism/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(0.8, 0.8)