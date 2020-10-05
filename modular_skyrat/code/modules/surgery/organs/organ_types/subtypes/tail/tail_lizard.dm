
/obj/item/organ/tail/lizard
	name = "lizard tail"
	desc = "A severed lizard tail. Somewhere, no doubt, a lizard hater is very pleased with themselves."
	color = "#116611"
	tail_type = "Smooth"
	var/spines = "None"

/obj/item/organ/tail/lizard/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		// Checks here are necessary so it wouldn't overwrite the tail of a lizard it spawned in
		if(!H.dna.species.mutant_bodyparts["tail_lizard"])
			H.dna.features["tail_lizard"] = tail_type
			H.dna.species.mutant_bodyparts["tail_lizard"] = tail_type

		if(!H.dna.species.mutant_bodyparts["spines"])
			H.dna.features["spines"] = spines
			H.dna.species.mutant_bodyparts["spines"] = spines
		H.update_body()

/obj/item/organ/tail/lizard/Remove(special = FALSE)
	if(!QDELETED(owner) && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.dna.species.mutant_bodyparts -= "tail_lizard"
		H.dna.species.mutant_bodyparts -= "spines"
		color = "#" + H.dna.features["mcolor"]
		tail_type = H.dna.features["tail_lizard"]
		spines = H.dna.features["spines"]
		H.update_body()
	return ..()
