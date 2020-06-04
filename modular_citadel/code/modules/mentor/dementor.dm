/client/proc/cmd_mentor_dementor()
	set category = "Mentor"
	set name = "dementor"
	if(!is_mentor())
		return
	remove_mentor_verbs()
	if (/client/proc/mentor_unfollow in verbs)
		mentor_unfollow()
	GLOB.mentors -= src
	verbs += /client/proc/cmd_mentor_rementor
	
/client/proc/cmd_mentor_rementor()
	set category = "Mentor"
	set name = "rementor"
	if(!is_mentor())
		return
	add_mentor_verbs()
	if(!check_rights(R_ADMIN)) // Skyrat change, stops admins from listing in mentors
		GLOB.mentors += src
	verbs -= /client/proc/cmd_mentor_rementor
