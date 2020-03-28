/mob/living/simple_animal/hostile/megafauna/colossus
	song = sound('modular_skyrat/sound/ambience/theopenedway.ogg', 100) //Shadow of the colossus OST
	songlength = 1170

/mob/living/simple_animal/hostile/megafauna/colossus/enrage(mob/living/L)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(H.mind)
			if(istype(H.mind.martial_art, /datum/martial_art/the_sleeping_carp) || istype(H.mind.martial_art, /datum/martial_art/the_rising_bass))
				. = TRUE
		if(is_species(H, /datum/species/golem/sand))
			. = TRUE