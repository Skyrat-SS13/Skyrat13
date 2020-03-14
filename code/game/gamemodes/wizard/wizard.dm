/datum/game_mode
	var/list/datum/mind/wizards = list()
	var/list/datum/mind/apprentices = list()

/datum/game_mode/wizard
	name = "wizard"
	config_tag = "wizard"
	antag_flag = ROLE_WIZARD
	false_report_weight = 10
	required_players = 20
	required_enemies = 1
	recommended_enemies = 1
	enemy_minimum_age = 7
	round_ends_with_antag_death = 1
	announce_span = "danger"
	announce_text = "There is a space wizard attacking the station!\n\
	<span class='danger'>Wizard</span>: Accomplish your objectives and cause mayhem on the station.\n\
	<span class='notice'>Crew</span>: Eliminate the wizard before they can succeed!"
	var/finished = 0

/datum/game_mode/wizard/pre_setup()
	var/datum/mind/wizard = antag_pick(antag_candidates)
	wizards += wizard
	wizard.assigned_role = ROLE_WIZARD
	wizard.special_role = ROLE_WIZARD
	log_game("[key_name(wizard)] has been selected as a Wizard") //TODO: Move these to base antag datum
	if(GLOB.wizardstart.len == 0)
		setup_error = "No wizard starting location found"
		return FALSE
	for(var/datum/mind/wiz in wizards)
		wiz.current.forceMove(pick(GLOB.wizardstart))
	return TRUE


/datum/game_mode/wizard/post_setup()
	for(var/datum/mind/wizard in wizards)
		wizard.add_antag_datum(/datum/antagonist/wizard)
	return ..()

/datum/game_mode/wizard/generate_report()
	return "Reports of strange bluespace fluctuations are becoming common in your sector. It may be the work of a powerful magic-user. While it may sound silly, Central would like to remind \
	employees of the fact that people harnessing bluespace to perform 'magic' are in fact likely to be true, and to be wary of those who may come to your station with the intention of \
	causing chaos.."


/datum/game_mode/wizard/are_special_antags_dead()
	for(var/datum/mind/wizard in wizards)
		if(isliving(wizard.current) && wizard.current.stat!=DEAD)
			return FALSE

	for(var/obj/item/phylactery/P in GLOB.poi_list) //TODO : IsProperlyDead()
		if(P.mind && P.mind.has_antag_datum(/datum/antagonist/wizard))
			return FALSE

	if(SSevents.wizardmode) //If summon events was active, turn it off
		SSevents.toggleWizardmode()
		SSevents.resetFrequency()

	return TRUE

/datum/game_mode/wizard/set_round_result()
	..()
	if(finished)
		SSticker.mode_result = "loss - wizard killed"
		SSticker.news_report = WIZARD_KILLED

/datum/game_mode/wizard/special_report()
	if(finished)
		return "<span class='redtext big'>The wizard[(wizards.len>1)?"s":""] has been killed by the crew! The Space Wizards Federation has been taught a lesson they will not soon forget!</span>"

//returns whether the mob is a wizard (or apprentice)
/proc/iswizard(mob/living/M)
	return M.mind && M.mind.has_antag_datum(/datum/antagonist/wizard,TRUE)
