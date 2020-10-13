/datum/emote/living/surrender
	chat_popup = FALSE
	image_popup = "surrender"

/datum/emote/living/surrender/ff
	key = "ff"

/datum/emote/living/tilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."

// Pain emotes and stuff below
/datum/emote/living
	var/sound  // Sound to play when emote is called
	var/vary = FALSE // Probably shouldn't vary cause it sounds wacky
	var/volume = 50

/datum/emote/living/run_emote(mob/user, params)
	. = ..()
	if(. && sound)
		playsound(user.loc, sound, volume, vary)

// Grunting
/datum/emote/living/grunt
	key = "grunt"
	key_third_person = "grunts"
	message = "grunts."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon)

/datum/emote/living/grunt/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.agony_moans_male))
			sound = pick(H.dna.species.agony_moans_male)
			if((H.gender == FEMALE) && length(H.dna.species.agony_moans_female))
				sound = pick(H.dna.species.agony_moans_female)

// Groaning
/datum/emote/living/groan/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.agony_moans_male))
			sound = pick(H.dna.species.agony_moans_male)
			if((H.gender == FEMALE) && length(H.dna.species.agony_moans_female))
				sound = pick(H.dna.species.agony_moans_female)

// Agony screaming
/datum/emote/living/agonyscream
	key = "agonyscream"
	key_third_person = "screamsinagony"
	message = "screams in agony!"
	emote_type = EMOTE_AUDIBLE
	restraint_check = FALSE
	stat_allowed = UNCONSCIOUS
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/agonyscream/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.agony_sounds_male))
			sound = pick(H.dna.species.agony_sounds_male)
			if((H.gender == FEMALE) && length(H.dna.species.agony_sounds_female))
				sound = pick(H.dna.species.agony_sounds_female)
// Gargle
/datum/emote/living/gargle
	key = "gargle"
	key_third_person = "gargles"
	message = "gargles their throat!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = FALSE
	stat_allowed = UNCONSCIOUS
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/gargle/run_emote(mob/user, params)
	. = ..()
	var/garglesound = pick('modular_skyrat/sound/gore/throat1.ogg',
						'modular_skyrat/sound/gore/throat2.ogg',
						'modular_skyrat/sound/gore/throat3.ogg',
						)
	sound = garglesound

// Death rattle
/datum/emote/living/deathrattle
	key = "deathrattle"
	key_third_person = "deathrattles"
	message = "gasps!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = FALSE
	stat_allowed = UNCONSCIOUS
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/deathrattle/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.death_rattles_male))
			sound = pick(H.dna.species.death_rattles_male)
			if((H.gender == FEMALE) && length(H.dna.species.death_rattles_female))
				sound = pick(H.dna.species.death_rattles_female)

// Death gasps make a death rattle sound
/datum/emote/living/deathgasp/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.death_rattles_male))
			sound = pick(H.dna.species.death_rattles_male)
			if((H.gender == FEMALE) && length(H.dna.species.death_rattles_female))
				sound = pick(H.dna.species.death_rattles_female)

// Gasping makes a sound
/datum/emote/living/gasp/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.agony_gasps_male))
			sound = pick(H.dna.species.agony_gasps_male)
			if((H.gender == FEMALE) && length(H.dna.species.agony_gasps_female))
				sound = pick(H.dna.species.agony_gasps_female)

// Crying makes a sound
/datum/emote/living/whimper/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.cry_male))
			sound = pick(H.dna.species.cry_male)
			if((H.gender == FEMALE) && length(H.dna.species.cry_female))
				sound = pick(H.dna.species.cry_female)

/datum/emote/living/carbon/human/cry/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.cry_male))
			sound = pick(H.dna.species.cry_male)
			if((H.gender == FEMALE) && length(H.dna.species.cry_female))
				sound = pick(H.dna.species.cry_female)

// Moaning makes a sound
/datum/emote/living/carbon/moan/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.agony_moans_male))
			sound = pick(H.dna.species.agony_moans_male)
			if((H.gender == FEMALE) && length(H.dna.species.agony_moans_female))
				sound = pick(H.dna.species.agony_moans_female)

// Coughing, too, makes a sound
/datum/emote/living/cough/run_emote(mob/living/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.coughs_male))
			sound = pick(H.dna.species.coughs_male)
			if((H.gender == FEMALE) && length(H.dna.species.coughs_female))
				sound = pick(H.dna.species.coughs_female)

// Sagging
/datum/emote/living/sag
	key = "sag"
	key_third_person = "sags"
	message = "sags on the floor, he won't regain his conciousness soon."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = FALSE
	stat_allowed = UNCONSCIOUS
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/sag/run_emote(mob/user, params)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(length(H.dna?.species?.death_rattles_male))
			sound = pick(H.dna.species.death_rattles_male)
			if((H.gender == FEMALE) && length(H.dna.species.death_rattles_female))
				sound = pick(H.dna.species.death_rattles_female)
