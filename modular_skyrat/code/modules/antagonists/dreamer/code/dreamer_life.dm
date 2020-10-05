//Life procs related to dreamer, so he hallucinates and shit
/mob/living/carbon/BiologicalLife(seconds, times_fired)
	. = ..()
	handle_dreamer()

/mob/living/carbon/proc/handle_dreamer()
	if(mind && client && hud_used && hud_used.dreamer)
		spawn(0)
			handle_dreamer_hallucinations()
		if((combat_flags & COMBAT_MODE_ACTIVE) || hud_used.dreamer.waking_up)
			spawn(0)
				handle_dreamer_screenshake()

/mob/living/carbon/proc/handle_dreamer_hallucinations()
	if(prob(4)) //Standard screen flash annoyance
		var/obj/screen/dreamer/dream = hud_used?.dreamer
		if(dream)
			dream.icon_state = "hall[rand(1,9)]"
			dream.alpha = 255
			animate(dream, dream.alpha = 0, time = 10)
			var/hallsound = pick(
								'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_appear1.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_appear2.ogg',
								'modular_skyrat/code/modules/antagonists/dreamer/sound/hall_appear3.ogg',
								)
			playsound_local(get_turf(src), hallsound, 100, 0)
			if(prob(50))
				var/comicsound = pick(
									'modular_skyrat/code/modules/antagonists/dreamer/sound/comic1.ogg',
									'modular_skyrat/code/modules/antagonists/dreamer/sound/comic2.ogg',
									'modular_skyrat/code/modules/antagonists/dreamer/sound/comic3.ogg',
									'modular_skyrat/code/modules/antagonists/dreamer/sound/comic4.ogg',
									)
				playsound_local(get_turf(src), comicsound, 100, 0)
	else if(prob(2)) //Just random laughter
		var/comicsound = pick('modular_skyrat/code/modules/antagonists/dreamer/sound/comic1.ogg',
							'modular_skyrat/code/modules/antagonists/dreamer/sound/comic2.ogg',
							'modular_skyrat/code/modules/antagonists/dreamer/sound/comic3.ogg',
							'modular_skyrat/code/modules/antagonists/dreamer/sound/comic4.ogg',
							)
		playsound_local(get_turf(src), comicsound, 100, 0)
	else if(prob(1)) //VERY rare mom hallucination
		var/mom_msg = pick("It's mom!", "I have to HURRY UP!")
		to_chat(src, "<span class='userdanger'>[mom_msg]</span>")
	if(prob(10))
		var/list/objects = list()
		for(var/obj/O in view(7, src))
			objects += O
		if(length(objects))
			var/message = pick("[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]",
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
								"Show them your powers.")
			var/obj/speaker = pick(objects)
			to_chat(src, "<b>[capitalize(speaker.name)]</b> says, \"[message]\"")
	for(var/turf/T in view(7, src))
		if(prob(4))
			T.dreamer_hallucination = image(T.icon, T.loc, T.icon_state, T.layer+0.1, T.dir)
			src << T.dreamer_hallucination
			spawn(0)
				handle_dreamer_turf(T)

/mob/living/carbon/proc/handle_dreamer_turf(turf/T)
	var/image/I = T.dreamer_hallucination
	var/offset = pick(-3,-2, -1, 1, 2, 3)
	var/disappearfirst = rand(5, 15)
	animate(I, I.pixel_y = I.pixel_y + offset, time = disappearfirst)
	sleep(disappearfirst)
	var/disappearsecond = rand(10, 15)	
	animate(I, I.pixel_y = I.pixel_y - offset, time = disappearsecond)
	sleep(disappearsecond)
	QDEL_NULL(T.dreamer_hallucination)

/turf
	var/image/dreamer_hallucination

/mob/living/carbon/proc/handle_dreamer_screenshake()
	var/client/C = client
	var/shakeit = 0
	while(shakeit < 10)
		shakeit++
		var/intensity = rand(1,2)
		animate(C, C.pixel_y = C.pixel_y + intensity, time = 1)
		sleep(1)
		animate(C, C.pixel_y = C.pixel_y - intensity, time = 1)
		sleep(1)
