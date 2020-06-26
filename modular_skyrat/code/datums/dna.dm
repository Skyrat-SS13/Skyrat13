/mob/proc/can_mutate()
	return FALSE

/mob/living/carbon/can_mutate()
	return !(NO_DNA_COPY in dna.species.species_traits)
