/datum/job/prisoner
	title = "Prisoner"
	flag = PRISONER
	department_head = list("The Security Team")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 8
	spawn_positions = 8
	supervisors = "the security team"
	exp_requirements = 1200
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/prisoner

	paycheck = PAYCHECK_MINIMAL
	paycheck_department = ACCOUNT_CIV

	display_order = JOB_DISPLAY_ORDER_PRISONER

/datum/job/ai/override_latejoin_spawn()
	return TRUE

/datum/outfit/job/prisoner
	name = "Prisoner"
	jobtype = /datum/job/prisoner

	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/prisoner
	ears = null
	belt = null

/datum/job/prisoner/radio_help_message(mob/M)
	to_chat(M, "<span class='userdanger'>As a prisoner, you are not an antagonist. You are to roleplay and add to the story. You must ahelp and receive permission from staff BEFORE you wish to riot and attempt to escape.</span>")
	to_chat(M, "<span class='userdanger'>Even if you are allowed to riot or escape, this is not a pass to ruin other crew members days. Failing to follow this may result in punishments.</span>")
