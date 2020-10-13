//Dreamer is not really recommended as a standalone gamemode.
//This is more for testing and badminning than a serious thing you should actually do.
/datum/game_mode/dreamer
	name = "dreamer"
	config_tag = "dreamer"
	enemy_minimum_age = 0
	announce_text = "A psychopathic killer is among the crew. He speaks of another world, of bizarre visions - What could it mean?"
	false_report_weight = 0 //You can't really report a dreamer
	protected_jobs = list("Cyborg", "AI")
	required_players = 5 //To ensure a dreamer victory, 5 players is a bare minimum
	required_enemies = 1 //One dreamer only
	recommended_enemies = 1 //One dreamer only

/datum/game_mode/dreamer/post_setup(report)
	. = ..()
	var/list/possible_dreamers = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.mind && H.client)
			possible_dreamers += H.mind
	if(length(possible_dreamers))
		var/datum/mind/dreamer = pick(possible_dreamers)
		dreamer.add_antag_datum(/datum/antagonist/dreamer)
