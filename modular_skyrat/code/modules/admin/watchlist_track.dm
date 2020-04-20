//This is here so we don't have to ask the database whether someone's watchlisted for variety of reason. Helps performance
GLOBAL_LIST_EMPTY(watchlist_track)

/proc/add_to_tracked_watchlist(ckey)
	if(!(ckey in GLOB.watchlist_track))
		GLOB.watchlist_track += ckey

/proc/in_tracked_watchlist(ckey)
	if(ckey in GLOB.watchlist_track)
		return TRUE
	else
		return FALSE