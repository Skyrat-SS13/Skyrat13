/datum/saymode/terror_spider
	key = MODE_KEY_TERROR_SPIDER
	mode = MODE_TERROR_SPIDER

/datum/saymode/terror_spider/handle_message(mob/living/user, message, datum/language/language)
	if(user.terror_spider_check())
		hivemind_message(user, message)

	return FALSE

/datum/saymode/terror_spider/proc/hivemind_message(mob/living/user, message)
	user.log_talk(message, LOG_SAY)
	message = trim(message)
	if(!message)
		return

	var/message_a = user.say_quote(message)
	var/rendered = "<i><span class='terrorspider'>Hivemind, <span class='name'>[user.real_name]</span> <span class='message'>[message_a]</span></span></i>"
	for(var/mob/S in GLOB.player_list)
		if(!S.stat && S.terror_spider_check())
			to_chat(S, rendered)
		if(S in GLOB.dead_mob_list)
			var/link = FOLLOW_LINK(S, src)
			to_chat(S, "[link] [rendered]")