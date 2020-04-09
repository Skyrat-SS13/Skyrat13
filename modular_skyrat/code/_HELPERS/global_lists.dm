/proc/init_advanced_customization()
	//Attributes
	for(var/path in subtypesof(/datum/attribute))
		var/datum/attribute/AT = new path()
		GLOB.attribute_list["[AT.id]"] = AT

	return
	//Skill categories
	for(var/path in subtypesof(/datum/skill_category))
		var/datum/skill_category/SC = new path()
		GLOB.skill_cat_list[SC.id] = SC

	//Skills
	for(var/path in subtypesof(/datum/skill))
		var/datum/skill/SK = new path()
		GLOB.skill_list[SK.id] = SK

	//Skills per category, helper list
	for(var/datum/skill_category/SC in GLOB.skill_cat_list)
		var/skill_list = list()
		for(var/datum/skill/SK)
			if(SK.cat_id == SC.id)
				skill_list += SK
		GLOB.skills_per_cat_list[SC.id] = skill_list

	//Augments - limbs
	for(var/path in subtypesof(/datum/aug_category/limb))
		var/datum/aug_category/limb/cat = new path()
		GLOB.aug_limb_cat_list[cat.id] = cat
		GLOB.aug_limb_list[cat.id] = list()
		for(var/path2 in subtypesof(cat.aug_type))
			var/datum/augmentation/limb/at = new path2()
			GLOB.aug_limb_list[cat.id][at.id] = at

	//Augments - implants
	for(var/path in subtypesof(/datum/aug_category/implant))
		var/datum/aug_category/implant/cat = new path()
		GLOB.aug_implant_cat_list[cat.id] = cat
		GLOB.aug_implant_list[cat.id] = list()
		for(var/path2 in subtypesof(cat.aug_type))
			var/datum/augmentation/implant/at = new path2()
			GLOB.aug_implant_list[cat.id][at.id] = at

	//Augments - organs
	for(var/path in subtypesof(/datum/aug_category/organ))
		var/datum/aug_category/organ/cat = new path()
		GLOB.aug_organ_cat_list[cat.id] = cat
		GLOB.aug_organ_list[cat.id] = list()
		for(var/path2 in subtypesof(cat.aug_type))
			var/datum/augmentation/organ/at = new path2()
			GLOB.aug_organ_list[cat.id][at.id] = at