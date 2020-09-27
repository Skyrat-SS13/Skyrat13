//Verb for checking your skills
/mob/verb/check_skillset()
	set name = "Check Skillset"
	set category = "IC"
	set desc = "Check your competence at various tasks."

	if(!mind)
		to_chat(usr, "<span class='warning'>How do you check the skills of [(usr == src)? "yourself when you are" : "something"] without a mind?</span>")
		return
	
	var/msg = "<span class='info'>Let's check my trained capabilities...</span><br>"
	for(var/s in mind.mob_skills)
		var/datum/skills/skill = mind.mob_skills[s]
		msg += "<span class='info'>I am <b>[skill.skillnumtodesc(skill.level)]</b> at <b>[lowertext(skill.name)]</b>.</span><br>"
	
	msg += "<br>"

	msg += "<span class='info'>Let's check my physical capabilities...</span><br>"
	for(var/s in mind.mob_stats)
		var/datum/stats/stat = mind.mob_stats[s]
		msg += "<span class='info'>I have <b>[stat.statnumtodesc(stat.level)]</b> <b>[lowertext(stat.name)] ([stat.shorthand])</b>.</span><br>"
	
	to_chat(usr, msg)

//Verb for selecting your skills and stats
/mob/verb/select_skillset()
	set name = "Select Skills"
	set category = "IC"
	set desc = "Use available stat and skill points to level up your abilities."

	if(!mind)
		to_chat(usr, "<span class='warning'>How do you check the skills of [(usr == src)? "yourself when you are" : "something"] without a mind?</span>")
		return

	if(mind.available_skill_points || mind.available_stat_points)
		to_chat(usr, "<span class='info'>I have <b>[mind.available_skill_points]</b> points to improve my abilities, \
					and <b>[mind.available_stat_points]</b> points to improve on my body, mind and soul.</span>")
		var/list/options = list("Improve Skill", "Improve Stat")
		var/option = input(usr, "What should i improve myself on?", "Reflection") as null|anything in options
		if(option)
			switch(option)
				if("Improve Skill")
					var/list/skills = list()
					for(var/s in mind.mob_skills)
						var/datum/skills/skill = mind.mob_skills[s]
						if(skill.level <= MAX_SKILL)
							skills[skill.name] = skill
					option = input(usr, "What skill should i improve on?", "Reflection") as null|anything in skills
					if(option)
						var/datum/skills/skill = skills[option]
						var/max_upgrade = MAX_SKILL - skill.level
						max_upgrade = min(mind.available_skill_points, max_upgrade)
						option = input(usr, "By how much? (Max: [max_upgrade])", "Reflection") as null|num
						if(option)
							option = min(max_upgrade, option)
							mind.available_skill_points -= option
							skill.level += option
							to_chat(usr, "<span class='info'>I've gained experience in <b>[lowertext(skill.name)]</b>.<br>I am now <b>[skill.skillnumtodesc(skill.level)]</b> at tasks related to it.</span>")
						else
							to_chat(usr, "<span class='info'>I refrain from wasting my acquired knowledge./span>")
					else
						to_chat(usr, "<span class='info'>I refrain from wasting my acquired knowledge./span>")
				if("Improve Stat")
					var/list/stats = list()
					for(var/s in mind.mob_stats)
						var/datum/stats/stat = mind.mob_stats[s]
						if(stat.level <= MAX_STAT)
							stats[stat.name] = stat
					option = input(usr, "What stat should i improve on?", "Reflection") as null|anything in stats
					if(option)
						var/datum/stats/stat = stats[option]
						var/max_upgrade = MAX_STAT - stat.level
						max_upgrade = min(mind.available_stat_points, max_upgrade)
						option = input(usr, "By how much? (Max: [max_upgrade])", "Reflection") as null|num
						if(option)
							option = min(max_upgrade, option)
							mind.available_stat_points -= option
							stat.level += option
							to_chat(usr, "<span class='info'>I've gained experience in <b>[lowertext(stat.name)]</b>.<br>I now have <b>[stat.statnumtodesc(stat.level)] [lowertext(stat.name)]</b>.</span>")
						else
							to_chat(usr, "<span class='info'>I refrain from wasting my acquired knowledge./span>")
					else
						to_chat(usr, "<span class='info'>I refrain from wasting my acquired knowledge./span>")
		else
			to_chat(usr, "<span class='info'>I refrain from wasting my acquired knowledge./span>")
	else
		to_chat(usr, "<span class='warning'>I do not have experiences or wisdom to reflect upon.</span>")
