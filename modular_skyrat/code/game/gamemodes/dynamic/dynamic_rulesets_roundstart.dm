/datum/dynamic_ruleset/roundstart/traitor/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"

	scaling_cost = CONFIG_GET(number/traitor_scale_cost)
	. = ..()

/datum/dynamic_ruleset/roundstart/traitorbro/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"

	scaling_cost = CONFIG_GET(number/bro_scale_cost)
	. = ..()

/datum/dynamic_ruleset/roundstart/bloodsucker/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"

	scaling_cost = CONFIG_GET(number/bloodsucker_scale_cost)
	. = ..()

/datum/dynamic_ruleset/roundstart/changeling/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/bloodcult/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/revs/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/devil/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/monkey/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()


//////////////////////////////////////////
//                                      //
//              OVERTHROW               //
//                                      //
//////////////////////////////////////////

/*
/datum/dynamic_ruleset/roundstart/overthrow
	name = "Overthrow"
 	config_tag = "overthrow"
 	antag_flag = ROLE_OVERTHROW
 	minimum_required_age = 0
 	protected_roles = list("Chaplain", "Security Officer", "Warden", "Detective", "Brig Physician", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster", "Prisoner", "Brig Physician", "Blueshield") 
 	restricted_roles = list("Cyborg", "AI")
 	required_candidates = 2
 	weight = 0 // Originally 3
 	cost = 35
 	scaling_cost = 10
 	property_weights = list() // Originally list("story_potential" = 1, "trust" = -1, "extended" = 1, "valid" = 1)
 	requirements = list(70,65,60,55,50,50,50,50,50,50)
 	high_population_requirement = 666// Originally 65
 	antag_cap = list(2,2,2,2,2,2,2,2,2,2)

/datum/dynamic_ruleset/roundstart/overthrow/pre_execute()
	var/sleeping_agents = antag_cap[indice_pop] * (scaled_times + 1)

	for (var/i in 1 to sleeping_agents)
 		var/mob/M = pick_n_take(candidates)
 		assigned += M.mind
 		M.mind.special_role = ROLE_OVERTHROW
 		M.mind.restricted_roles = restricted_roles
 	return TRUE

/datum/dynamic_ruleset/roundstart/overthrow/execute()
 	for(var/i in assigned) // each agent will have its own team.
 		var/datum/mind/agent = i
 		var/datum/antagonist/overthrow/O = agent.add_antag_datum(/datum/antagonist/overthrow) // create_team called on_gain will create the team
 		O.equip_initial_overthrow_agent()
 	return TRUE
*/
