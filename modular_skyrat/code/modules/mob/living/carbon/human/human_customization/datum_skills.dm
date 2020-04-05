#define SKILL_UNSKILLED 1
#define SKILL_BASIC 2
#define SKILL_TRAINED 3
#define SKILL_EXPERIENCED 4
#define SKILL_MASTER 5

/datum/skill
	var/name = "Skill"
	var/desc = "Skill's description."
	var/id = 0
	var/cat_id = 0
	var/level_names = list()