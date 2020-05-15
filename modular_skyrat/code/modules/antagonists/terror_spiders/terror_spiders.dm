/datum/team/terror_spider
	name = "Terror Spiders"

//Simply lists them.
/datum/team/terror_spider/roundend_report()
	var/list/parts = list()
	parts += "<span class='header'>The [name] were:</span>"
	parts += printplayerlist(members)
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/antagonist/terror_spider
	name = "Terror Spider"
	job_rank = ROLE_TERROR_SPIDER
	show_in_antagpanel = FALSE
	var/datum/team/terror_spider/terror_spider_team
	threat = 3

/datum/antagonist/terror_spider/create_team(datum/team/terror_spider/new_team)
	if(!new_team)
		for(var/datum/antagonist/terror_spider/X in GLOB.antagonists)
			if(!X.owner || !X.terror_spider_team)
				continue
			terror_spider_team = X.terror_spider_team
			return
		terror_spider_team = new
	else
		if(!istype(new_team))
			CRASH("Wrong terror_spider team type provided to create_team")
		terror_spider_team = new_team

/datum/antagonist/terror_spider/get_team()
	return terror_spider_team

/mob/living/simple_animal/hostile/poison/terror_spider/mind_initialize()
	..()
	if(!mind.has_antag_datum(/datum/antagonist/terror_spider))
		mind.add_antag_datum(/datum/antagonist/terror_spider)
