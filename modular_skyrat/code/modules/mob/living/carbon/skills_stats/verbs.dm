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
		msg += "<span class='info'>I am <b>[skill.skillnumtodesc(skill.level)] ([skill.level])</b> at <b>[lowertext(skill.name)]</b>.</span><br>"
	
	msg += "<br>"

	msg += "<span class='info'>Let's check my physical capabilities...</span><br>"
	for(var/s in mind.mob_stats)
		var/datum/stats/stat = mind.mob_stats[s]
		msg += "<span class='info'>I have <b>[stat.statnumtodesc(stat.level)] ([stat.level])</b> <b>[lowertext(stat.name)] ([stat.shorthand])</b>.</span><br>"
	
	to_chat(usr, msg)
