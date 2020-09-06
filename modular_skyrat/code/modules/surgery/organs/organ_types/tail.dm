// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.

/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	var/tail_type = "None"
	maxHealth = 0.3 * STANDARD_ORGAN_THRESHOLD
	high_threshold = 0.2 * STANDARD_ORGAN_THRESHOLD	//threshold at 20
	low_threshold = 0.1 * STANDARD_ORGAN_THRESHOLD	//threshold at 10
	relative_size = 10 //tail damage doesn't do much

/obj/item/organ/tail/Remove(special = FALSE)
	if(owner?.dna?.species)
		owner.dna.species.stop_wagging_tail(owner)
	return ..()
