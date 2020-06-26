/datum/language/terrorspider
	name = "Terror Spider"
	desc = "Terror spiders have a limited ability to commune over a psychic hivemind, similar to xenomorphs."
	speech_verb = "chitters"
	ask_verb = "chitters"
	exclaim_verb = "chitters"
	sing_verb = "chitters"
	key = "ts"

/datum/language_holder/terror_spider
	understood_languages = list(/datum/language/terrorspider = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/terrorspider = list(LANGUAGE_ATOM))

/datum/language_holder/terror_spider_high
	understood_languages = list(/datum/language/terrorspider = list(LANGUAGE_ATOM),
								/datum/language/common = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/terrorspider = list(LANGUAGE_ATOM))
