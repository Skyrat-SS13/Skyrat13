GLOBAL_LIST_EMPTY(ckey_assigned_new_player)
//Byond creates a new_player for us, so we just register it on login
/proc/mob_assignment_new_player_login(mob/dead/new_player/NP)
	var/real_key = ckey(NP.key)
	if(!(GLOB.ckey_assigned_new_player[real_key]))
		GLOB.ckey_assigned_new_player[real_key] = NP

/proc/mob_assignment_get_new_player(ckey)
	var/mob/dead/new_player/NP = GLOB.ckey_assigned_new_player[ckey]
	if(!NP)
		NP = new
		GLOB.ckey_assigned_new_player[ckey] = NP
	return NP