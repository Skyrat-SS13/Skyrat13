//
//TICKET MANAGER
//

//Reassociate still open tickets if they exist
/datum/admin_help_tickets/proc/ClientLogin(client/C)
	C.tickets = CKey2ActiveTicket(C.ckey)
	if(C.tickets.len)
		for(var/datum/admin_help/AH in C.tickets)
			AH.initiator = C
			AH.AddInteraction("Client reconnected.")

//Dissasociate tickets
/datum/admin_help_tickets/proc/ClientLogout(client/C)
	if(C.tickets.len)
		for(var/datum/admin_help/AH in C.tickets)
			AH.AddInteraction("Client disconnected.")
			AH.initiator = null
			AH = null

//Get all active tickets given a ckey
/datum/admin_help_tickets/proc/CKey2ActiveTicket(ckey)
	var/list/found_tickets = list()
	for(var/I in active_tickets)
		var/datum/admin_help/AH = I
		if(AH.initiator_ckey == ckey)
			found_tickets += AH
	return found_tickets

/datum/admin_help_tickets/proc/BrowserPlayerTickets()
	var/list/dat = list("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>My Tickets</title></head>")
	dat += "<A href='?_src_=holder;[HrefToken()];my_ahelp_tickets=\"TRUE\"'>Refresh</A><br><br>"
	var/player_ticket_id = 1
	for(var/I in usr.client.tickets)
		var/datum/admin_help/AH = I
		dat += "<span class='adminnotice'><span class='adminhelp'>Ticket #[player_ticket_id]</span>: <A href='?_src_=holder;[HrefToken()];ahelp_player=[REF(AH)];ahelp_action=player_ticket'>[AH.initiator_key_name]: [AH.name]</A></span><br>"
		player_ticket_id += 1

	usr << browse(dat.Join(), "window=playertickets;size=600x480")

//
// TICKET DATUM
//

/datum/admin_help/proc/PlayerTicketPanel()
	var/list/dat = list("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>Player Ticket</title></head>")
	var/ref_src = "[REF(src)]"
	dat += "<b>State: "
	switch(state)
		if(AHELP_ACTIVE)
			dat += "<font color='red'>OPEN</font>"
		if(AHELP_RESOLVED)
			dat += "<font color='green'>RESOLVED</font>"
		if(AHELP_CLOSED)
			dat += "CLOSED"
		else
			dat += "UNKNOWN"
	dat += "</b>[FOURSPACES][PlayerTicketHref("Refresh", ref_src)]"
	dat += "<br><br>Opened at: [GAMETIMESTAMP("hh:mm:ss", closed_at)] (Approx [DisplayTimeText(world.time - opened_at)] ago)"
	if(closed_at)
		dat += "<br>Closed at: [GAMETIMESTAMP("hh:mm:ss", closed_at)] (Approx [DisplayTimeText(world.time - closed_at)] ago)"
	dat += "<br><br>"
	dat += "<br><b>Log:</b><br><br>"
	for(var/I in _interactions_user)
		dat += "[I]<br>"

	usr << browse(dat.Join(), "window=ahelp[id];size=620x480")

//private
/datum/admin_help/proc/PlayerTicketHref(msg, ref_src, action = "player_ticket")
	if(!ref_src)
		ref_src = "[REF(src)]"
	return "<A HREF='?_src_=holder;[HrefToken(TRUE)];ahelp_player=[ref_src];ahelp_action=[action]'>[msg]</A>"

//
// CLIENT PROCS
//

/client/verb/adminhelp(msg as text)
	set category = "Admin"
	set name = "Adminhelp"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	//handle muting and automuting
	if(prefs.muted & MUTE_ADMINHELP)
		to_chat(src, "<span class='danger'>Error: Admin-PM: You cannot send adminhelps (Muted).</span>")
		return
	if(handle_spam_prevention(msg,MUTE_ADMINHELP))
		return

	msg = trim(msg)

	if(!msg)
		return

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Adminhelp") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	new /datum/admin_help(msg, src, FALSE)


// /client/verb/antagrequest(msg as text)
// 	set category = "Admin"
// 	set name = "Antag Request"

// 	if(GLOB.say_disabled)	//This is here to try to identify lag problems
// 		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
// 		return

// 	//handle muting and automuting
// 	if(prefs.muted & MUTE_ADMINHELP)
// 		to_chat(src, "<span class='danger'>Error: Admin-PM: You cannot send adminhelps (Muted).</span>")
// 		return
// 	if(handle_spam_prevention(msg,MUTE_ADMINHELP))
// 		return

// 	msg = trim(msg)

// 	if(!msg)
// 		return

// 	SSblackbox.record_feedback("tally", "antagrequest", 1, "Antag Request") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
// 	new /datum/admin_help(msg, src, FALSE)

// Show the user ticket panel
/client/verb/viewtickets()
	set category = "Admin"
	set name = "View Tickets"

	GLOB.ahelp_tickets.BrowserPlayerTickets()

//
// LOGGING
//

//Use this proc when an admin takes action that may be related to an open ticket on what
//what can be a client, ckey, or mob
/proc/admin_ticket_log(what, message, ticket, private = FALSE)
	var/client/C
	var/mob/Mob = what
	var/datum/admin_help/AH_ticket = ticket

	if(istype(Mob))
		C = Mob.client
	else
		C = what

	if(istype(C)) 
		if(AH_ticket)
			AH_ticket.AddInteraction(message, private) 
		else if(C.tickets.len)
			for(var/datum/admin_help/single_ticket in C.tickets)
				single_ticket.AddInteraction(message, private)
			return C.tickets

	var/list/ckey_tickets = GLOB.ahelp_tickets.CKey2ActiveTicket(what)
	if(istext(what))	//ckey
		if(AH_ticket)
			AH_ticket.AddInteraction(message, private)
		else if(ckey_tickets.len)
			for(var/datum/admin_help/single_ticket in ckey_tickets)
				single_ticket.AddInteraction(message, private)
			return ckey_tickets
