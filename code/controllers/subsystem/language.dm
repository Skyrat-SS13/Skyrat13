SUBSYSTEM_DEF(language)
	name = "Language"
	init_order = INIT_ORDER_LANGUAGE
	flags = SS_NO_FIRE

/datum/controller/subsystem/language/Initialize(timeofday)
	for(var/L in subtypesof(/datum/language))
		var/datum/language/language = L
		if(!initial(language.key))
			continue

		GLOB.all_languages += language

		var/datum/language/instance = new language

		GLOB.language_datum_instances[language] = instance

	return ..()

/datum/controller/subsystem/language/proc/AssignLanguage(mob/living/user, client/cli, spawn_effects, roundstart = FALSE, datum/job/job, silent = FALSE, mob/to_chat_target)
	var/list/my_lang = cli.prefs.language
	for(var/I in GLOB.all_languages)
		var/datum/language/L = GLOB.all_languages[I]
		if(!(my_lang == L.name))
			continue
		else
			if(!L.restricted)
				user.grant_language(L)
				to_chat(user, "<span class='notice'>You are able to speak in [my_lang]. If you're actually good at it or not, is up to you.</span>")
			else
				to_chat(user, "<span class='warning'>Uh oh. [my_lang] is a restricted language, and couldn't be assigned!</span>")
				to_chat(user, "<span class='warning'>This probably shouldn't be happening. Scream at Bob on #main-dev.</span>")
