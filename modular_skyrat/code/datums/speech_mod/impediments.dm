/datum/speech_mod/impediment_rl
	soundtext = "mispronouncing \"r\" as \"l\""

/datum/speech_mod/impediment_rl/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "l")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "L")

/datum/speech_mod/impediment_lw
	soundtext = "mispronouncing \"l\" as \"w\""

/datum/speech_mod/impediment_lw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "l", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "L", "W")

/datum/speech_mod/impediment_rw
	soundtext = "mispronouncing \"r\" as \"w\""

/datum/speech_mod/impediment_rw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "W")

/datum/speech_mod/impediment_rw_lw
	soundtext = "mispronouncing \"r\" and \"l\" as \"w\""

/datum/speech_mod/impediment_rw_lw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "W")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "l", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "L", "W")

//the speech mod below is used for character setup speech impediments
/datum/speech_mod/custom
	soundtext = "speaking differently."
	var/list/replacers = list() //the speech impediment will apply by lists. Example: list(list("n", "m")) will replace lowercase n with lowercase m
	var/list/ignored_languages = list() //the speech impediment will apply to every language except these, provided it's not empty
	var/list/exclusive_languages = list() //the speech impediment will only apply to these, provided it's not empty
	var/list/speech_spans = list() //the speech impediment will apply these spans to every message

/datum/speech_mod/custom/handle_speech(datum/source, list/speech_args)
	if(exclusive_languages.len && !(speech_args[SPEECH_LANGUAGE] in exclusive_languages))
		return
	if(ignored_languages.len && (speech_args[SPEECH_LANGUAGE] in ignored_languages))
		return
	for(var/pog in replacers)
		var/list/poggers = replacers[pog]
		if(poggers[3] == "strong")
			speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], poggers[1], poggers[2])
			speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], capitalize(poggers[1]), capitalize(poggers[2]))
			speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], uppertext(poggers[1]), uppertext(poggers[2]))
			speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], lowertext(poggers[1]), lowertext(poggers[2]))
		else
			speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], poggers[1], poggers[2])
	for(var/pogchamp in speech_spans)
		speech_args[SPEECH_SPANS] |= speech_spans[pogchamp]

