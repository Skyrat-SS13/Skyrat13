//base bobux reward datum
/datum/bobux_reward
	var/name = "YOU SHOULDNT BE READING THIS"
	var/desc = "THIS SHOULDNT BE READ EITHER"
	var/buy_message = "YOU SHOULDNT BE BUYING THIS"
	var/id = "FUCK"
	var/cost = 1
	var/unbuyable = FALSE //Used for "rewards" that you don't buy, but rather gain by the subsystem
	//Will mostly be used for negative stuff for people that have a negative bobux balance

//do the stuff that happens when you buy the reward here wahoo
/datum/bobux_reward/proc/on_buy(client/noob)
	. = TRUE
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return FALSE
	if(buy_message)
		to_chat(noob, "<span class='bobux'>[buy_message]</span>")

//check to see if the stupid bich can even buy this thing
//accounts for bobux cost but you can slap other requirements here
/datum/bobux_reward/proc/can_buy(client/noob, silent = FALSE, fail_message = "You don't have enough bobux to buy NAME!")
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return FALSE
	if((noob?.prefs?.bobux_amount >= cost) && !unbuyable)
		return TRUE
	else if(!silent)
		fail_message = replacetextEx(fail_message, "NAME", "[name]")
		to_chat(noob, "<span class='bobux'>[fail_message]</span>")
		return FALSE

//buying the fucking thing itself
/datum/bobux_reward/proc/buy(client/noob)
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return FALSE
	if(!can_buy(noob))
		return
	noob.prefs.adjust_bobux(-cost)
	on_buy(noob)
	return TRUE
