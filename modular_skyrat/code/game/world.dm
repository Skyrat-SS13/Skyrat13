/world/proc/update_status()

	var/list/features = list()

	/*if(GLOB.master_mode) CIT CHANGE - hides the gamemode from the hub entry, removes some useless info from the hub entry
		features += GLOB.master_mode

	if (!GLOB.enter_allowed)
		features += "closed"*/

	var/s = ""
	var/hostedby
	if(config)
		var/server_name = CONFIG_GET(string/servername)
		if (server_name)
			s += "<b>[server_name]</b> &#8212; "
		/*features += "[CONFIG_GET(flag/norespawn) ? "no " : ""]respawn" CIT CHANGE - removes some useless info from the hub entry
		if(CONFIG_GET(flag/allow_vote_mode))
			features += "vote"
		if(CONFIG_GET(flag/allow_ai))
			features += "AI allowed"
		hostedby = CONFIG_GET(string/hostedby)*/

	s += " ("
	s += "<a href=\"https://discord.gg/VXXE6Qm\">" //Change this to wherever you want the hub to link to. wzds change - links to the discord
	s += "Discord"  //Replace this with something else. Or ever better, delete it and uncomment the game version. wzds change - modifies hub entry link
	s += "</a>"
	// s += "Website"
	// s += "</a>"
	s += ")\]" //CIT CHANGE - encloses the server title in brackets to make the hub entry fancier
	s += "<br>[CONFIG_GET(string/servertagline)]<br>" //CIT CHANGE - adds a tagline!


	var/n = 0
	for (var/mob/M in GLOB.player_list)
		if (M.client)
			n++

	if(SSmapping.config) // this just stops the runtime, honk.
		features += "[SSmapping.config.map_name]"	//CIT CHANGE - makes the hub entry display the current map

	if(NUM2SECLEVEL(GLOB.security_level))//CIT CHANGE - makes the hub entry show the security level
		features += "[NUM2SECLEVEL(GLOB.security_level)] alert"

	if (n > 1)
		features += "~[n] players"
	else if (n > 0)
		features += "~[n] player"

	if (!host && hostedby)
		features += "hosted by <b>[hostedby]</b>"

	if (features)
		s += "\[[jointext(features, ", ")]" //CIT CHANGE - replaces the colon here with a left bracket

	status = s
