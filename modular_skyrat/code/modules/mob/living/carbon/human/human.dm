/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(href_list["skyrat_ooc_notes"])
		if(client)
			var/str = "[src]'s OOC Notes : <br> <b>ERP :</b> [client.prefs.erppref] <b>| Non-Con :</b> [client.prefs.nonconpref] <b>| Vore :</b> [client.prefs.vorepref]<br>[client.prefs.skyrat_ooc_notes]"
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s OOC information", replacetext(str, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s ooc info"))
			onclose(usr, "[name]'s ooc info")
	
	if(href_list["general_records"])
		if(client && usr.client.holder)
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s general records", replacetext(client.prefs.general_records, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s gen rec"))
			onclose(usr, "[name]'s gen rec")

	if(href_list["security_records"])
		if(client && usr.client.holder)
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s security records", replacetext(client.prefs.security_records, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s sec rec"))
			onclose(usr, "[name]'s sec rec")

	if(href_list["medical_records"])
		if(client && usr.client.holder)
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s medical records", replacetext(client.prefs.medical_records, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s med rec"))
			onclose(usr, "[name]'s med rec")

	if(href_list["flavor_background"])
		if(client && usr.client.holder)
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s background flavor", replacetext(client.prefs.flavor_background, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s bg flav"))
			onclose(usr, "[name]'s bg flav")

	if(href_list["character_skills"])
		if(client && usr.client.holder)
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s skills and hobbies", replacetext(client.prefs.character_skills, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s char skill"))
			onclose(usr, "[name]'s char skill")

	if(href_list["exploitable_info"])
		if(client && usr.client.holder)
			usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s exploitable information", replacetext(client.prefs.exploitable_info, "\n", "<BR>")), text("window=[];size=500x200", "[name]'s exp info"))
			onclose(usr, "[name]'s exp info")

/mob/living/carbon/human/revive(full_heal = 0, admin_revive = 0)
	if(..())
		if(dna && dna.species)
			dna.species.spec_revival(src)