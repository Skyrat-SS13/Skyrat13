/obj/item/organ/tongue/lizard/
	modifies_speech = FALSE

/obj/item/organ/tongue/lizard/handle_speech(datum/source, list/speech_args)

/obj/item/organ/tongue/robot_ipc
	name = "robotic voicebox"
	desc = "A voice synthesizer that can interface with organic lifeforms."
	status = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "beeps"
	attack_verb = list("beeped", "booped")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	maxHealth = 100 //RoboTongue!
	var/electronics_magic = TRUE
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/robot_ipc/can_speak_in_language(datum/language/dt)
	return ..() || electronics_magic

/obj/item/organ/tongue/robot_ipc/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT