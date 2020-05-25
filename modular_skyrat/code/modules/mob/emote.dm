/obj/effect/overlay/emote_popup
	icon = 'modular_skyrat/icons/mob/popup_flicks.dmi'
	icon_state = "combat"
	layer = FLY_LAYER
	plane = GAME_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	mouse_opacity = 0

/proc/flick_emote_popup_on_mob(mob/M, state, time)
	var/obj/effect/overlay/emote_popup/I = new
	I.icon_state = state
	M.vis_contents += I
	animate(I, alpha = 255, time = 5, easing = BOUNCE_EASING, pixel_y = 10)
	QDEL_IN_CLIENT_TIME(I, time)

/mob/emote(act, m_type = null, message = null, intentional = FALSE)
	. = ..()
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

/datum/emote/flip/run_emote(mob/living/user, params) //no fun allowed :)
	if(prob(20))
		user.visible_message("<span class='warning'>[user] tries to flip, but lands flat on their face!</span>", "<span class='danger'>You try to flip, but land flat on your face!</span>")
		user.Knockdown(20)
		user.setDir(NORTH)
		user.apply_damage(rand(1, 8), BRUTE, BODY_ZONE_HEAD)
		user.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1, 5), 20)
	else
		. = ..()

// Bababooey, and his lads.
/datum/emote/living/bababooey
	key = "bababooey"
	key_third_person = "bababooeys"
	message = "spews bababooey."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/bababooey/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.is_muzzled())
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_skyrat/sound/voice/ffffhfh.ogg', 25, 1, -1)
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/sound/voice/bababooey.ogg', 50, 1, -1)

/datum/emote/living/fafafooey
	key = "fafafooey"
	key_third_person = "fafafooeys"
	message = "spews fafafooey."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/fafafooey/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.is_muzzled())
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_skyrat/sound/voice/ffffhfh.ogg', 25, 1, -1)
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	var/sound = pick('modular_skyrat/sound/voice/fafafooey.ogg', 'modular_skyrat/sound/voice/fafafooey2.ogg')
	playsound(user, sound, 50, 1, -1)

/datum/emote/living/fafafoggy
	key = "fafafoggy"
	key_third_person = "fafafoggys"
	message = "spews fafafoggy."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/fafafoggy/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.is_muzzled())
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_skyrat/sound/voice/ffffhfh.ogg', 25, 1, -1)
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	var/sound = pick('modular_skyrat/sound/voice/fafafoggy.ogg', 'modular_skyrat/sound/voice/fafafoggy2.ogg')
	playsound(user, sound, 50, 1, -1)

/datum/emote/living/hohohoy
	key = "hohohoy"
	key_third_person = "hohohoys"
	message = "spews hohohoy."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/hohohoy/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.is_muzzled())
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_skyrat/sound/voice/ffffhfh.ogg', 25, 1, -1)
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/sound/voice/hohohoy.ogg', 50, 1, -1)
