/mob/living/simple_animal/opossum
	name = "opossum"
	desc = "It's an opossum, a small scavenging marsupial."
	icon = 'modular_skyrat/icons/mob/animal.dmi'
	icon_state = "possum"
	icon_living = "possum"
	icon_dead = "possum_dead"
	turns_per_move = 3
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "stamps on"
	speak_emote = list("hisses")
	maxHealth = 60
	health = 60
	harm_intent_damage = 1
	friendly = "nudges"
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	ventcrawler = VENTCRAWLER_ALWAYS
	mob_size = MOB_SIZE_TINY
	mob_biotypes = list(MOB_ORGANIC)
	gold_core_spawnable = FRIENDLY_SPAWN
	verb_say = "hisses"
	verb_ask = "hisses inquisitively"
	verb_exclaim = "hisses intensely"
	verb_yell = "shrieks intensely"

/mob/living/simple_animal/opossum/poppy
	name = "Poppy the Safety Possum"
	desc = "After surviving 3 million years in North America before the war, what's a few more in radiation?"
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"