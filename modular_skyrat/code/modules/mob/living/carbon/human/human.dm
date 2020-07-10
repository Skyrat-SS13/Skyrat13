/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(href_list["skyrat_ooc_notes"])
		if(client)
			var/str = "[src]'s OOC Notes : <br> <b>ERP :</b> [client.prefs.erppref] <b>| Non-Con :</b> [client.prefs.nonconpref] <b>| Vore :</b> [client.prefs.vorepref]"
			if(client.prefs.extremepref == "Yes")
				str += "<br><b>Extreme content :</b> [client.prefs.extremepref] <b>| <b>Extreme content harm :</b> [client.prefs.extremeharm]"
			str += "<br>[html_encode(client.prefs.skyrat_ooc_notes)]"
			var/datum/browser/popup = new(usr, "[name]'s ooc info", "[name]'s OOC Information", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s OOC information", replacetext(str, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["general_records"])
		if(client && usr.client.holder)
			var/datum/browser/popup = new(usr, "[name]'s gen rec", "[name]'s General Record", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s general records", replacetext(client.prefs.general_records, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["security_records"])
		if(client && usr.client.holder)
			var/datum/browser/popup = new(usr, "[name]'s sec rec", "[name]'s Security Record", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s security records", replacetext(client.prefs.security_records, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["medical_records"])
		if(client && usr.client.holder)
			var/datum/browser/popup = new(usr, "[name]'s med rec", "[name]'s Medical Record", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s medical records", replacetext(client.prefs.medical_records, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["flavor_faction"])
		if(client && usr.client.holder)
			var/datum/browser/popup = new(usr, "[name]'s flav fact", "[name]'s Flavor Faction", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s background faction", replacetext(client.prefs.flavor_faction, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["flavor_background"])
		if(client && usr.client.holder)
			var/datum/browser/popup = new(usr, "[name]'s flav bg", "[name]'s Flavor Background", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s background flavor", replacetext(client.prefs.flavor_background, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["character_skills"])
		if(client && usr.client.holder)
			var/datum/browser/popup = new(usr, "[name]'s char skill", "[name]'s Character Skill", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s skills and hobbies", replacetext(client.prefs.character_skills, "\n", "<BR>")))
			popup.open()
			return

	if(href_list["exploitable_info"])
		if(client && (usr.client.holder || usr.mind?.antag_datums))
			var/datum/browser/popup = new(usr, "[name]'s exp info", "[name]'s Exploitable Info", 500, 200)
			popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s exploitable information", replacetext(client.prefs.exploitable_info, "\n", "<BR>")))
			popup.open()
			return

/mob/living/carbon/human/revive(full_heal = 0, admin_revive = 0)
	if(..())
		if(dna && dna.species)
			dna.species.spec_revival(src)
