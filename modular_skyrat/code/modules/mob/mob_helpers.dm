/proc/Muddleler(text, replace_characters = FALSE, chance = 50)
	text = html_decode(text)
	. = ""
	var/rawchar = ""
	var/letter = ""
	var/lentext = length(text)
	for(var/i = 1, i <= lentext, i += length(rawchar))
		rawchar = letter = text[i]
		if(prob(chance))
			if(replace_characters)
				letter = ""
			for(var/j in 1 to rand(0, 2))
				letter += pick("Z", "Z", "Z", "Z", "z", "z", "z", "z", "z", "x", "x", "x", "x", "X", "X", "X", "X")
		. += letter
	return sanitize(.)