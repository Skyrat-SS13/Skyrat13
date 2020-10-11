/datum/emote/living/surrender
	chat_popup = FALSE
	image_popup = "surrender"

/datum/emote/living/surrender/ff
	key = "ff"

/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."

// Pain emotes and stuff
/datum/emote/living
	var/sound  // Sound to play when emote is called
	var/vary = FALSE // Probably shouldn't vary cause it sounds wacky
	var/volume = 50

/datum/emote/living/run_emote(mob/user, params)
	. = ..()
	if(. && sound)
		playsound(user.loc, sound, volume, vary)

/datum/emote/living/grunt
	key = "grunt"
	key_third_person = "grunts"
	message = "grunts."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon)
