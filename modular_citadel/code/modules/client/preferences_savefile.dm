/datum/preferences/proc/cit_character_pref_load(savefile/S)
	//ipcs
	S["feature_ipc_screen"] >> features["ipc_screen"]
	S["feature_ipc_antenna"] >> features["ipc_antenna"]

	features["ipc_screen"] 	= sanitize_inlist(features["ipc_screen"], GLOB.ipc_screens_list)
	features["ipc_antenna"] 	= sanitize_inlist(features["ipc_antenna"], GLOB.ipc_antennas_list)
	//Citadel
	features["flavor_text"]		= sanitize_text(features["flavor_text"], initial(features["flavor_text"]))
	if(!features["mcolor2"] || features["mcolor"] == "#000")
		features["mcolor2"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	if(!features["mcolor3"] || features["mcolor"] == "#000")
		features["mcolor3"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	features["mcolor2"]	= sanitize_hexcolor(features["mcolor2"], 3, 0)
	features["mcolor3"]	= sanitize_hexcolor(features["mcolor3"], 3, 0)
	//SKYRAT CHANGES
	S["enable_personal_chat_color"]			>> enable_personal_chat_color
	S["personal_chat_color"]			>> personal_chat_color

	S["feature_ipc_chassis"] >> features["ipc_chassis"]

	S["alt_titles_preferences"]			>> alt_titles_preferences
	alt_titles_preferences = SANITIZE_LIST(alt_titles_preferences)
	if(SSjob)
		for(var/datum/job/job in sortList(SSjob.occupations, /proc/cmp_job_display_asc))
			if(alt_titles_preferences[job.title])
				if(!(alt_titles_preferences[job.title] in job.alt_titles))
					alt_titles_preferences.Remove(job.title)

	features["ipc_chassis"] 	= sanitize_inlist(features["ipc_chassis"], GLOB.ipc_chassis_list)
	// SKYRAT CHANGE START
	skyrat_ooc_notes = sanitize_text(S["skyrat_ooc_notes"])
	skyrat_ooc_notes = strip_html_simple(skyrat_ooc_notes, MAX_FLAVOR_LEN, TRUE)
	// SKYRAT CHANGE END
	erppref = sanitize_text(S["erp_pref"], "Ask")
	if(!length(erppref)) erppref = "Ask"
	nonconpref = sanitize_text(S["noncon_pref"], "Ask")
	if(!length(nonconpref)) nonconpref = "Ask"
	vorepref = sanitize_text(S["vore_pref"], "Ask")
	if(!length(vorepref)) vorepref = "Ask"
	extremepref = sanitize_text(S["extremepref"], "No") //god has forsaken me
	if(!length(extremepref))
		extremepref = "No"
	extremeharm = sanitize_text(S["extremeharm"], "No")
	if(!length(extremeharm) || (extremepref = "No"))
		extremeharm = "No"
	security_records = sanitize_text(S["security_records"])
	medical_records = sanitize_text(S["medical_records"])
	general_records = sanitize_text(S["general_records"])
	flavor_background = sanitize_text(S["flavor_background"])
	flavor_faction = sanitize_text(S["flavor_faction"])
	character_skills = sanitize_text(S["character_skills"])
	exploitable_info = sanitize_text(S["exploitable_info"])
	enable_personal_chat_color	= sanitize_integer(enable_personal_chat_color, 0, 1, initial(enable_personal_chat_color))
	personal_chat_color	= sanitize_hexcolor(personal_chat_color, 6, 1, "#FFFFFF")
	foodlikes = SANITIZE_LIST(S["foodlikes"])
	if(foodlikes.len > maxlikes)
		foodlikes.Cut(maxlikes+1)
	fooddislikes = SANITIZE_LIST(S["fooddislikes"])
	if(fooddislikes.len > maxdislikes)
		fooddislikes.Cut(maxdislikes+1)

	//Moves over the previous OOC notes to our ooc notes
	if(length(features["ooc_notes"]) > length(skyrat_ooc_notes))
		skyrat_ooc_notes = features["ooc_notes"]
		features["ooc_notes"] = ""
	//END OF SKYRAT CHANGES

/datum/preferences/proc/cit_character_pref_save(savefile/S)
	//ipcs
	WRITE_FILE(S["feature_ipc_screen"], features["ipc_screen"])
	WRITE_FILE(S["feature_ipc_antenna"], features["ipc_antenna"])
	//Citadel
	WRITE_FILE(S["feature_genitals_use_skintone"], features["genitals_use_skintone"])
	WRITE_FILE(S["feature_mcolor2"], features["mcolor2"])
	WRITE_FILE(S["feature_mcolor3"], features["mcolor3"])
	WRITE_FILE(S["feature_mam_body_markings"], features["mam_body_markings"])
	WRITE_FILE(S["feature_mam_tail"], features["mam_tail"])
	WRITE_FILE(S["feature_mam_ears"], features["mam_ears"])
	WRITE_FILE(S["feature_mam_tail_animated"], features["mam_tail_animated"])
	WRITE_FILE(S["feature_taur"], features["taur"])
	WRITE_FILE(S["feature_mam_snouts"],	features["mam_snouts"])
	//Xeno features
	WRITE_FILE(S["feature_xeno_tail"], features["xenotail"])
	WRITE_FILE(S["feature_xeno_dors"], features["xenodorsal"])
	WRITE_FILE(S["feature_xeno_head"], features["xenohead"])
	//flavor text
	WRITE_FILE(S["feature_flavor_text"], features["flavor_text"])
	WRITE_FILE(S["silicon_feature_flavor_text"], features["silicon_flavor_text"])
	
	//SKYRAT CHANGES
	WRITE_FILE(S["feature_ipc_chassis"], features["ipc_chassis"])
	WRITE_FILE(S["skyrat_ooc_notes"], skyrat_ooc_notes)
	WRITE_FILE(S["erp_pref"], erppref)
	WRITE_FILE(S["noncon_pref"], nonconpref)
	WRITE_FILE(S["vore_pref"], vorepref)
	WRITE_FILE(S["extremepref"], extremepref)
	WRITE_FILE(S["extremeharm"], extremeharm)
	WRITE_FILE(S["security_records"], security_records)
	WRITE_FILE(S["medical_records"], medical_records)
	WRITE_FILE(S["general_records"], general_records)
	WRITE_FILE(S["flavor_background"], flavor_background)
	WRITE_FILE(S["flavor_faction"], flavor_faction)
	WRITE_FILE(S["character_skills"], character_skills)
	WRITE_FILE(S["exploitable_info"], exploitable_info)
	WRITE_FILE(S["enable_personal_chat_color"], enable_personal_chat_color)
	WRITE_FILE(S["personal_chat_color"], personal_chat_color)
	WRITE_FILE(S["alt_titles_preferences"], alt_titles_preferences)
	WRITE_FILE(S["foodlikes"], foodlikes)
	WRITE_FILE(S["fooddislikes"], fooddislikes)
	//END OF SKYRAT CHANGES
