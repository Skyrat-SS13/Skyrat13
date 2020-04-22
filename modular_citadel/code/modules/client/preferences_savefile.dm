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
	ooc_notes = sanitize_text(S["ooc_notes"])
	erppref = sanitize_text(S["erp_pref"], "Ask")
	if(!length(erppref)) erppref = "Ask"
	nonconpref = sanitize_text(S["noncon_pref"], "Ask")
	if(!length(nonconpref)) nonconpref = "Ask"
	vorepref = sanitize_text(S["vore_pref"], "Ask")
	if(!length(vorepref)) vorepref = "Ask"
	security_records = sanitize_text(S["security_records"])
	medical_records = sanitize_text(S["medical_records"])
	general_records = sanitize_text(S["general_records"])
	flavor_background = sanitize_text(S["flavor_background"])
	character_skills = sanitize_text(S["character_skills"])
	exploitable_info = sanitize_text(S["exploitable_info"])

	//Advanced character customization
	var/list/loaded_attribute_modifiers = SANITIZE_LIST(S["attribute_modifiers"])
	var/list/loaded_augments = SANITIZE_LIST(S["augments"])
	augments = list()

	message_admins("[length(GLOB.attribute_list)]")

	//Validation
	for(var/i in loaded_attribute_modifiers)
		var/datum/attribute/AT = GLOB.attribute_list[i]
		if(AT)
			attribute_modifiers[i] = loaded_attribute_modifiers[i]

			if(attribute_modifiers[i] > AT.add_max || attribute_modifiers[i] < AT.subtract_max)
				attribute_modifiers[i] = 0

	for(var/i in GLOB.attribute_list)
		var/datum/attribute/AT = GLOB.attribute_list[i]
		message_admins("[AT.id]")
		if(attribute_modifiers[AT.id] == null)
			message_admins("adding 0")
			attribute_modifiers[AT.id] = 0

	for(var/i in loaded_augments)
		if(GLOB.aug_type_list[i])
			augments[i] = list()

			var/loaded_cat_type_list = loaded_augments[i]
			for(var/b in loaded_cat_type_list)
				if(GLOB.aug_type_list[i].cat_list[b])
					var/aug_id = loaded_augments[i][b]
					if(aug_id in GLOB.aug_type_list[i].cat_list[b].aug_list)
						augments[i][b] = aug_id
					else
						augments[i][b] = "default"

	for(var/i in GLOB.aug_type_list)
		if(!(augments[i]))
			augments[i] = list()

		for(var/b in GLOB.aug_type_list[i].cat_list)
			if(!(augments[i][b]))
				augments[i][b] = "default"

	//Count used attributes
	var/used_att = 0
	for(var/i in attribute_modifiers)
		used_att = used_att + attribute_modifiers[i]
		message_admins("[i]")

	for(var/type_id in augments)
		var/aug_type_list = augments[type_id]

		for(var/cat_id in aug_type_list)
			var/cat_list = aug_type_list[cat_id]

			for(var/aug_id in cat_list)
				var/datum/augmentation/AUG = GetAugment(type_id,cat_id,aug_id)
				used_att = used_att + AUG.cost
				message_admins("[AUG.name]")

	message_admins("[used_att]")
	attribute_points = max_attribute_points - used_att
	//END OF SKYRAT CHANGES

	//gear loadout
	var/text_to_load
	S["loadout"] >> text_to_load
	var/list/saved_loadout_paths = splittext(text_to_load, "|")
	LAZYCLEARLIST(chosen_gear)
	gear_points = initial(gear_points)
	for(var/i in saved_loadout_paths)
		var/datum/gear/path = text2path(i)
		if(path)
			LAZYADD(chosen_gear, path)
			gear_points -= initial(path.cost)

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

	//SKYRAT CHANGES
	WRITE_FILE(S["ooc_notes"], ooc_notes)
	WRITE_FILE(S["erp_pref"], erppref)
	WRITE_FILE(S["noncon_pref"], nonconpref)
	WRITE_FILE(S["vore_pref"], vorepref)
	WRITE_FILE(S["security_records"], security_records)
	WRITE_FILE(S["medical_records"], medical_records)
	WRITE_FILE(S["general_records"], general_records)
	WRITE_FILE(S["flavor_background"], flavor_background)
	WRITE_FILE(S["character_skills"], character_skills)
	WRITE_FILE(S["exploitable_info"], exploitable_info)
	//Advanced character customization
	WRITE_FILE(S["attribute_modifiers"] , attribute_modifiers)

	WRITE_FILE(S["augments"] , augments)
	//END OF SKYRAT CHANGES

	//gear loadout
	if(islist(chosen_gear))
		if(chosen_gear.len)
			var/text_to_save = chosen_gear.Join("|")
			S["loadout"] << text_to_save
		else
			S["loadout"] << "" //empty string to reset the value
