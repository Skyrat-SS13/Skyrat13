/datum/config_entry/flag/age_lock

/datum/config_entry/number/age_lock_days
	config_entry_value = 30

/datum/config_entry/number/cryo_min_ssd_time
	config_entry_value = 15

/datum/config_entry/number/wound_threshold_multiplier
	config_entry_value = 1

/datum/config_entry/string/wikiurlskyrat
	config_entry_value = "https://skyrat13.tk/wiki/index.php"

/datum/controller/configuration
	var/static/regex/ic_filter_regex //For the cringe filter.
	var/static/regex/punctuation_filter //For the punctuation forcing.

/datum/config_entry/cringe
	config_entry_value = list()
	postload_required = TRUE

/datum/config_entry/cringe/OnPostload()
	config_entry_value = LoadChatFilter()

/datum/config_entry/cringe/proc/LoadChatFilter()
	GLOB.in_character_filter = list()

	for(var/line in world.file2list("config/in_character_filter.txt"))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.in_character_filter += line

	if(!config.ic_filter_regex && length(GLOB.in_character_filter))
		config.ic_filter_regex = regex("\\b([jointext(GLOB.in_character_filter, "|")])\\b", "i")
	
	if(!config.punctuation_filter)
		var/list/punctuation = list(".", ",", "!", ";", "?")
		config.punctuation_filter = regex("\\b([jointext(punctuation, "|")])\\b", "i")

	return GLOB.in_character_filter
