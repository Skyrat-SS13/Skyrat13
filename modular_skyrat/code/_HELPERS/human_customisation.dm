/proc/GetAugment(type, cat, id)
	return GLOB.aug_type_list[type].cat_list[cat].aug_list[id]

/proc/GetAugmentCategory(type, cat)
	return GLOB.aug_type_list[type].cat_list[cat]

/proc/GetAugmentType(type)
	return GLOB.aug_type_list[type]

/proc/GetAugmentTypeList()
	return GLOB.aug_type_list