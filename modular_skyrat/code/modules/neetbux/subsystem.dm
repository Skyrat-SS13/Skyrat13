//subsystem to handle topic shit as well as other miscellaneous stuff
SUBSYSTEM_DEF(neetbux)
	name = "Neetbux"
	init_order = INIT_ORDER_DEFAULT
	flags = SS_NO_FIRE
	var/list/datum/neetbux_reward/all_neetbux_rewards = list()
	var/list/datum/neetbux_reward/neetbux_rewards_buyable = list()

/datum/controller/subsystem/neetbux/Initialize(start_timeofday)
	. = ..()
	for(var/fuck in subtypesof(/datum/neetbux_reward))
		var/datum/neetbux_reward/fucker = new fuck()
		all_neetbux_rewards |= fucker
		if(!initial(fucker.unbuyable))
			neetbux_rewards_buyable |= fucker

/datum/controller/subsystem/neetbux/proc/adjust_neetbux(client/neet, amount, message)
	//makes life easier
	if(ismob(neet))
		var/mob/M = neet
		neet = M.client
	if(!neet || !neet.prefs)
		return
	return neet.prefs.adjust_neetbux(amount, message)

/datum/controller/subsystem/neetbux/proc/ShowChoices(client/neet)
	//fuck
	if(ismob(neet))
		var/mob/M = neet
		neet = M.client
	if(!neet || !neet.prefs)
		return FALSE
	var/list/dat = GetDat(neet)
	winshow(neet, "neetbux_window", TRUE)
	var/datum/browser/popup = new(neet, "neetbux_window", "<div align='center'>Neetbux</div>", 400, 800)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(neet.mob, "neetbux_window", src)

/datum/controller/subsystem/neetbux/proc/GetDat(client/neet)
	var/list/dat = list()
	var/datum/preferences/pref_source = neet.prefs
	dat += "<center><b>Neetbux Menu</b></center><br>"
	dat += "<center><b>You currently have [pref_source.neetbux_amount]</b> neetbux.</center><br>"
	dat += "<center><a href='?src=\ref[src];task=close'>Done</a></center>"
	dat += "<hr>"
	for(var/aaa in neetbux_rewards_buyable)
		var/datum/neetbux_reward/comicao = aaa
		dat += "<span class='neetbux'><b>[comicao.name]</b></span><br>"
		dat += "<span class='neetbux'>[comicao.desc]</span><br>"
		dat += "<a href='?src=\ref[src];task=buy;id=[comicao.id]'>Buy ([comicao.cost] bux)</a>"
		dat += "<hr>"
	return dat

/datum/controller/subsystem/neetbux/Topic(href, href_list)
	. = ..()
	switch(href_list["task"])
		if("close")
			usr << browse(null, "window=neetbux_window")
		if("buy")
			var/id = href_list["id"]
			var/datum/neetbux_reward/neet
			for(var/fuck in neetbux_rewards_buyable)
				var/datum/neetbux_reward/ronaldo = fuck
				if(ronaldo.id == id)
					neet = ronaldo
					break
			if(neet)
				neet.buy(usr)
