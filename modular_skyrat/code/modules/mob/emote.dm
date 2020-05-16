/mob/emote(act, m_type = null, message = null, intentional = FALSE)
	. = ..()
	if(client && client.prefs.toggles & ASYNCHRONOUS_SAY && typing)
		set_typing_indicator(FALSE)

/datum/emote/living/scream/run_emote(mob/living/user, params) //I can't not port this shit, come on.
	if(user.nextsoundemote >= world.time || user.stat != CONSCIOUS)
		return
	var/sound
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled() && !miming)
		user.nextsoundemote = world.time + 7
		if(issilicon(user))
			sound = 'modular_citadel/sound/voice/scream_silicon.ogg'
			if(iscyborg(user))
				var/mob/living/silicon/robot/S = user
				if(S.cell?.charge < 20)
					to_chat(S, "<span class='warning'>Scream module deactivated. Please recharge.</span>")
					return
				S.cell.use(200)
		if(ismonkey(user))
			sound = 'modular_citadel/sound/voice/scream_monkey.ogg'
		if(istype(user, /mob/living/simple_animal/hostile/gorilla))
			sound = 'sound/creatures/gorilla.ogg'
		if(ishuman(user))
			user.adjustOxyLoss(5)
			var/mob/living/carbon/human/H = user
			var/datum/species/userspecies = H.dna.species
			if(H)
				if(userspecies.screamsounds.len)
					sound = pick(userspecies.screamsounds)
				if(H.gender == FEMALE)
					if(userspecies.femalescreamsounds.len)
						sound = pick(userspecies.femalescreamsounds)
		if(isalien(user))
			sound = 'sound/voice/hiss6.ogg'
		LAZYINITLIST(user.alternate_screams)
		if(LAZYLEN(user.alternate_screams))
			sound = pick(user.alternate_screams)
		playsound(user.loc, sound, 50, 1, 4, 1.2)
		message = "screams!"
	else if(miming)
		message = "acts out a scream."
	else
		message = "makes a very loud noise."
	. = ..()
/datum/emote/living/fingerguns
	key = "fingergun"
	key_third_person = "fingerguns"
	restraint_check = TRUE

/datum/emote/living/fingerguns/run_emote(mob/user, params)
	. = ..()
	if(!.)
		return
	var/obj/item/toy/gun/finger/G = new(user)
	if(user.put_in_hands(G))
		to_chat(user, "<span class='notice'>You ready your finger gun.</span>")
	else
		to_chat(user, "<span class='warning'>You're incapable of finger gunning in your current state.</span>")
		qdel(G)

/obj/item/toy/gun/finger
	name = "finger gun"
	desc = "BANG! BANG! BANG!"
	item_state = null
	shotsound = 'modular_skyrat/sound/emotes/trash/pew.ogg'
	dry_fire = FALSE
	infiniteboolet = TRUE

/obj/item/toy/gun/finger/dropped(mob/user)
	..()
	if(loc != user)
		qdel(src)

/datum/emote/living/dothemario
	key = "dothemario"
	key_third_person = "doesthemario"
	message = "swings their arm from side to side!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/dothemario/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		playsound(get_turf(user), 'modular_skyrat/sound/emotes/trash/themario.ogg', 50, 0)
		animate(user, pixel_x = pixel_x + 6, 10)
		sleep(10)
		animate(user, pixel_x = pixel_x - 12, 10)
		sleep(10)
		animate(user, pixel_x = pixel_x + 6, 3)

/datum/emote/living/dab/ultra
	key = "ultradab"
	key_third_person = "ultradabs"
	message = "does the sickest dab a humanoid could ever possibly conjure!"

/datum/emote/living/dab/ultra/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(.)
		playsound(get_turf(user), 'modular_skyrat/sound/emotes/trash/dab.ogg', 20, 0)
		var/initialcolor = user.color
		user.color = "#8B4513"
		sleep(5)
		user.color = initialcolor

/datum/emote/spin/speen
	key = "speen"
	key_third_person = "speens"
	message = "speens!"

/datum/emote/spin/speen/run_emote(mob/user)
	. = ..()
	if(.)
		playsound(get_turf(user), 'modular_skyrat/sound/emotes/trash/speen.ogg', 30, 0)
