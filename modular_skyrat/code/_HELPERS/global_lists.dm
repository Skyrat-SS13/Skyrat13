/proc/init_augments()
	for(var/path in subtypesof(/datum/aug_type))
		var/datum/aug_type/at = new path()
		at.cat_list = list()
		GLOB.aug_type_list[at.id] = at

	//Please dont hate me for copy pasta, this was a comfy way
	for(var/path in subtypesof(/datum/aug_category/limb))
		var/datum/aug_category/limb/aug_cat = new path()
		aug_cat.aug_list = list()
		GLOB.aug_type_list[aug_cat.aug_type].cat_list[aug_cat.id] = aug_cat
		for(var/path2 in subtypesof(aug_cat.children_path_type))
			var/datum/augmentation/limb/aug = new path2()
			GLOB.aug_type_list[aug.type_id].cat_list[aug.cat_id].aug_list[aug.id] = aug

	for(var/path in subtypesof(/datum/aug_category/organ))
		var/datum/aug_category/organ/aug_cat = new path()
		aug_cat.aug_list = list()
		GLOB.aug_type_list[aug_cat.aug_type].cat_list[aug_cat.id] = aug_cat
		for(var/path2 in subtypesof(aug_cat.children_path_type))
			var/datum/augmentation/organ/aug = new path2()
			GLOB.aug_type_list[aug.type_id].cat_list[aug.cat_id].aug_list[aug.id] = aug

	for(var/path in subtypesof(/datum/aug_category/implant))
		var/datum/aug_category/implant/aug_cat = new path()
		aug_cat.aug_list = list()
		GLOB.aug_type_list[aug_cat.aug_type].cat_list[aug_cat.id] = aug_cat
		for(var/path2 in subtypesof(aug_cat.children_path_type))
			var/datum/augmentation/implant/aug = new path2()
			GLOB.aug_type_list[aug.type_id].cat_list[aug.cat_id].aug_list[aug.id] = aug
