make_datum_references_lists()
	//Attributes
	for(var/path in subtypesof(/datum/attribute))
		var/datum/attribute/AT = new path()
		GLOB.attribute_list[AT.id] = path

	//Skill categories
	for(var/path in subtypesof(/datum/skill_category))
		var/datum/skill_category/SC = new path()
		GLOB.skill_cat_list[SC.id] = path

	//Skills
	for(var/path in subtypesof(/datum/skill))
		var/datum/skill/SK = new path()
		GLOB.skill_list[SK.id] = path

	//Skills per category, helper list
	for(var/datum/skill_category/SC in GLOB.skill_cat_list)
		var/skill_list = list()
		for(var/datum/skill/SK)
			if(SK.cat_id == SC.id)
				skill_list += SK
		GLOB.skills_per_cat_list[SC.id] = skill_list

	. = ..()