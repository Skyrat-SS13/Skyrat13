/proc/prefix_a_or_an(text) //I swear there is a proc for this but I can't find it
	var/start = lowertext(text[1])
	if(!start)
		return "a"
	if(start == "a" || start == "e" || start == "i" || start == "o" || start == "u")
		return "an"
	else
		return "a"