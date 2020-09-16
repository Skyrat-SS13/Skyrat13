//Mob holders for stats and skills
//Every carbon mob spawns by default with average skills at everything
/mob/living/carbon
	var/list/mob_stats = list()
	var/list/mob_skills = list()

/mob/living/carbon/human/Stat(Name, Value)
	. = ..()
	if(statpanel("Status"))
		var/list/stats = list()
		for(var/i in mob_stats)
			var/datum/stats/mystat = mob_stats[i]
			stats += "[mystat.shorthand]: [mystat.level]"
		stat(null, "\n\n[stats.Join("\n\n")]\n\n")

/mob/living/carbon/Initialize()
	. = ..()
	InitializeStats()
	InitializeSkills()

/mob/living/carbon/Destroy()
	. = ..()
	//The defines for deleting lists weren't working, have some cumcode
	for(var/i in mob_stats)
		qdel(mob_stats[i])
		mob_stats[i] = null
	for(var/i in mob_skills)
		qdel(mob_skills[i])
		mob_skills[i] = null
	mob_stats = null
	mob_skills = null

/mob/living/carbon/proc/InitializeStats()
	for(var/thing in init_subtypes(/datum/stats))
		var/datum/stats/S = thing
		mob_stats[S.type] = S

/mob/living/carbon/proc/InitializeSkills()
	for(var/thing in init_subtypes(/datum/skills))
		var/datum/skills/S = thing
		mob_skills[S.type] = S
