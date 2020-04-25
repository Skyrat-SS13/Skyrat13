SUBSYSTEM_DEF(language)
	name = "Language"
	init_order = INIT_ORDER_LANGUAGE
	flags = SS_NO_FIRE
	var/list/blacklistedlanguages = list(/datum/language/aphasia, /datum/language/drone,\
									/datum/language/codespeak, /datum/language/common,\
									/datum/language/machine, /datum/language/monkey,\
									/datum/language/mushroom, /datum/language/narsie,\
									/datum/language/ratvar, /datum/language/slime,\
									/datum/language/swarmer, /datum/language/vampiric,\
									/datum/language/xenocommon, /datum/language/vox,\
									)
	var/list/accepted_languages = list()
	var/list/accepted_languages_names = list()
	var/list/accepted_languages_associated = list()

/datum/controller/subsystem/language/Initialize(timeofday)
	for(var/L in subtypesof(/datum/language))
		var/datum/language/language = L
		if(!initial(language.key))
			continue

		GLOB.all_languages += language

		var/datum/language/instance = new language

		GLOB.language_datum_instances[language] = instance

		if(!(language in blacklistedlanguages))
			accepted_languages += language
			accepted_languages_names += instance.name
			accepted_languages_associated[instance.name] = language

	return ..()

/datum/controller/subsystem/language/proc/assignlanguages(var/mob/polyglot, client/cli)
	if(!CONFIG_GET(number/additional_languages) || !cli)
		return
	else
		if(cli.prefs.language1)
			var/datum/language/L = accepted_languages_associated[cli.prefs.language1]
			if(L)
				polyglot.grant_language(L)
		if(cli.prefs.language2)
			var/datum/language/L = accepted_languages_associated[cli.prefs.language2]
			if(L)
				polyglot.grant_language(L)
		if(cli.prefs.language3)
			var/datum/language/L = accepted_languages_associated[cli.prefs.language3]
			if(L)
				polyglot.grant_language(L)
