//Okay so this is dumb but hear me out, I want this system 100% super datum-fed
#define SKILL_CAT_GENERAL 1
#define SKILL_CAT_ORGANIZATION 2
#define SKILL_CAT_ENGINEERING 3
#define SKILL_CAT_MEDICAL 4
#define SKILL_CAT_RESEARCH 5
#define SKILL_CAT_SECURITY 6
#define SKILL_CAT_SERVICE 7

/datum/skill_category
	var/name = "Skill category"
	var/id = 0

/datum/skill_category/general
	name = "General"
	id = SKILL_CAT_GENERAL

/datum/skill_category/organization
	name = "Organization"
	id = SKILL_CAT_ORGANIZATION

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