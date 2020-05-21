//gang.dm
//Gang War Game Mode
GLOBAL_LIST_INIT(possible_gangs, subtypesof(/datum/team/gang))
GLOBAL_LIST_EMPTY(gangs)
/datum/game_mode/gang
	name = "gang war"
	config_tag = "gang"
	antag_flag = ROLE_GANG
	restricted_jobs = list("AI", "Cyborg")
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Chief Medical Officer", "Research Director", "Quartermaster")
	required_players = 15
	required_enemies = 0
	recommended_enemies = 2
	enemy_minimum_age = 14
	// SKYRAT EDIT: Credits
	title_icon = "gang"

	announce_span = "danger"
	announce_text = "A violent turf war has erupted on the station!\n\
	<span class='danger'>Gangsters</span>: Take over the station with a dominator.\n\
	<span class='notice'>Crew</span>: Prevent the gangs from expanding and initiating takeover."

	var/list/datum/mind/gangboss_candidates = list()

/datum/game_mode/gang/generate_report()
	return "Cybersun Industries representatives claimed that they, in joint research with the Tiger Cooperative, have made a major breakthrough in brainwashing technology, and have \
			made the nanobots that apply the \"conversion\" very small and capable of fitting into usually innocent objects - namely, pens. While they refused to outsource this technology for \
			months to come due to its flaws, they reported some as missing but passed it off to carelessness. At Central Command, we don't like mysteries, and we have reason to believe that this \
			technology was stolen for anti-Nanotrasen use. Be on the lookout for territory claims and unusually violent crew behavior, applying mindshield implants as necessary."

/datum/game_mode/gang/pre_setup()
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_jobs += "Assistant"

	//Spawn more bosses depending on server population
	var/gangs_to_create = 2
	if(prob(num_players()) && num_players() > 1.5*required_players)
		gangs_to_create++
	if(prob(num_players()) && num_players() > 2*required_players)
		gangs_to_create++
	gangs_to_create = min(gangs_to_create, GLOB.possible_gangs.len)

	for(var/i in 1 to gangs_to_create)
		if(!antag_candidates.len)
			break

		//Now assign a boss for the gang
		var/datum/mind/boss = pick_n_take(antag_candidates)
		antag_candidates -= boss
		gangboss_candidates += boss
		boss.restricted_roles = restricted_jobs

	if(gangboss_candidates.len < 1) //Need at least one gangs
		return

	return TRUE

/datum/game_mode/gang/post_setup()
	set waitfor = FALSE
	..()
	for(var/i in gangboss_candidates)
		var/datum/mind/M = i
		var/datum/antagonist/gang/boss/B = new()
		M.add_antag_datum(B)
		B.equip_gang()
// SKYRAT EDIT: Credits
/datum/game_mode/gang/generate_credit_text()
	var/list/round_credits = list()
	var/len_before_addition

	for(var/datum/team/gang/G in GLOB.gangs)
		round_credits += "<center><h1>The [G.name] Gang:</h1>"
		len_before_addition = round_credits.len
		for(var/datum/mind/boss in G.leaders)
			round_credits += "<center><h2>[boss.name] as a [G.name] Gang leader</h2>"
		for(var/datum/mind/gangster in (G.members - G.leaders))
			round_credits += "<center><h2>[gangster.name] as a [G.name] gangster</h2>"
		if(len_before_addition == round_credits.len)
			round_credits += list("<center><h2>The [G.name] Gang was wiped out!</h2>", "<center><h2>The competition was too tough!</h2>")
		round_credits += "<br>"

	round_credits += ..()
	return round_credits
