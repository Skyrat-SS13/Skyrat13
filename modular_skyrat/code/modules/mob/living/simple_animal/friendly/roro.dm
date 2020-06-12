/mob/living/simple_animal/pet/roro
	name = "\improper roro"
	desc = "Its a Rorobot, strange meshes of biotechnology and robotics engineering."
	icon = 'modular_skyrat/icons/mob/roro.dmi'
	icon_state = "roro-living"
	icon_living = "roro-living"
	icon_dead = "roro-dead"
	gender = PLURAL
	mob_biotypes = MOB_ROBOTIC
	blood_volume = 0
	speak_emote = list("beeps")
	emote_hear = list("beeps happily.","lets out a cute chime.","boops and bloops.")
	emote_see = list("bops up and down.","looks around.","spins slowly.")
	speak_chance = 1.5
	turns_per_move = 10
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "moves aside"
	response_disarm_simple = "move aside"
	response_harm_continuous = "squishes"
	response_harm_simple = "squish"
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	pass_flags = PASSMOB
	ventcrawler = VENTCRAWLER_ALWAYS
	verb_say = "beeps"
	verb_ask = "beeps inquisitively"
	verb_exclaim = "buzzes"
	verb_yell = "loud-speaks"
	initial_language_holder = /datum/language_holder/synthetic
	bubble_icon = "machine"
	speech_span = SPAN_ROBOT
	deathmessage = "suddenly grows still, their eyes falling dark as their form deflates..."
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/roro/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "beeps happily!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "buzzes!", EMOTE_AUDIBLE)

/mob/living/simple_animal/pet/roro/roboticsroro
	name = "Roomba"
	desc = "Its Roomba! A lovable pet Rorobot from Robotics."
	icon_state = "roro-robotics-living"
	icon_living = "roro-robotics-living"
	gender = FEMALE
	gold_core_spawnable = NO_SPAWN
