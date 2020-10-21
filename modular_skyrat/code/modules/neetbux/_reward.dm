//base neetbux reward datum
/datum/neetbux_reward
	var/name = "YOU SHOULDNT BE READING THIS"
	var/desc = "THIS SHOULDNT BE READ EITHER"
	var/buy_message = "YOU SHOULDNT BE BUYING THIS"
	var/id = "FUCK"
	var/cost = 1
	var/unbuyable = FALSE //Used for "rewards" that you don't buy, but rather gain by the subsystem
	//Will mostly be used for negative stuff for people that have a negative neetbux balance

//do the stuff that happens when you buy the reward here wahoo
/datum/neetbux_reward/proc/on_buy(client/neet)
	. = TRUE
	if(ismob(neet))
		var/mob/M = neet
		neet = M.client
	if(!neet || !neet.prefs)
		return FALSE
	if(buy_message)
		to_chat(neet, "<span class='neetbux'>[buy_message]</span>")

//check to see if the stupid bich can even buy this thing
//accounts for neetbux cost but you can slap other requirements here
/datum/neetbux_reward/proc/can_buy(client/neet, silent = FALSE, fail_message = "You don't have enough neetbux to buy NAME!")
	if(ismob(neet))
		var/mob/M = neet
		neet = M.client
	if(!neet || !neet.prefs)
		return FALSE
	if((neet?.prefs?.neetbux_amount >= cost) && !unbuyable)
		return TRUE
	else if(!silent)
		fail_message = replacetextEx(fail_message, "NAME", "[name]")
		to_chat(neet, "<span class='neetbux'>[fail_message]</span>")
		return FALSE

//buying the fucking thing itself
/datum/neetbux_reward/proc/buy(client/neet)
	if(ismob(neet))
		var/mob/M = neet
		neet = M.client
	if(!neet || !neet.prefs)
		return FALSE
	if(!can_buy(neet))
		return
	neet.prefs.adjust_neetbux(-cost)
	on_buy(neet)
	return TRUE
