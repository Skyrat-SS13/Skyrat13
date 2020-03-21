#define AGEWHITELISTFILE "[global.config.directory]/skyrat/age_lock_whitelist.txt"

GLOBAL_LIST(agewhitelist)
GLOBAL_PROTECT(agewhitelist)

/proc/load_age_whitelist()
	GLOB.agewhitelist = list()
	for(var/line in world.file2list(AGEWHITELISTFILE))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.agewhitelist += ckey(line)

	if(!GLOB.agewhitelist.len)
		GLOB.agewhitelist = null

/proc/check_age_whitelist(var/ckey)
	if(!GLOB.agewhitelist)
		return FALSE
	. = (ckey in GLOB.agewhitelist)

#undef AGEWHITELISTFILE