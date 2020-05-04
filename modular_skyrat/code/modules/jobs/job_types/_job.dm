/datum/job
	//Required skills - what are the skills required for someone's base skillset to unlock the job
	var/list/required_skills = list()
	//Recommended skills - Skills given to a job with unset preferences, important when you dont use locked skills
	var/list/recommended_skills = list()
	//Skill proficiencies - Skills that can be put extra points into the job loadout when you've unlocked the job
	var/list/skill_proficiencies = list()
	//How many extra skill gets does the job get to put into proficiences(which override the base maximum cap for a skill)?
	var/prof_skill_points = 0
	//Are skills disabled for the job? Important for sillycones and AI
	var/skills_disabled = FALSE

/datum/job/ai
	skills_disabled = TRUE

/datum/job/atmos
	required_skills = list(
	SKILL_ATMOS = SKILL_TRAINED,
	SKILL_CONSTRUCTION = SKILL_TRAINED)

	recommended_skills = list(
	SKILL_ATMOS = SKILL_EXPERIENCED,
	SKILL_CONSTRUCTION = SKILL_TRAINED,
	SKILL_ELECTRICAL = SKILL_TRAINED,
	SKILL_EVA = SKILL_TRAINED)

	skill_proficiencies = list(SKILL_ATMOS,SKILL_CONSTRUCTION,SKILL_ELECTRICAL,SKILL_EVA)

	prof_skill_points = 6

/datum/job/hydro
	recommended_skills = list(
	SKILL_BOTANY = SKILL_EXPERIENCED,
	SKILL_SCIENCE = SKILL_TRAINED)

	skill_proficiencies = list(SKILL_BOTANY, SKILL_SCIENCE, SKILL_CHEMISTRY)

	prof_skill_points = 6

/datum/job/chemist
	required_skills = list(
	SKILL_CHEMISTRY = SKILL_TRAINED,
	SKILL_MEDICINE = SKILL_TRAINED)

	recommended_skills = list(
	SKILL_CHEMISTRY = SKILL_EXPERIENCED,
	SKILL_MEDICINE = SKILL_TRAINED)

	skill_proficiencies = list(SKILL_CHEMISTRY, SKILL_MEDICINE, SKILL_SCIENCE)

	prof_skill_points = 6

/datum/job/chief_engineer
	required_skills = list(
	SKILL_ATMOS = SKILL_TRAINED,
	SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	SKILL_ELECTRICAL = SKILL_EXPERIENCED,
	SKILL_EVA = SKILL_TRAINED)

	recommended_skills = list(
	SKILL_ATMOS = SKILL_EXPERIENCED,
	SKILL_CONSTRUCTION = SKILL_EXPERIENCED,
	SKILL_ELECTRICAL = SKILL_EXPERIENCED,
	SKILL_EVA = SKILL_EXPERIENCED)

	skill_proficiencies = list(SKILL_ATMOS,SKILL_CONSTRUCTION,SKILL_ELECTRICAL,SKILL_EVA)

	prof_skill_points = 10

/datum/job/cook
	recommended_skills = list(
	SKILL_COOKING = SKILL_EXPERIENCED,
	SKILL_CLOSE_COMBAT = SKILL_TRAINED)

	skill_proficiencies = list(SKILL_COOKING, SKILL_CLOSE_COMBAT)

	prof_skill_points = 6