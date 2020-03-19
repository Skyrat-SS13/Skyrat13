//a very simple subsystem that checks for collarbanned humans, and bullies them if they don't have their collars on for some reason.
SUBSYSTEM_DEF(collarbans)
	name = "Collar Bans"
	wait = 600 //fires once every minute.

/datum/controller/subsystem/collarbans/fire()
	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		if(H.mind)
			if(jobban_isbanned(H, COLLARBAN) || jobban_isbanned(H, LESSERCOLLARBAN))
				if(H.wear_neck != (COLLARITEM || LESSERCOLLARITEM))
					H.update_admin_collar()
					to_chat(H, "<span class='boldannounce'>No escaping from the collar, buddy!</span>")
					message_admins("<span class='adminnotice'>WARNING: [H.key] tried, and failed, to remove their ban collar!(...Or something weird happened.)</span>")
					return TRUE
	return FALSE