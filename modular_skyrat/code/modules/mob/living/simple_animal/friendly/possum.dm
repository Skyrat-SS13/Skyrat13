/mob/living/simple_animal/friendly/possum
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
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = list(MOB_ORGANIC)
	gold_core_spawnable = FRIENDLY_SPAWN
	//var/held_icon = "possum"
	verb_say = "hisses"
	verb_ask = "hisses inquisitively"
	verb_exclaim = "hisses intensely"
	verb_yell = "shrieks intensely"

/mob/living/simple_animal/friendly/possum/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "hisses happily!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "hisses!", EMOTE_AUDIBLE)
	//AddElement(/datum/element/mob_holder, held_icon)

/mob/living/simple_animal/friendly/possum/poppy
	name = "Poppy the Safety Possum"
	desc = "Poppy has lived for a while, and is always here in their vest and hardhat to remind you of safety in the workplace."
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"
	//held_icon = "poppypossum"

/mob/living/simple_animal/friendly/possum/poppy/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "hisses happily!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "hisses!", EMOTE_AUDIBLE)
	//AddElement(/datum/element/mob_holder, held_icon)