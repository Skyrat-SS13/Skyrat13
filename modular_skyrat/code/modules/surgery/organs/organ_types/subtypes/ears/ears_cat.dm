/obj/item/organ/ears/cat
	name = "cat ears"
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "kitty"
	damage_multiplier = 2

/obj/item/organ/ears/cat/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		color = H.hair_color
		H.dna.species.mutant_bodyparts["mam_ears"] = "Cat"
		H.dna.features["mam_ears"] = "Cat"
		H.update_body()

/obj/item/organ/ears/cat/Remove(special = FALSE)
	if(!QDELETED(owner) && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		color = H.hair_color
		H.dna.features["mam_ears"] = "None"
		H.dna.species.mutant_bodyparts -= "mam_ears"
		H.update_body()
	return ..()
