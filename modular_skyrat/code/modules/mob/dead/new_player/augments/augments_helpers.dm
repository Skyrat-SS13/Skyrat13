/proc/GetAugment(type, cat, id)
	return GLOB.aug_type_list[type].cat_list[cat].aug_list[id]

/proc/GetAugmentCategory(type, cat)
	return GLOB.aug_type_list[type].cat_list[cat]

/proc/GetAugmentType(type)
	return GLOB.aug_type_list[type]

/proc/GetAugmentTypeList()
	return GLOB.aug_type_list 

/proc/ListOfPrefAugments(datum/preferences/prefs)
	var/augments = list()
	for(var/type_id in GLOB.aug_type_list)
		var/datum/aug_type/AUG_TYPE = GLOB.aug_type_list[type_id]
		for(var/cat_id in AUG_TYPE.cat_list)
			var/datum/augmentation/AUG = GetAugment(type_id, cat_id, prefs.augments[type_id][cat_id])
			augments += AUG
	return augments