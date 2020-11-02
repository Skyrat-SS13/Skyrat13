/datum/speech_mod/auto_hiss
	soundtext = "hissing"

/datum/speech_mod/auto_hiss/handle_speech(datum/source, list/speech_args)
	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	var/static/regex/lizard_hiss_ru = new("с+", "п")
	var/static/regex/lizard_hiSS_ru = new("С+", "п")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
		message = lizard_hiss_ru.Replace(message, "ссс")
		message = lizard_hiSS_ru.Replace(message, "ССС")
	speech_args[SPEECH_MESSAGE] = message