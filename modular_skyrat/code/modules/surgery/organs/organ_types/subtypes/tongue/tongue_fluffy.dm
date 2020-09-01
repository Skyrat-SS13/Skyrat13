/obj/item/organ/tongue/fluffy
	name = "fluffy tongue"
	desc = "OwO what's this?"
	icon_state = "tonguefluffy"
	taste_sensitivity = 10 // extra sensitive and inquisitive uwu
	maxHealth = 35 //Sensitive tongue!
	modifies_speech = TRUE

/obj/item/organ/tongue/fluffy/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "ne", "nye")
		message = replacetext(message, "nu", "nyu")
		message = replacetext(message, "na", "nya")
		message = replacetext(message, "no", "nyo")
		message = replacetext(message, "ove", "uv")
		message = replacetext(message, "l", "w")
		message = replacetext(message, "r", "w")
	message = lowertext(message)
	speech_args[SPEECH_MESSAGE] = message
