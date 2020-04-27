/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/hiss/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_citadel/sound/voice/hiss.ogg', 50, 1, -1)