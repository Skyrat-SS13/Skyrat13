/datum/preferences
	var/bobux_amount = 0

/datum/preferences/proc/adjust_bobux(amount, message)
	bobux_amount += amount
	if(parent && message)
		to_chat(parent, "<span class='bobux'>[message]</span>")
	save_preferences()
	return TRUE
