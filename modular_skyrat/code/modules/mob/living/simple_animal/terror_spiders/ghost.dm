/mob/living/simple_animal/hostile/poison/terror_spider/Topic(href, href_list)
	if(href_list["activate"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			humanize_spider(ghost)

/mob/living/simple_animal/hostile/poison/terror_spider/attack_ghost(mob/user)
	humanize_spider(user)

/mob/living/simple_animal/hostile/poison/terror_spider/proc/humanize_spider(mob/user)
	if(key)//Someone is in it
		return
	var/error_on_humanize = ""
	var/humanize_prompt = "Take direct control of [src]?"
	humanize_prompt += " Role: [spider_role_summary]"
	if(user.ckey in GLOB.ts_ckey_blacklist)
		error_on_humanize = "You are not able to control any terror spider this round."
	else if(!ai_playercontrol_allowtype)
		error_on_humanize = "This specific type of terror spider is not player-controllable."
	else if(degenerate)
		error_on_humanize = "Dying spiders are not player-controllable."
	else if(stat == DEAD)
		error_on_humanize = "Dead spiders are not player-controllable."

	if(isobserver(user))
		var/mob/dead/observer/O = user
		if(!O.can_reenter_round())
			return

	if(jobban_isbanned(user, ROLE_SYNDICATE) || jobban_isbanned(user, ROLE_ALIEN))
		to_chat(user,"You are jobbanned from role of syndicate and/or alien lifeform.")
		return
		
	if(error_on_humanize == "")
		var/spider_ask = alert(humanize_prompt, "Join as Terror Spider?", "Yes", "No")
		if(spider_ask == "No" || !src || QDELETED(src))
			return
	else
		to_chat(user, "Cannot inhabit spider: [error_on_humanize]")
		return
	if(key)
		to_chat(user, "<span class='notice'>Someone else already took this spider.</span>")
		return

	key = user.key
	log_game("[key_name(user)] became [src]")
	
	for(var/mob/dead/observer/G in GLOB.player_list)
		var/link = FOLLOW_LINK(G, src)
		G.show_message("<i>A ghost has taken control of <b>[src]</b>. ([link]).</i>")
