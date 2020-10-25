//Dreamer is not really recommended as a standalone gamemode.
//This is more for testing and badminning than a serious thing you should actually do.
/datum/game_mode/dreamer
	name = "dreamer"
	config_tag = "dreamer"
	antag_flag = ROLE_DREAMER
	enemy_minimum_age = 0
	announce_text = "A psychopathic killer is among the crew. He speaks of another world, of bizarre visions - What could it mean?"
	false_report_weight = 0 //You can't really report a dreamer
	protected_jobs = list("Cyborg", "AI")
	required_players = 5 //To ensure a dreamer victory, 5 players is a bare minimum
	required_enemies = 1 //One dreamer only
	recommended_enemies = 1 //One dreamer only

/datum/game_mode/dreamer/get_players_for_role(role)
	//We give 0 shits about preferences lmao
	//eat pen
	var/list/players = list()
	var/list/candidates = list()

	for(var/mob/dead/new_player/player in GLOB.player_list)
		if(player.client && player.ready == PLAYER_READY_TO_PLAY && player.check_preferences())
			players += player

	players = shuffle(players)

	for(var/mob/dead/new_player/player in players)
		if(player.client && player.ready == PLAYER_READY_TO_PLAY)
			candidates += player.mind

	return candidates

/datum/game_mode/dreamer/post_setup(report)
	..()
	for(var/datum/mind/dreamer in antag_candidates)
		var/datum/antagonist/dreamer/new_antag = new()
		addtimer(CALLBACK(dreamer, /datum/mind.proc/add_antag_datum, new_antag), rand(100,200))
