//subsystem to handle topic shit as well as other miscellaneous stuff
SUBSYSTEM_DEF(bobux)
	name = "Bobux"
	init_order = INIT_ORDER_DEFAULT
	flags = SS_NO_FIRE
	var/list/datum/bobux_reward/all_bobux_rewards = list()
	var/list/datum/bobux_reward/bobux_rewards_buyable = list()

/datum/controller/subsystem/bobux/Initialize(start_timeofday)
	. = ..()
	for(var/fuck in subtypesof(/datum/bobux_reward))
		var/datum/bobux_reward/fucker = new fuck()
		all_bobux_rewards |= fucker
		if(!initial(fucker.unbuyable))
			bobux_rewards_buyable |= fucker

/datum/controller/subsystem/bobux/proc/adjust_bobux(client/noob, amount, message)
	//makes life easier
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return
	return noob.prefs.adjust_bobux(amount, message)

/datum/controller/subsystem/bobux/proc/ShowChoices(client/noob)
	//fuck
	if(ismob(noob))
		var/mob/M = noob
		noob = M.client
	if(!noob || !noob.prefs)
		return FALSE
	var/list/dat = GetDat(noob)
	winshow(noob, "bobux_window", TRUE)
	var/datum/browser/popup = new(noob, "bobux_window", "<div align='center'>bobux</div>", 400, 800)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(noob.mob, "bobux_window", src)

/datum/controller/subsystem/bobux/proc/GetDat(client/noob)
	var/list/dat = list()
	var/datum/preferences/pref_source = noob.prefs
	dat += "<center><b>Bobux Menu</b></center><br>"
	dat += "<center><b>You currently have [pref_source.bobux_amount]</b> bobux.</center><br>"
	dat += "<center><a href='?src=\ref[src];task=close'>Done</a></center>"
	dat += "<hr>"
	for(var/aaa in bobux_rewards_buyable)
		var/datum/bobux_reward/comicao = aaa
		dat += "<span class='bobux'><b>[comicao.name]</b></span><br>"
		dat += "[comicao.desc]</span><br>"
		dat += "<a href='?src=\ref[src];task=buy;id=[comicao.id]'>Buy</a> ([comicao.cost] bux)"
		dat += "<hr>"
	return dat

/datum/controller/subsystem/bobux/Topic(href, href_list)
	. = ..()
	switch(href_list["task"])
		if("close")
			usr << browse(null, "window=bobux_window")
		if("buy")
			var/id = href_list["id"]
			var/datum/bobux_reward/noob
			for(var/fuck in bobux_rewards_buyable)
				var/datum/bobux_reward/ronaldo = fuck
				if(ronaldo.id == id)
					noob = ronaldo
					break
			if(noob)
				noob.buy(usr)
