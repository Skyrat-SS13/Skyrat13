/datum/speech_mod/auto_hiss
	soundtext = "hissing"

/datum/speech_mod/auto_hiss/handle_speech(datum/source, list/speech_args)
	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
	speech_args[SPEECH_MESSAGE] = message