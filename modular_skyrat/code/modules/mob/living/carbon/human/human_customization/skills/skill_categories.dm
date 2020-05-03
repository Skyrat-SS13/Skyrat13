//Okay so this is dumb but hear me out, I want this system 100% super datum-fed
#define SKILL_CAT_GENERAL "gen"
#define SKILL_CAT_ORGANIZATIONAL "org"
#define SKILL_CAT_ENGINEERING "eng"
#define SKILL_CAT_MEDICAL "med"
#define SKILL_CAT_RESEARCH "rnd"
#define SKILL_CAT_SECURITY "sec"
#define SKILL_CAT_SERVICE "serv"

/datum/skill_category
	var/name = "Skill category"
	var/id = 0
	var/skill_list = list()

/datum/skill_category/general
	name = "General"
	id = SKILL_CAT_GENERAL

/datum/skill_category/organizational
	name = "Organizational"
	id = SKILL_CAT_ORGANIZATIONAL

/datum/skill_category/engineering
	name = "Engineering"
	id = SKILL_CAT_ENGINEERING

/datum/skill_category/medical
	name = "Medical"
	id = SKILL_CAT_MEDICAL

/datum/skill_category/research
	name = "Research"
	id = SKILL_CAT_RESEARCH

/datum/skill_category/security
	name = "Security"
	id = SKILL_CAT_SECURITY

/datum/skill_category/service
	name = "Service"
	id = SKILL_CAT_SERVICE