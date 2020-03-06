/client/who()
	set name = "Who"
	set category = "OOC"

	var/msg = ""

	var/list/Lines = list()
	var/list/assembled = list()
	var/admin_mode = check_rights_for(src, R_ADMIN) && isobserver(mob)
	if(admin_mode)
		log_admin("[key_name(usr)] checked advanced who in-round")
	if(length(GLOB.admins))
		Lines += "<b>Admins:</b>"
		for(var/X in GLOB.admins)
			var/client/C = X
			if(C && C.holder && !C.holder.fakekey)
				assembled += "\t <font color='#FF0000'>[C.key]</font>[admin_mode? "[show_admin_info(C)]":""] ([round(C.avgping, 1)]ms)"
		Lines += sortList(assembled)
	assembled.len = 0
	if(length(GLOB.mentors))
		Lines += "<b>Mentors:</b>"
		for(var/X in GLOB.mentors)
			var/client/C = X
			if(C && (!C.holder || (C.holder && !C.holder.fakekey)))			//>using stuff this complex instead of just using if/else lmao
				assembled += "\t <font color='#0033CC'>[C.key]</font>[admin_mode? "[show_admin_info(C)]":""] ([round(C.avgping, 1)]ms)"
		Lines += sortList(assembled)
	assembled.len = 0
	Lines += "<b>Players:</b>"
	for(var/X in sortList(GLOB.clients))
		var/client/C = X
		if(!C)
			continue
		var/key = C.key
		if(C.holder && C.holder.fakekey)
			key = C.holder.fakekey
		var/keyprint = "[key]"
		if(admin_mode && (!C.prefs.exp || text2num(C.prefs.exp[EXP_TYPE_LIVING]) < 300))
			keyprint = "<font color='#538EED'>[key]</font>"
		assembled += "\t [keyprint][admin_mode? "[show_admin_info(C)]":""] ([round(C.avgping, 1)]ms)"
	Lines += sortList(assembled)
	
	for(var/line in Lines)
		msg += "[line]\n"

	msg += "<b>Total Players: [length(GLOB.clients)]</b>"
	to_chat(src, msg)