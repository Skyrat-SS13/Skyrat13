/mob/living/simple_animal/hostile/baldi
	name = "Baldi"
	desc = "Bald people are already terrible by nature. This is worse."
	icon = 'modular_skyrat/icons/mob/baldi.dmi'
	icon_state = "baldi"
	icon_living = "baldi"
	icon_dead = "baldead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	attacktext = "ruler slaps"
	attack_sound = 'modular_skyrat/sound/baldi/BAL_Slap.wav'
	faction = list("schoolhouse")
	obj_damage = 100
	dodge_prob = 0
	ranged = 0
	melee_damage_upper = 65
	melee_damage_lower = 25
	robust_searching = 1
	vision_range = 10
	aggro_vision_range = 21
	minimum_distance = 1
	stat_attack = CONSCIOUS | UNCONSCIOUS | DEAD
	maxHealth = 450
	health = 450
	var/vored = list() //yes baldi vores the people he kills
	var/steps_per_slap = 3
	var/movecooldown = 0
	var/movecooldowntime = 8

/mob/living/simple_animal/hostile/baldi/Move(atom/newloc, dir, step_x, step_y)
	if(movecooldown >= world.time)
		return
	playsound(src.loc, 'modular_skyrat/sound/baldi/BAL_Slap.wav',80, 0, 10)
	var/mob/living/M = target
	for(var/i in 1 to steps_per_slap)
		var/broke = FALSE
		if(M)
			if(M in getline(src, locate(x - vision_range, y, z)))
				broke = TRUE
			else if(M in getline(src, locate(x + vision_range, y, z)))
				broke = TRUE
			else if(M in getline(src, locate(x, y + vision_range, z)))
				broke = TRUE
			else if(M in getline(src, locate(x, y - vision_range, z)))
				broke = TRUE
			if(broke)
				break
		if(broke)
			break
		var/turf/T = get_step(src, dir)
		..(T, dir, step_x, step_y)
	movecooldown = world.time + movecooldowntime

/mob/living/simple_animal/hostile/baldi/adjustHealth(amount, updating_health, forced)
	if(!forced)
		return
	else
		..()

/mob/living/simple_animal/hostile/baldi/AttackingTarget()
	var/mob/living/M = target
	if(M.stat != CONSCIOUS)
		playsound(src.loc, 'modular_skyrat/sound/baldi/BAL_Praise1.wav', 75, 0)
		visible_message("<span style='font-family: Comic Sans MS, Comic Sans, cursive;font-size: 35px;color: #ff0000;font-weight: bold'>[src] swallows [M] whole!</span>")
		M.forceMove(src)
		M.death()
		vored += M
	else
		..()

/mob/living/simple_animal/hostile/baldi/death(gibbed)
	. = ..()
	for(var/mob/L in vored)
		L.forceMove(get_turf(src))
		vored -= L
