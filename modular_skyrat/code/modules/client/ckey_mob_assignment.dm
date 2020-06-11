//Byond creates a new_player for us, so we just register it on login
/proc/mob_assignment_new_player_login(mob/dead/new_player/NP)
	var/real_key = ckey(NP.key)
	if(!(GLOB.ckey_assigned_new_player[real_key]))
		GLOB.ckey_assigned_new_player[real_key] = NP
	else
		message_admins("new player already registered")
		GLOB.ckey_assigned_new_player[real_key] = NP

/proc/mob_assignment_get_new_player(ckey)
	var/mob/dead/new_player/NP = GLOB.ckey_assigned_new_player[ckey]
	if(!NP)
		message_admins("Something went wrong and we had to make a new player")
		NP = new
		GLOB.ckey_assigned_new_player[ckey] = NP
	return NP

/proc/mob_assignment_get_observer(ckey, location, body)
	var/mob/dead/observer/obs
	if(GLOB.ckey_assigned_observer[ckey])
		obs = GLOB.ckey_assigned_observer[ckey]
		if(!obs)
			message_admins("Something went wrong - our registered ghost is gone!")
			obs = new(location, body)
			GLOB.ckey_assigned_observer[ckey] = obs
		if(location)
			obs.forceMove(location)
		else
			obs.forceMove(SSmapping.get_station_center())
	else
		obs = new(location, body)
		GLOB.ckey_assigned_observer[ckey] = obs
	return obs

/proc/mob_assignment_stow_observer(mob/dead/observer/obs) //This is not done by a ckey basis as we can't always get an observer key
	if(length(obs.observers))
		for(var/M in obs.observers)
			var/mob/dead/observe = M
			observe.reset_perspective(null)
	obs.moveToNullspace()
