/datum/antagonist/traitor/on_gain()
	. = ..()
	if(owner)
		for(var/datum/stats/stat in owner.mob_stats)
			stat.level = min(stat.level + 1, MAX_STAT)
		var/datum/skills/ranged/ranged = owner.mob_skills[SKILL_DATUM(ranged)]
		if(ranged)
			ranged.level = min(ranged.level + 5, MAX_SKILL)
