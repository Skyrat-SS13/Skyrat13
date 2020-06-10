/mob/living/simple_animal/pet/fizz
	name = "Fizz"
	desc = "Its a scale version prototype Buzz!"
	icon = 'modular_skyrat/icons/mecha/mecha.dmi'
	icon_state = "buzz"
	icon_living = "buzz"
	icon_dead = "buzz-broken"
	mob_biotypes = MOB_ROBOTIC
	blood_volume = 0
	speak_emote = list("beeps")
	emote_hear = list("stomps around.","adjusts to the air pressure.","demands a yellow core!")
	emote_see = list("drills the floor.","scans for ruins.","cycles equipment.","requests a GPS.")
	speak_chance = 1.5
	turns_per_move = 10
	harm_intent_damage = 10
	response_help_continuous = "pats"
	response_help_simple = "pat"
	response_disarm_continuous = "moves aside"
	response_disarm_simple = "move aside"
	response_harm_continuous = "smashes"
	response_harm_simple = "smash"
	attack_verb_continuous = "drills"
	attack_verb_simple = "drill"
	attack_sound = 'sound/weapons/bite.ogg'
	pass_flags = PASSMOB
	verb_say = "states"
	verb_ask = "queries"
	verb_exclaim = "alarms"
	verb_yell = "blares"
	initial_language_holder = /datum/language_holder/synthetic
	bubble_icon = "machine"
	speech_span = SPAN_ROBOT
	deathmessage = "suddenly falls to it's knees, the joints failing as it's power fades..."
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/fizz/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "pumps it's arms in the air!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "buzzes!", EMOTE_AUDIBLE)

/mob/living/simple_animal/pet/fizz/Initialize()
	. = ..()
	resize = 0.70
	update_transform()

/mob/living/simple_animal/pet/fizz/roboticsfizz
	name = "Fizz"
	desc = "Its a scale version prototype Buzz!"
	icon_state = "buzz"
	icon_living = "buzz"
	gold_core_spawnable = NO_SPAWN