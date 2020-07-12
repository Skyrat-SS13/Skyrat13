/datum/language/calcic
	name = "Calcic"
	desc = "The disjointed and staccato language of plasmamen. Also understood by skeletons."
	speech_verb = "rattles"
	ask_verb = "queries"
	exclaim_verb = "screeches"
	whisper_verb = "clicks"
	sing_verb = "chimes"
	key = "q"
	flags = TONGUELESS_SPEECH
	space_chance = 10
	syllables = list(
		"k", "ck", "ack", "ick", "cl", "tk", "sk", "isk", "tak",
		"kl", "hs", "ss", "ks", "lk", "dk", "gk", "ka", "ska", "la", "pk",
    	"wk", "ak", "ik", "ip", "ski", "bk", "kb", "ta", "is", "it", "li", "di",
    	"ds", "ya", "sck", "crk", "hs", "ws", "mk", "aaa", "skraa", "skee", "hss",
		"raa", "klk", "tk", "stk", "clk"
	)
	icon = 'modular_skyrat/icons/misc/language.dmi'
	icon_state = "calcic"
	default_priority = 89
	restricted = TRUE
