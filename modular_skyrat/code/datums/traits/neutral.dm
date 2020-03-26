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

/datum/quirk/manletism
	name = "Manlet"
	desc = "You are a bit... small. With none of the benefits."
	value = 0
	mob_trait = TRAIT_MANLET

/datum/quirk/manletism/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(0.9, 0.9)

/datum/quirk/manletism/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(1.1, 1.1)

/datum/quirk/tiny
	name = "Tiny"
	desc = "You are exceptionally small, without the agility of an actual dwarf."
	value = 0
	mob_trait = TRAIT_TINY

/datum/quirk/tiny/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(0.8, 0.8)

/datum/quirk/manletism/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(1.25, 1.25)