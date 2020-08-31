//Mom get the epipen quirk
/datum/mood_event/allergyshock
	description = "<span class='userdanger'>WHERE IS THE EPI PEN?!?!</span>\n"
	mood_change = -25
	timeout = 10 SECONDS

//Cloned somebody else
/datum/mood_event/clooner
	description = "<span class='boldwarning'>Was cloning them really my last option?</span>\n"
	mood_change = -15
	timeout = 15 MINUTES

//Got cloned recently
/datum/mood_event/clooned
	description = "<span class='boldwarning'>Awake... but at what cost?</span>\n"
	mood_change = -10
	timeout = 15 MINUTES
