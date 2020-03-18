/datum/mind
	///Assoc list of skills - level
	var/list/known_skills = list()
	///Assoc list of skills - exp
	var/list/skill_experience = list()

/datum/mind/proc/adjust_experience(skill, amt, silent = FALSE)
	var/datum/skill/S = GetSkillRef(skill)
	skill_experience[S] = max(0, skill_experience[S] + amt) //Prevent going below 0
	var/old_level = known_skills[S]
	switch(skill_experience[S])
		if(SKILL_EXP_LEGENDARY to INFINITY)
			known_skills[S] = SKILL_LEVEL_LEGENDARY
		if(SKILL_EXP_MASTER to SKILL_EXP_LEGENDARY)
			known_skills[S] = SKILL_LEVEL_MASTER
		if(SKILL_EXP_EXPERT to SKILL_EXP_MASTER)
			known_skills[S] = SKILL_LEVEL_EXPERT
		if(SKILL_EXP_JOURNEYMAN to SKILL_EXP_EXPERT)
			known_skills[S] = SKILL_LEVEL_JOURNEYMAN
		if(SKILL_EXP_APPRENTICE to SKILL_EXP_JOURNEYMAN)
			known_skills[S] = SKILL_LEVEL_APPRENTICE
		if(SKILL_EXP_NOVICE to SKILL_EXP_APPRENTICE)
			known_skills[S] = SKILL_LEVEL_NOVICE
		if(0 to SKILL_EXP_NOVICE)
			known_skills[S] = SKILL_LEVEL_NONE
	if(isnull(old_level) || known_skills[S] == old_level)
		return //same level or we just started earning xp towards the first level.
	if(known_skills[S] == old_level)
		return //same level
	if(silent)
		return
	if(known_skills[S] >= old_level)
		to_chat(current, "<span class='nicegreen'>I feel like I've become more proficient at [S.name]!</span>")
	else
		to_chat(current, "<span class='warning'>I feel like I've become worse at [S.name]!</span>")

///Gets the skill's singleton and returns the result of its get_skill_modifier
/datum/mind/proc/get_skill_modifier(skill, modifier)
	var/datum/skill/S = GetSkillRef(skill)
	return S.get_skill_modifier(modifier, known_skills[S] || SKILL_LEVEL_NONE)

/datum/mind/proc/get_skill_level(skill)
	var/datum/skill/S = GetSkillRef(skill)
	return known_skills[S] || SKILL_LEVEL_NONE

/datum/mind/proc/print_levels(user)
	var/list/shown_skills = list()
	for(var/i in known_skills)
		if(known_skills[i]) //Do we actually have a level in this?
			shown_skills += i
	if(!length(shown_skills))
		to_chat(user, "<span class='notice'>You don't seem to have any particularly outstanding skills.</span>")
		return
	var/msg = ""
	msg += "<span class='info'>*---------*\n<EM>Your skills</EM></span>\n<span class='notice'>"
	for(var/i in shown_skills)
		var/datum/skill/S = i
		msg += "[i] - [SSskills.level_names[known_skills[S]]]\n"
	msg += "</span>"
	to_chat(user, msg)