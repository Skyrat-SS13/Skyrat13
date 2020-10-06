//Life procs related to dreamer, so he hallucinates and shit
/mob/living/carbon
	var/dreamer_dreaming = FALSE

/mob/living/carbon/BiologicalLife(seconds, times_fired)
	. = ..()
	handle_dreamer()

/mob/living/carbon/proc/handle_dreamer()
	if(mind && client && hud_used && hud_used.dreamer)
		if(SEND_SIGNAL(src, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE) || hud_used.dreamer.waking_up)
			spawn(0)
				handle_dreamer_screenshake()
		spawn(0)
			handle_dreamer_hallucinations()
		if(hud_used.dreamer.waking_up)
			spawn(0)
				handle_dreamer_waking_up()

/mob/living/carbon/proc/handle_dreamer_hallucinations()
	if(dreamer_dreaming)
		return
	//Modo waker ATIVAR
	dreamer_dreaming = TRUE
	//Standard screen flash annoyance
	if(prob(3))
		var/obj/screen/fullscreen/dreamer/dream = hud_used?.dreamer
		if(dream)
			dream.icon_state = "hall[rand(1,9)]"
			var/kill_her = 2
			animate(dream, alpha = 255, time = kill_her)
			spawn(kill_her)
				var/hallsound = pick(
									'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_appear1.ogg',
									'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_appear2.ogg',
									'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_appear3.ogg',
									)
				playsound_local(get_turf(src), hallsound, 100, 0)
				spawn(1)
					if(prob(50))
						var/comicsound = pick(
											'modular_skyrat/code/modules/antagonists/dreamer/sound/comic1.ogg',
											'modular_skyrat/code/modules/antagonists/dreamer/sound/comic2.ogg',
											'modular_skyrat/code/modules/antagonists/dreamer/sound/comic3.ogg',
											'modular_skyrat/code/modules/antagonists/dreamer/sound/comic4.ogg',
											)
						playsound_local(get_turf(src), comicsound, 100, 0)
					spawn(rand(5, 15))
						animate(dream, alpha = 0, time = 10)
	//Just random laughter
	else if(prob(2))
		var/comicsound = pick('modular_skyrat/code/modules/antagonists/dreamer/sound/comic1.ogg',
							'modular_skyrat/code/modules/antagonists/dreamer/sound/comic2.ogg',
							'modular_skyrat/code/modules/antagonists/dreamer/sound/comic3.ogg',
							'modular_skyrat/code/modules/antagonists/dreamer/sound/comic4.ogg',
							)
		playsound_local(get_turf(src), comicsound, 100, 0)
	//Crewmember radioing
	else if(prob(1))
		var/list/people = list()
		for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
			people += H
		if(length(people))
			var/mob/living/carbon/human/person = pick(people)
			var/speak = pick("We are DYING to see your WONDERS.",
							"We will help you wake up.",
							"You can kill us.",
							"Let's wake up, together.",
							)
			var/message = compose_message(person, language_holder?.selected_language, speak,"[FREQ_COMMON]", list(person.speech_span), face_name = TRUE, source = (person.ears ? person.ears : person.ears_extra))
			to_chat(src, message)
	//VERY rare mom/mob hallucination
	else if(prob(1) && prob(50))
		spawn(0)
			handle_dreamer_mob_hallucination()
	//Talking objects
	if(prob(5))
		var/list/objects = list()
		for(var/obj/O in view(src))
			objects += O
		if(length(objects))
			var/message
			if(prob(66) || !length(last_words))
				message = pick("[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]",
								"Show them your WONDERS.",
								"Look inside me.",
								"You're not evil. You'll meet the real evil before you die.",
								"Tell them what made you do it. They will forgive you.",
								"You have the right to lie to me too.",
								"Who am i?",
								"Who are you?",
								"Hey.",
								"Hello.",
								"Avoid speech.",
								"Silence.",
								"Why do you bother?",
								"You're vile.",
								"I hate you.",
								"Sightless, unless my eyes reappear.",
								"I love you.",
								"Trust me.",
								"It's all in your head.",
								"Do you enjoy what you do?",
								"Do you like hurting other people?",
								"None of this is real.",
								"You will be put on a cross.",
								"HATE.",
								"DEATH.",
								"PUTREFACTION.",
								"Reality.",
								"You can do it.",
								"You're real.",
								"You don't deserve to be loved.",
								"Why are we still here?",
								"Just to suffer?",
								"In the end.",
								"None of this matters.",
								"Murderer.",
								"Trey Liam. That is your name.",
								"Whispering.",
								"Show them your powers.",
								"One, two, three, four...",
								"Wake up.",
								)
			else
				message = last_words
			var/obj/speaker = pick(objects)
			if(speaker && message)
				var/speak_sound = pick(
								'modular_skyrat/code/modules/antagonists/dreamer/sound/female_talk1.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/female_talk2.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/female_talk3.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/female_talk4.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/female_talk5.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/male_talk1.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/male_talk2.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/male_talk3.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/male_talk4.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/male_talk5.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/male_talk6.ogg',
								)
				playsound_local(get_turf(src), speak_sound, 50, 0)
				var/new_message = compose_message(speaker, language_holder?.selected_language, message)
				to_chat(src, new_message)
				create_chat_message(speaker, null, message)
	//Floors go crazy go stupid
	var/list/turf/open/floor/floorlist = list()
	for(var/turf/open/floor/F in view(src))
		if(prob(15))
			floorlist += F
	for(var/F in floorlist)
		spawn(0)
			handle_dreamer_floor(F)
	
	//Walls go crazy go stupid
	var/list/turf/closed/wall/walllist = list()
	for(var/turf/closed/wall/W in view(src))
		if(prob(7))
			walllist += W
	for(var/W in walllist)
		spawn(0)
			handle_dreamer_wall(W)
	
	dreamer_dreaming = FALSE

