/obj/item/organ/tongue/lizard/
	modifies_speech = FALSE

/obj/item/organ/tongue/lizard/handle_speech(datum/source, list/speech_args)

/mob/living/proc/handle_autohiss(mob/living/carbon/speaker, list/speech_args)
	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
	speech_args[SPEECH_MESSAGE] = message

/mob/living/carbon/human/var/auto_hiss = FALSE

/mob/living/carbon/human/proc/toggle_hiss()
	if(auto_hiss)
		RegisterSignal(src, COMSIG_MOB_SAY, .proc/handle_autohiss)
	else
		UnregisterSignal(src, COMSIG_MOB_SAY, .proc/handle_autohiss)

/mob/living/carbon/human/verb/toggle_auto_hiss()
	set name = "Toggle Auto-Hiss"
	set category = "IC"
	
	auto_hiss = !auto_hiss
	to_chat(src, "You [auto_hiss?"start":"stop"] hissing.")
	toggle_hiss()
