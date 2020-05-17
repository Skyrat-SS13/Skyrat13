/datum/game_mode
	var/list/vampires = list()

/datum/game_mode/bloodlines
	name = "bloodlines"
	config_tag = "bloodlines"
	traitor_name = "Vampire"
	antag_flag = ROLE_BLOODLINE_VAMPIRE
	false_report_weight = 1
	restricted_jobs = list("AI", "Cyborg")
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_players = 1
	required_enemies = 1
	recommended_enemies = 1
	enemy_minimum_age = 0

	round_ends_with_antag_death = FALSE
	reroll_friendly = 1

	announce_span = "danger"
	announce_text = "A violent turf war has erupted on the station!\n\
	<span class='danger'>Vampires</span>: Take over the station with a dominator.\n\
	<span class='notice'>Crew</span>: Prevent the gangs from expanding and initiating takeover."

	var/list/initial_vampires = list()

/datum/game_mode/bloodlines/generate_report()
	return "VAMPIRE VAmpsss."

// Seems to be run by game ONCE, and finds all potential players to be antag.
/datum/game_mode/bloodlines/pre_setup()

	// Set Restricted Jobs
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_jobs += "Assistant"

	// Set number of Vamps
	//recommended_enemies = clamp(round(num_players()/10), 1, 6);
	recommended_enemies = 1 //for now

	// Select Antags
	for(var/i = 0, i < recommended_enemies, i++)
		if (!antag_candidates.len)
			break
		var/datum/mind/vampire = pick(antag_candidates)
		initial_vampires += vampire
		vampire.restricted_roles = restricted_jobs
		log_game("[vampire.key] (ckey) has been selected as a Vampire.")
		antag_candidates.Remove(vampire)

	// Do we have enough vamps to continue?
	if(initial_vampires.len < required_enemies)
		setup_error = "Not enough initial vampire candidates"
		return FALSE
	return TRUE


// Gamemode is all done being set up. We have all our Vamps. We now pick objectives and let them know what's happening.
/datum/game_mode/bloodlines/post_setup()
	// Vamps
	for(var/datum/mind/vamp_mind in initial_vampires)
		var/datum/antagonist/vampire/V = vamp_mind.add_antag_datum(/datum/antagonist/vampire)
	return ..()