/mob/living/carbon/proc/handle_dreamer_floor(turf/open/floor/T)
	if(!T || !client)
		return
	var/image/I = image(T.icon, T, T.icon_state, T.layer+0.1, T.dir)
	src.client?.images += I
	var/offset = pick(-3,-2, -1, 1, 2, 3)
	var/disappearfirst = (rand(10, 30) * abs(offset))
	animate(I, pixel_y = (pixel_y + offset), time = disappearfirst)
	sleep(disappearfirst)
	var/disappearsecond = (rand(10, 30) * abs(offset))	
	animate(I, pixel_y = (pixel_y - offset), time = disappearsecond)
	sleep(disappearsecond)
	src.client?.images -= I
	qdel(I)

/mob/living/carbon/proc/handle_dreamer_wall(turf/closed/wall/W)
	if(!W || !client)
		return
	var/image/I = image('icons/effects/blood.dmi', W, "floor[rand(1,7)]", W.layer+0.1)
	I.color = BLOOD_COLOR_HUMAN
	src.client?.images += I
	var/offset = pick(-1, 1, 2)
	var/disappearfirst = rand(20, 40)
	animate(I, pixel_y = (pixel_y + offset), time = disappearfirst)
	sleep(disappearfirst)
	var/disappearsecond = rand(20, 40)	
	animate(I, pixel_y = (pixel_y - offset), time = disappearsecond)
	sleep(disappearsecond)
	src.client?.images -= I
	qdel(I)

/mob/living/carbon/proc/handle_dreamer_screenshake()
	if(!client)
		return
	var/client/C = client
	var/shakeit = 0
	while(shakeit < 10)
		shakeit++
		var/intensity = 1 //i tried rand(1,2) but even that was 2 intense
		animate(C, pixel_y = (pixel_y + intensity), time = intensity)
		sleep(intensity)
		animate(C, pixel_y = (pixel_y - intensity), time = intensity)
		sleep(intensity)

/mob/living/carbon/proc/handle_dreamer_mob_hallucination()
	if(!client)
		return
	var/mob_msg = pick("It's mom!", "I have to HURRY UP!", "They are CLOSE!","They are NEAR!")
	var/turf/turfie
	var/list/turf/turfies = list()
	for(var/turf/torf in view(src))
		turfies += torf
	if(length(turfies))
		turfie = pick(turfies)
	if(!turfie)
		return
	var/hall_type = pick("mom", "M3", "deepone")
	if(mob_msg == "It's mom!")
		hall_type = "mom"
	var/image/I = image('modular_skyrat/code/modules/antagonists/dreamer/icons/dreamer_mobs.dmi', turfie, hall_type, FLOAT_LAYER, get_dir(turfie, src))
	I.plane = FLOAT_PLANE
	src.client?.images += I
	to_chat(src, "<span class='userdanger'>[mob_msg]</span>")
	sleep(5)
	var/hallsound = pick(
						'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_attack1.ogg',
						'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_attack2.ogg',
						'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_attack3.ogg',
						'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_attack4.ogg',
						)
	playsound_local(get_turf(src), hallsound, 100, 0)
	var/chase_tiles = 7
	var/chase_wait_per_tile = rand(3,5)
	var/caught_dreamer = FALSE
	while(chase_tiles > 0)
		turfie = get_step(turfie, get_dir(turfie, src))
		if(turfie)
			src.client?.images -= I
			qdel(I)
			I = image('modular_skyrat/code/modules/antagonists/dreamer/icons/dreamer_mobs.dmi', turfie, hall_type, FLOAT_LAYER, get_dir(turfie, src))
			I.plane = FLOAT_PLANE
			src.client?.images += I
			if(turfie == get_turf(src))
				caught_dreamer = TRUE
				sleep(chase_wait_per_tile)
				break
		chase_tiles--
		sleep(chase_wait_per_tile)
	src.client?.images -= I
	if(!QDELETED(I))
		qdel(I)
	if(caught_dreamer)
		Paralyze(rand(3, 5) SECONDS)
		var/pain_msg = pick("NO!", "THEY GOT ME!", "AGH!")
		custom_pain("<span class='userdanger'>[pain_msg]</span>", 40, TRUE, (get_bodypart(BODY_ZONE_HEAD) ? get_bodypart(BODY_ZONE_HEAD) : bodyparts[1]))

/mob/living/carbon/proc/handle_dreamer_waking_up()
	if(!client)
		return
	var/list/turf/open/floor/floorlist = list()
	for(var/turf/open/floor/F in view(src))
		if(prob(15))
			floorlist += F
	for(var/F in floorlist)
		spawn(0)
			handle_waking_up_floor(F)

/mob/living/carbon/proc/handle_waking_up_floor(turf/open/floor/T)
	if(!T)
		return
	var/image/I = image('icons/turf/floors.dmi', T, pick("rcircuitanim", "gcircuitanim"), T.layer+0.1, T.dir)
	src.client?.images += I
	var/offset = pick(-1, 1)
	var/disappearfirst = 30
	animate(I, pixel_y = (pixel_y + offset), time = disappearfirst)
	sleep(disappearfirst)
	var/disappearsecond = 30
	animate(I, pixel_y = (pixel_y - offset), time = disappearsecond)
	sleep(disappearsecond)
	src.client?.images -= I
	qdel(I)
