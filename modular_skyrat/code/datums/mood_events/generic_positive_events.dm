//Masochist mood
/datum/mood_event/paingood
	description = "<span class='nicegreen'>Pain cleanses the mind and the soul.</span>\n"
	mood_change = 4
	timeout = 2 MINUTES

//Hydration
/datum/mood_event/wellhydrated
	description = "<span class='nicegreen'>I'm gonna burst!</span>\n"
	mood_change = 6

/datum/mood_event/hydrated
	description = "<span class='nicegreen'>I have recently had some water.</span>\n"
	mood_change = 3

/datum/mood_event/thirsty
	description = "<span class='warning'>I'm getting a bit thirsty.</span>\n"
	mood_change = -8

/datum/mood_event/dehydrated
	description = "<span class='boldwarning'>I'm dehydrated!</span>\n"
	mood_change = -15
