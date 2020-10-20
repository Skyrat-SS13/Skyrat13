//Alt titles
/datum/job
	var/list/alt_titles = list()
	var/flatter_string = ""
	var/music_file = 'modular_skyrat/sound/music/ritual.ogg'

//Job music
/datum/job/after_spawn(mob/living/H, mob/M)
	. = ..()
	if(music_file && H.client?.prefs)
		H.client.prefs.combat_music = music_file
		H.client.prefs.save_preferences()

//Outfit music
/datum/outfit
	var/music_file = 'modular_skyrat/sound/music/ritual.ogg'

/datum/outfit/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	. = ..()
	if(music_file && preference_source?.prefs)
		preference_source.prefs.combat_music = music_file
		preference_source.prefs.save_preferences()
