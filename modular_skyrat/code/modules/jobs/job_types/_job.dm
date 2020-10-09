//Alt titles
/datum/job
	var/list/alt_titles = list()

//Job music
/datum/outfit
	var/music_file = 'modular_skyrat/sound/music/ritual.ogg'

/datum/outfit/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	. = ..()
	if(music_file && preference_source?.prefs)
		preference_source.prefs.combat_music = music_file
		preference_source.prefs.save_preferences()
