/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	. = ..()
	quirk_blacklist += list("Speech impediment (r as l)","Speech impediment (l as w)","Speech impediment (r as w)", "Speech impediment (r and l as w)")

