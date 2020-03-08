//cum
/mob/living/simple_animal/hostile/megafauna/SetRecoveryTime(buffer_time, ranged_buffer_time)
	recovery_time = world.time + buffer_time
	ranged_cooldown = world.time + buffer_time
	if(ranged_buffer_time)
		ranged_cooldown = world.time + ranged_buffer_time

/mob/living/simple_animal/hostile/megafauna
	var/list/enemies = list()

/mob/living/simple_animal/hostile/megafauna/Found(atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(!L.stat)
			return L
		else
			enemies -= L
	else if(ismecha(A))
		var/obj/mecha/M = A
		if(M.occupant)
			return A

/mob/living/simple_animal/hostile/megafauna/ListTargets()
	if(!enemies.len)
		return list()
	var/list/see = ..()
	see &= enemies // Remove all entries that aren't in enemies
	return see

/mob/living/simple_animal/hostile/megafauna/proc/Retaliate()
	var/list/around = view(src, vision_range)
	for(var/atom/movable/A in around)
		if(A == src)
			continue
		if(isliving(A))
			var/mob/living/M = A
			if(faction_check_mob(M) && attack_same || !faction_check_mob(M))
				enemies |= M
				if(song && (!songend || world.time > songend))
					M.stop_sound_channel(CHANNEL_AMBIENCE)
					songend = songlength + world.time
					M.playsound_local(null, null, 30, channel = CHANNEL_AMBIENCE, S = song) // so silence ambience will mute moosic for people who don't want that
		else if(ismecha(A))
			var/obj/mecha/M = A
			if(M.occupant)
				enemies |= M
				enemies |= M.occupant
				var/mob/living/O = M.occupant
				O.stop_sound_channel(CHANNEL_AMBIENCE)
				songend = songlength + world.time
				O.playsound_local(null, null, 30, channel = CHANNEL_AMBIENCE, S = song)

	for(var/mob/living/simple_animal/hostile/megafauna/H in around)
		if(faction_check_mob(H) && !attack_same && !H.attack_same)
			H.enemies |= enemies
	return 0

/mob/living/simple_animal/hostile/megafauna/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0 && stat == CONSCIOUS)
		Retaliate()

/mob/living/simple_animal/hostile/megafauna
	var/sound/song
	var/songlength
	var/songend
	weather_immunities = list("lava","ash", "snow")

/mob/living/simple_animal/hostile/megafauna/Life()
	..()
	if(songend)
		if(world.time >= songend)
			for(var/mob/living/M in view(src, vision_range))
				M.stop_sound_channel(CHANNEL_AMBIENCE)
				songend = songlength + world.time
				M.playsound_local(null, null, 30, channel = CHANNEL_JUKEBOX, S = song)

/mob/living/simple_animal/hostile/megafauna/death()
	..()
	for(var/mob/living/M in view(src, vision_range))
		M.stop_sound_channel(CHANNEL_AMBIENCE)

/mob/living/simple_animal/hostile/megafauna/devour(mob/living/L)
	L.stop_sound_channel(CHANNEL_AMBIENCE)
	..()