/obj/item/organ/tongue/robot_ipc
	name = "robotic voicebox"
	desc = "A voice synthesizer that can interface with organic lifeforms."
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "tonguerobot"
	say_mod = "beeps"
	attack_verb = list("beeped", "booped")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	maxHealth = 100 //RoboTongue!
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/robot_ipc/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT 

//shitadel
/obj/item/organ/tongue/robot/ipc
	name = "positronic voicebox"
	say_mod = "beeps"
	desc = "A voice synthesizer used by IPCs to smoothly interface with organic lifeforms."
	electronics_magic = FALSE
	organ_flags = ORGAN_SYNTHETIC
