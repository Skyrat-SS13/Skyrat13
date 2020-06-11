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

/datum/speech_mod/impediment_japanese
	soundtext = "speaking like a space ninja"

/datum/speech_mod/impediment_japanese/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		var/list/temp_message = splittext(message, " ")
		var/list/pick_list = list()
		for(var/i in 1 to temp_message.len)
			pick_list += i
		for(var/i in 1 to abs(temp_message.len/3))
			var/H = pick(pick_list)
			if(findtext(temp_message[H], "*") || findtext(temp_message[H], ";") || findtext(temp_message[H], ":"))
				continue
			temp_message[H] = ninjaspeak(temp_message[H])
			pick_list -= H
		message = temp_message.Join(" ")

		//The Alternate speech mod is now the main one.
		message = replacetext(message, "l", "r")
		message = replacetext(message, "rr", "ru")
		message = replacetext(message, "v", "b")
		message = replacetext(message, "f", "hu")
		message = replacetext(message, "'t", "")
		message = replacetext(message, "t ", "to ")
		message = replacetext(message, " I ", " ai ")
		message = replacetext(message, "th", "z")
		message = replacetext(message, "is", "izu")
		message = replacetext(message, "ziz", "zis")
		message = replacetext(message, "se", "su")
		message = replacetext(message, "br", "bur")
		message = replacetext(message, "ry", "ri")
		message = replacetext(message, "you", "yuu")
		message = replacetext(message, "ck", "cku")
		message = replacetext(message, "eu", "uu")
		message = replacetext(message, "ow", "au")
		message = replacetext(message, "are", "aa")
		message = replacetext(message, "ay", "ayu")
		message = replacetext(message, "ea", "ii")
		message = replacetext(message, "ch", "chi")
		message = replacetext(message, "than", "sen")
		message = replacetext(message, ".", "")
		message = lowertext(message)
		speech_args[SPEECH_MESSAGE] = message