//a very simple subsystem that checks for pacifybanned humans, and bullies them if they don't have their brain trauma on for some reason.
SUBSYSTEM_DEF(pacifybans)
	name = "Pacification Bans"
	wait = 1800 //fires once every three minutes.
	can_fire = 0 //Let's enable it if I actually ever see a person slipping out of it

/datum/controller/subsystem/pacifybans/fire()
	for(var/mob/living/carbon/human/H in GLOB.mob_list)
		if(H.client)
			if(jobban_isbanned(H, COLLARBAN))
				H.update_pacification_ban()
	return FALSE