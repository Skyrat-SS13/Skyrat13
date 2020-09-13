/obj/item/organ/tail/cat
	name = "cat tail"
	desc = "A severed cat tail. Who's wagging now?"
	tail_type = "Cat"

/obj/item/organ/tail/cat/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		if(!H.dna.species.mutant_bodyparts["mam_tail"])
			H.dna.species.mutant_bodyparts["mam_tail"] = tail_type
			H.dna.features["mam_tail"] = tail_type
			H.update_body()

/obj/item/organ/tail/cat/Remove(special = FALSE)
	if(!QDELETED(owner) && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.dna.features["mam_tail"] = "None"
		H.dna.species.mutant_bodyparts -= "mam_tail"
		color = H.hair_color
		H.update_body()
	return ..()
