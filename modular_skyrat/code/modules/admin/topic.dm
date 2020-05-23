/datum/admins/Topic(href, href_list)
	. = ..()
	//Topics relating to Faxes
	if(href_list["AdminFaxCreate"])
		if(!check_rights(R_FUN))
			return

		var/mob/sender = locate(href_list["AdminFaxCreate"])
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])
		var/faxtype = href_list["faxtype"]
		var/reply_to = locate(href_list["replyto"])
		var/destination
		var/notify

		var/obj/item/paper/P = new /obj/item/paper(null) //hopefully the null loc won't cause trouble for us

		if(!fax)
			var/list/departmentoptions = GLOB.alldepartments + "All Departments"
			destination = input(usr, "To which department?", "Choose a department", "") as null|anything in departmentoptions
			if(!destination)
				qdel(P)
				return

			for(var/thing in GLOB.allfaxes)
				var/obj/machinery/photocopier/faxmachine/F = thing
				if(destination != "All Departments" && F.department == destination)
					fax = F


		var/input_text = input(src.owner, "Please enter a message to send a fax via secure connection. Use <br> for line breaks. Both pencode and HTML work.", "Outgoing message from CentCom", "") as message|null
		if(!input_text)
			qdel(P)
			return

		var/obj/item/pen/admin_writer = new /obj/item/pen(null)

		input_text = P.parsepencode(input_text, admin_writer, usr) // Encode everything from pencode to html
		qdel(admin_writer)

		var/customname = input(src.owner, "Pick a title for the fax.", "Fax Title") as text|null
		if(!customname)
			customname = "paper"

		var/sendername
		switch(faxtype)
			if("Central Command")
				sendername = "Central Command"
			if("Syndicate")
				sendername = "UNKNOWN"
			if("Custom")
				sendername = input(owner, "What organization does the fax come from? This determines the prefix of the paper (i.e. Central Command- Title). This is optional.", "Organization") as text|null

		if(sender)
			notify = alert(owner, "Would you like to inform the original sender that a fax has arrived?","Notify Sender","Yes","No")

		// Create the reply message
		if(sendername)
			P.name = "[sendername]- [customname]"
		else
			P.name = "[customname]"
		P.info = input_text
		P.update_icon()
		P.x = rand(-2, 0)
		P.y = rand(-1, 2)

		if(destination != "All Departments")
			if(fax.receivefax(P) == FALSE)
				to_chat(owner, "<span class='warning'>Message transmission failed.</span>")
				return
		else
			for(var/thing in GLOB.allfaxes)
				var/obj/machinery/photocopier/faxmachine/F = thing
				if(F.z in SSmapping.levels_by_trait(ZTRAIT_STATION))
					addtimer(CALLBACK(src, .proc/handle_sendall, F, P), 0)

		var/datum/fax/admin/A = new /datum/fax/admin()
		A.name = P.name
		A.from_department = faxtype
		if(destination != "All Departments")
			A.to_department = fax.department
		else
			A.to_department = "All Departments"
		A.origin = "Custom"
		A.message = P
		A.reply_to = reply_to
		A.sent_by = usr
		A.sent_at = world.time

		to_chat(src.owner, "<span class='notice'>Message transmitted successfully.</span>")
		if(notify == "Yes")
			var/mob/living/carbon/human/H = sender
			if(istype(H) && H.stat == CONSCIOUS && (istype(H.ears, /obj/item/radio/headset)))
				to_chat(sender, "<span class='notice'>Your headset pings, notifying you that a reply to your fax has arrived.</span>")
		if(sender)
			log_admin("[key_name(src.owner)] replied to a fax message from [key_name(sender)]: [input_text]")
			message_admins("[key_name_admin(src.owner)] replied to a fax message from [key_name_admin(sender)] (<a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=[REF(P)]'>VIEW</a>).", 1)
		else
			log_admin("[key_name(src.owner)] sent a fax message to [destination]: [input_text]")
			message_admins("[key_name_admin(src.owner)] sent a fax message to [destination] (<a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=[REF(P)]'>VIEW</a>).", 1)
		return

	else if(href_list["refreshfaxpanel"])
		if(!check_rights(R_FUN))
			return

		fax_panel(usr)
		return

	else if(href_list["EvilFax"])
		if(!check_rights(R_FUN))
			return
		var/mob/living/carbon/human/H = locate(href_list["EvilFax"])
		if(!istype(H))
			to_chat(usr, "<span class='notice'>This can only be used on instances of type /mob/living/carbon/human.</span>")
			return
		var/etypes = list("Borgification","Corgification","Death By Fire","Demotion Notice")
		var/eviltype = input(src.owner, "Which type of evil fax do you wish to send [H]?","Its good to be baaaad...", "") as null|anything in etypes
		if(!(eviltype in etypes))
			return
		var/customname = input(src.owner, "Pick a title for the evil fax.", "Fax Title") as text|null
		if(!customname)
			customname = "paper"
		var/obj/item/paper/evilfax/P = new /obj/item/paper/evilfax(null)
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])

		P.name = "Central Command - [customname]"
		P.info = "<span class='danger'>You really should've known better.</span>"
		P.myeffect = eviltype
		P.mytarget = H
		if(alert("Do you want the Evil Fax to activate automatically if [H] tries to ignore it?",,"Yes", "No") == "Yes")
			P.activate_on_timeout = TRUE
		P.x = rand(-2, 0)
		P.y = rand(-1, 2)
		P.update_icon()
		//we have to physically teleport the fax paper
		fax.handle_animation()
		P.forceMove(fax.loc)
		if(istype(H) && H.stat == CONSCIOUS && (istype(H.ears, /obj/item/radio/headset)))
			to_chat(H, "<span class='notice'>Your headset pings, notifying you that a reply to your fax has arrived.</span>")
		to_chat(src.owner, "<span class='notice'>You sent a [eviltype] fax to [H].</span>")
		log_admin("[key_name(src.owner)] sent [key_name(H)] a [eviltype] fax")
		message_admins("[key_name_admin(src.owner)] replied to [key_name_admin(H)] with a [eviltype] fax")
		return

	else if(href_list["FaxReplyTemplate"])
		if(!check_rights(R_FUN))
			return
		var/mob/living/carbon/human/H = locate(href_list["FaxReplyTemplate"])
		if(!istype(H))
			to_chat(usr, "<span class='notice'>This can only be used on instances of type /mob/living/carbon/human.</span>")
			return
		var/obj/item/paper/P = new /obj/item/paper(null)
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])
		P.name = "Central Command - paper"
		var/stypes = list("Handle it yourselves!","Illegible fax","Fax not signed","Not Right Now","You are wasting our time", "Keep up the good work")
		var/stype = input(src.owner, "Which type of standard reply do you wish to send to [H]?","Choose your paperwork", "") as null|anything in stypes
		var/tmsg = "<font face='Verdana' color='black'><center><BR><font size='4'><B>[GLOB.station_name]</B></font><BR><BR><BR><font size='4'>Nanotrasen Communications Department Report</font></center><BR><BR>"
		if(stype == "Handle it yourselves!")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR><BR>Please proceed in accordance with Standard Operating Procedure and/or Space Law. You are fully trained to handle this situation without Central Command intervention.<BR><BR><i><small>This is an automatic message.</small>"
		else if(stype == "Illegible fax")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR><BR>Your fax's grammar, syntax and/or typography are of a sub-par level and do not allow us to understand the contents of the message.<BR><BR>Please consult your nearest dictionary and/or thesaurus and try again.<BR><BR><i><small>This is an automatic message.</small>"
		else if(stype == "Fax not signed")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR><BR>Your fax has not been correctly signed and, as such, we cannot verify your identity.<BR><BR>Please sign your faxes before sending them so that we may verify your identity.<BR><BR><i><small>This is an automatic message.</small>"
		else if(stype == "Not Right Now")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR><BR>Due to pressing concerns of a matter above your current paygrade, we are unable to provide assistance in whatever matter your fax referenced.<BR><BR>This can be either due to a power outage, bureaucratic audit, pest infestation, Ascendance Event, corgi outbreak, or any other situation that would affect the proper functioning of the Communications Department Fax Registration System.<BR><BR>Please try again later.<BR><BR><i><small>This is an automatic message.</small>"
		else if(stype == "You are wasting our time")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR><BR>In the interest of preventing further mismanagement of company resources, please avoid wasting our time with such petty drivel.<BR><BR>Do kindly remember that we expect our workforce to maintain at least a semi-decent level of profesionalism. Do not test our patience.<BR><BR><i><small>This is an automatic message.</i></small>"
		else if(stype == "Keep up the good work")
			tmsg += "Greetings, esteemed crewmember. Your fax has been received successfully by the Communications Department Fax Registration System.<BR><BR>We at Central Command appreciate the good work that you have done here, and sincerely recommend that you continue such a display of dedication to the company.<BR><BR><i><small>This is absolutely not an automated message.</i></small>"
		else
			return
		tmsg += "</font>"
		P.info = tmsg
		P.x = rand(-2, 0)
		P.y = rand(-1, 2)
		P.update_icon()
		fax.receivefax(P)
		if(istype(H) && H.stat == CONSCIOUS && (istype(H.ears, /obj/item/radio/headset)))
			to_chat(H, "<span class='notice'>Your headset pings, notifying you that a reply to your fax has arrived.</span>")
		to_chat(src.owner, "<span class='notice'>You sent a standard '[stype]' fax to [H].</span>")
		log_admin("[key_name(src.owner)] sent [key_name(H)] a standard '[stype]' fax")
		message_admins("[key_name_admin(src.owner)] replied to [key_name_admin(H)] with a standard '[stype]' fax")
		return

	else if(href_list["AdminFaxView"])
		if(!check_rights(R_FUN))
			return

		var/obj/item/fax = locate(href_list["AdminFaxView"])
		if(istype(fax, /obj/item/paper))
			var/obj/item/paper/P = fax
			usr.examinate(P)
		else if(istype(fax, /obj/item/photo))
			var/obj/item/photo/H = fax
			H.show(usr)
		else
			to_chat(usr, "<span class='warning'>The faxed item is not viewable. This is probably a bug, and should be reported on the tracker: [fax.type]</span>")
		return

/datum/admins/proc/handle_sendall(var/obj/machinery/photocopier/faxmachine/F, var/obj/item/paper/P)
	if(F.receivefax(P) == FALSE)
		to_chat(owner, "<span class='warning'>Message transmission to [F.department] failed.</span>")
