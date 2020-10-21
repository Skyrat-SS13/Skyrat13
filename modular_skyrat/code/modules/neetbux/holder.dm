/datum/preferences
	var/neetbux_amount = 0

/datum/preferences/proc/adjust_neetbux(amount, message)
	neetbux_amount += amount
	if(parent && message)
		to_chat(parent, "<span class='neetbux'>[message]</span>")
	return TRUE
