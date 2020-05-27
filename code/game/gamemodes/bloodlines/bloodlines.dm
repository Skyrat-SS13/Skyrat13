//Implemented by Azarak as a part of code bounty from Rayford. Irkalla Epsilon contributed to a lot of the ideas and abilities
/datum/game_mode
	var/list/vampires = list()
	var/list/vampire_clans = list()

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
		if(can_be_vampire_canditate(vampire))
			initial_vampires += vampire
			vampire.restricted_roles = restricted_jobs
			log_game("[vampire.key] (ckey) has been selected as a Vampire.")
			message_admins("[pick(GLOB.vamp_disciplines)]")
			message_admins("[pick(GLOB.vamp_bloodlines)]")
		antag_candidates.Remove(vampire)

	// Do we have enough vamps to continue?
	if(initial_vampires.len < required_enemies)
		setup_error = "Not enough initial vampire candidates"
		return FALSE
	return TRUE

// Gamemode is all done being set up. We have all our Vamps. We now pick objectives and let them know what's happening.
/datum/game_mode/bloodlines/post_setup()
	// Vamps
	var/datum/team/vampire_clan/vamp_clan = new
	vamp_clan.setup_clan(pick(GLOB.vamp_bloodlines))
	for(var/datum/mind/vamp_mind in initial_vampires)
		var/datum/antagonist/vampire/V = vamp_mind.add_antag_datum(/datum/antagonist/vampire)
		vamp_clan.add_member(vamp_mind)
		V.post_greet(vamp_mind)
	return ..()

/proc/can_be_vampire_canditate(var/datum/mind/Mind) //No human yet, for gamemode setup
	// No Mind
	if(!Mind || !Mind.key)
		return FALSE
	var/client/C = Mind.current.client
	if(!C)
		return FALSE
	if(NOBLOOD in C.prefs.pref_species.species_traits)
		return FALSE
	if("no_breath" in C.prefs.pref_species.inherent_traits) //So apparently someone fucked with this define
		return FALSE
	if(NO_DNA_COPY in C.prefs.pref_species.species_traits)
		return FALSE
	return TRUE


/proc/can_make_vampire(var/datum/mind/Mind)
	// No Mind
	if(!Mind || !Mind.key) // KEY is client login?
		//if(creator) // REMOVED. You wouldn't see their name if there is no mind, so why say anything?
		return FALSE
	var/mob/living/carbon/human/Human = Mind.current
	if(!ishuman(Human))
		return FALSE
	if(NOBLOOD in Human.dna.species.species_traits) //Duh
		return FALSE
	if(TRAIT_NOBREATH in Human.dna.species.inherent_traits) //No breathing usually means a disconnect from blood/heart mechanics
		return FALSE
	if(Human.dna.species.inherent_biotypes & MOB_ROBOTIC) //Self explanatory
		return FALSE
	// Already a Non-Human Antag
	if(Mind.has_antag_datum(/datum/antagonist/abductor) || Mind.has_antag_datum(/datum/antagonist/devil) || Mind.has_antag_datum(/datum/antagonist/changeling) || Mind.has_antag_datum(/datum/antagonist/bloodsucker))
		return FALSE
	/*
	// Already a vamp
	if(Mind.has_antag_datum(/datum/antagonist/vampire))
		message_admins("already a vamp")
		return FALSE
	*/
	return TRUE