//Antag music
/datum/antagonist
	var/music_file

/datum/antagonist/on_gain()
	. = ..()
	if(music_file && owner.current?.client?.prefs)
		owner.current.client.prefs.combat_music = music_file

/datum/antagonist/dreamer/New()
	. = ..()
	music_file = pick('modular_skyrat/sound/music/hot_plates.ogg', \
					'modular_skyrat/sound/music/rectum.ogg',
					)

/datum/antagonist/traitor/New()
	. = ..()
	music_file = pick('modular_skyrat/sound/music/stress.ogg', \
				'modular_skyrat/sound/music/hydrogen.ogg', \
				'modular_skyrat/sound/music/army.ogg',
				'modular_skyrat/sound/music/divide.ogg',
				'modular_skyrat/sound/music/selectedfaces.ogg',
				)

/datum/antagonist/ert/deathsquad/New()
	. = ..()
	music_file = pick('modular_skyrat/sound/music/bfgdivision.ogg',
				'modular_skyrat/sound/music/theonlythingtheyfearisyou.ogg',
				'modular_skyrat/sound/music/rollermobster.ogg',
				'modular_skyrat/sound/music/deathsquads.ogg',
				)
