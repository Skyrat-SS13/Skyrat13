/datum/speech_mod/impediment_rl
	soundtext = "mispronouncing \"r\" as \"l\""

/datum/speech_mod/impediment_rl/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "L")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "l")

/datum/speech_mod/impediment_lw
	soundtext = "mispronouncing \"l\" as \"w\""

/datum/speech_mod/impediment_rl/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "l", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "L", "w")

/datum/speech_mod/impediment_rw
	soundtext = "mispronouncing \"r\" as \"w\""

/datum/speech_mod/impediment_rw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "W")
