/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["skyrat_ooc_notes"])
		if(client)
			var/str = "[src]'s OOC Notes : <br> <b>ERP :</b> [client.prefs.erppref] <b>| Non-Con :</b> [client.prefs.nonconpref] <b>| Vore :</b> [client.prefs.vorepref]<br>[client.prefs.skyrat_ooc_notes]"
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s OOC information", replacetext(str, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s ooc info"))
			onclose(usr, "[name]'s ooc info")
