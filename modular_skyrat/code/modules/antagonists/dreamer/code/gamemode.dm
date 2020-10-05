//Dreamer is not really recommended as a standalone gamemode.
//This is more for testing and badminning than a serious thing you should actually do.
/datum/game_mode/dreamer
	name = "dreamer"
	config_tag = "dreamer"
	false_report_weight = 0 //You can't really report a dreamer
	protected_jobs = list("Cyborg")
	required_players = 5 //To ensure a dreamer victory, 5 players is a bare minimum
	required_enemies = 1 //One dreamer only
	recommended_enemies = 1 //One dreamer only
