/datum/language/buggy
	name = "Buggy"
	desc = "A barely comprehensible language, spoken by insectoid-like races."
	speech_verb = "flutters"
	ask_verb = "flits"
	exclaim_verb = "flaps"
	key = "m"
	flags = TONGUELESS_SPEECH
	space_chance = 10
	syllables = list(
		"brr", "bzz", "zzz", "zzp", "ziip", "buzz", "rrr", "skrk", "skr", "sk",
		"tsk","pzz", "tzzz", "pzt", "krrr"
	)
	icon = 'modular_skyrat/icons/misc/language.dmi'
	icon_state = "buzz"
	default_priority = 94
	restricted = TRUE
