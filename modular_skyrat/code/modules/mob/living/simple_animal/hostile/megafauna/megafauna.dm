/mob/living/simple_animal/hostile/megafauna
	var/glorykill = FALSE //CAN THIS MOTHERFUCKER BE SNAPPED IN HALF FOR HEALTH?
	var/list/glorymessageshand = list() //WHAT THE FUCK ARE THE MESSAGES SAID BY THIS CUNT WHEN HE'S GLORY KILLED WITH AN EMPTY HAND?
	var/list/glorymessagescrusher = list() //SAME AS ABOVE BUT CRUSHER
	var/list/glorymessagespka = list() //SAME AS ABOVE THE ABOVE BUT PKA
	var/list/glorymessagespkabayonet = list() //SAME AS ABOVE BUT WITH A HONKING KNIFE ON THE FUCKING THING
	var/gloryhealth = 200
	var/sound/song
	var/songlength
	var/songend

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
				if(song && !songend)
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

/mob/living/simple_animal/hostile/megafauna/Life()
	..()
	if(songend)
		if(world.time >= songend)
			for(var/mob/living/M in view(src, vision_range))
				M.stop_sound_channel(CHANNEL_AMBIENCE)
				songend = songlength + world.time
				M.playsound_local(null, null, 30, channel = CHANNEL_AMBIENCE, S = song)
	if(health <= (maxHealth/25) && !glorykill && stat != DEAD)
		glorykill = TRUE
		glory()

/mob/living/simple_animal/hostile/megafauna/proc/glory()
	desc += "<br><b>[src] is staggered and can be glory killed!</b>"
	animate(src, color = "#00FFFF", time = 5)

/mob/living/simple_animal/hostile/megafauna/death()
	..()
	for(var/mob/living/M in view(src, vision_range))
		M.stop_sound_channel(CHANNEL_AMBIENCE)
	animate(src, color = initial(color), time = 3)
	desc = initial(desc)

/mob/living/simple_animal/hostile/megafauna/AltClick(mob/living/carbon/slayer)
	if(glorykill && stat != DEAD)]
		if(H.ranged)
			if(H.ranged_cooldown >= world.time)
				H.ranged_cooldown += 10
			else
				H.ranged_cooldown = 10 + world.time
		if(do_after(slayer, 10, needhand = TRUE, target = src, progress = FALSE))
			var/message
			if(!slayer.get_active_held_item() || (!istype(slayer.get_active_held_item(), /obj/item/twohanded/kinetic_crusher) && !istype(slayer.get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator)))
				message = pick(glorymessageshand)
			else if(istype(slayer.get_active_held_item(), /obj/item/twohanded/kinetic_crusher))
				message = pick(glorymessagescrusher)
			else if(istype(slayer.get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator))
				message = pick(glorymessagespka)
				var/obj/item/gun/energy/kinetic_accelerator/KA = get_active_held_item()
				if(KA && KA.bayonet)
					message = pick(glorymessagespka | glorymessagespkabayonet)
			if(message)
				visible_message("<span class='danger'><b>[slayer] [message]</b></span>")
			else
				visible_message("<span class='danger'><b>[slayer] does something generally considered brutal to [src]... Whatever that may be!</b></span>")
			slayer.heal_overall_damage(gloryhealth,gloryhealth)
			playsound(src.loc, death_sound, 150, TRUE, -1)
			health = 0
			death()
		else
			to_chat(slayer, "<span class='danger'>You fail to glory kill [src]!</span>")

/mob/living/simple_animal/hostile/megafauna/devour(mob/living/L)
	L.stop_sound_channel(CHANNEL_AMBIENCE)
	..()