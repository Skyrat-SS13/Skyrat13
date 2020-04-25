/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner
	name = "demonic-frost miner"
	desc = "An extremely geared miner, driven crazy or possessed by the demonic forces here, either way a terrifying enemy."
	health = 1250
	maxHealth = 1250
	icon_state = "demonic_miner"
	icon_living = "demonic_miner"
	icon = 'modular_skyrat/icons/mob/icemoon/icemoon_monsters.dmi'
	attacktext = "pummels"
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	light_color = "#E4C7C5"
	movement_type = GROUND
	weather_immunities = list("snow")
	speak_emote = list("roars")
	armour_penetration = 100
	melee_damage_lower = 10
	melee_damage_upper = 10
	rapid_melee = 4
	speed = 20
	move_to_delay = 20
	ranged = TRUE
	crusher_loot = list(/obj/effect/decal/remains/plasma, /obj/item/pickaxe/drill/jackhammer, /obj/item/crusher_trophy/miner_eye)
	loot = list(/obj/effect/decal/remains/plasma, /obj/item/pickaxe/drill/jackhammer)
	wander = FALSE
	del_on_death = TRUE
	blood_volume = BLOOD_VOLUME_NORMAL
	var/projectile_speed_multiplier = 1
	var/enraged = FALSE
	var/enraging = FALSE
	songs = list("1530" = sound(file = 'modular_skyrat/sound/ambience/lisapebbleman.ogg', repeat = 0, wait = 0, volume = 100, channel = CHANNEL_AMBIENCE)) // Doubt the creator would care lol
	deathmessage = "falls to the ground, decaying into plasma particles."
	deathsound = "bodyfall"

/obj/item/gps/internal/demonicminer
	icon_state = null
	gpstag = "Demonic Signal"
	desc = "Blood for the blood god!"
	invisibility = 100

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/Initialize()
	. = ..()
	AddComponent(/datum/component/knockback, 7, FALSE)
	AddComponent(/datum/component/lifesteal, 50)
	internal = new/obj/item/gps/internal/demonicminer(src)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/OpenFire()
	check_enraged()
	projectile_speed_multiplier = 1 + enraged // ranges from normal to 2x speed
	SetRecoveryTime(80, 80)

	if(!enraged || prob(50))
		var/chosen_attack = rand(1, 3)
		switch(chosen_attack)
			if(1)
				if(prob(70))
					frost_orbs()
				else
					frost_orbs(3, list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
			if(2)
				if(prob(70))
					snowball_machine_gun(60)
				else
					INVOKE_ASYNC(src, .proc/ice_shotgun, 5, list(list(-180, -140, -100, -60, -20, 20, 60, 100, 140), list(-160, -120, -80, -40, 0, 40, 80, 120, 160)))
					snowball_machine_gun(5 * 8, 5)
			if(3)
				if(prob(70))
					ice_shotgun()
				else
					ice_shotgun(5, list(list(0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330), list(-30, -15, 0, 15, 30)))
	else
		var/chosen_attack = rand(1, 1)
		switch(chosen_attack)
			if(1)
				aoe_stomp()

/obj/item/projectile/frost_orb
	name = "frost orb"
	icon_state = "ice_1"
	damage = 20
	armour_penetration = 100
	speed = 10
	homing_turn_speed = 90
	damage_type = BURN

/obj/item/projectile/frost_orb/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isturf(target) || isobj(target))
		target.ex_act(EXPLODE_HEAVY)

/obj/item/projectile/snowball
	name = "machine-gun snowball"
	icon_state = "nuclear_particle"
	damage = 5
	armour_penetration = 100
	speed = 4
	damage_type = BRUTE

/obj/item/projectile/ice_blast
	name = "ice blast"
	icon_state = "ice_2"
	damage = 15
	armour_penetration = 100
	speed = 4
	damage_type = BRUTE

/obj/item/projectile/ice_blast/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isturf(target) || isobj(target))
		target.ex_act(EXPLODE_HEAVY)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/ex_act(severity, target)
	adjustBruteLoss(30 * severity - 120)
	visible_message("<span class='danger'>[src] absorbs the explosion!</span>", "<span class='userdanger'>You absorb the explosion!</span>")
	return

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/Goto(target, delay, minimum_distance)
	if(!enraging)
		. = ..()

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/MoveToTarget(list/possible_targets)
	if(!enraging)
		. = ..()

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/Move()
	if(!enraging)
		. = ..()

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/proc/frost_orbs(added_delay = 6, list/shoot_dirs = pick(GLOB.cardinals, GLOB.diagonals))
	for(var/dir in shoot_dirs)
		var/turf/startloc = get_turf(src)
		var/turf/endloc = get_turf(target)
		if(!endloc)
			break
		var/obj/item/projectile/P = new /obj/item/projectile/frost_orb(startloc)
		P.preparePixelProjectile(endloc, startloc)
		P.firer = src
		if(target)
			P.original = target
		P.set_homing_target(target)
		P.fire(dir2angle(dir))
		addtimer(CALLBACK(src, .proc/orb_explosion, P), 20) // make the orbs home in after a second
		sleep(added_delay)
	SetRecoveryTime(20, 40)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/proc/orb_explosion(obj/item/projectile/orb)
	var/spread = 5
	for(var/i in 1 to 6)
		var/turf/startloc = get_turf(orb)
		var/turf/endloc = get_turf(target)
		if(!startloc || !endloc)
			break
		var/obj/item/projectile/P = new /obj/item/projectile/snowball(startloc)
		P.speed /= projectile_speed_multiplier
		P.preparePixelProjectile(endloc, startloc, null, rand(-spread, spread))
		P.firer = src
		if(target)
			P.original = target
		P.fire()
	qdel(orb)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/proc/snowball_machine_gun(shots = 30, spread = 10)
	for(var/i in 1 to shots)
		var/turf/startloc = get_turf(src)
		var/turf/endloc = get_turf(target)
		if(!endloc)
			break
		var/obj/item/projectile/P = new /obj/item/projectile/snowball(startloc)
		P.speed /= projectile_speed_multiplier
		P.preparePixelProjectile(endloc, startloc, null, rand(-spread, spread))
		P.firer = src
		if(target)
			P.original = target
		P.fire()
		sleep(1)
	SetRecoveryTime(15, 15)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/proc/ice_shotgun(shots = 5, list/patterns = list(list(-40, -20, 0, 20, 40), list(-30, -10, 10, 30)))
	for(var/i in 1 to shots)
		var/list/pattern = patterns[i % length(patterns) + 1] // alternating patterns
		for(var/spread in pattern)
			var/turf/startloc = get_turf(src)
			var/turf/endloc = get_turf(target)
			if(!endloc)
				break
			var/obj/item/projectile/P = new /obj/item/projectile/ice_blast(startloc)
			P.speed /= projectile_speed_multiplier
			P.preparePixelProjectile(endloc, startloc, null, spread)
			P.firer = src
			if(target)
				P.original = target
			P.fire()
		sleep(8)
	SetRecoveryTime(15, 20)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/proc/aoe_stomp()
	var/max_dist = 1
	for(var/turf/T in RANGE_TURFS(5, src))
		var/dist = get_dist(src, T)
		if(dist > max_dist)
			max_dist = dist
			sleep(2)
		for(var/mob/living/L in T)
			shake_camera(L, 4, 3)
			L.adjustBruteLoss(20)
			var/turf/throw_at = get_ranged_target_turf(L, get_dir(src, L), 5)
			L.throw_at(throw_at, 6, EXPLOSION_THROW_SPEED)
		var/x_diff = T.x - src.x
		var/y_diff = T.y - src.y
		animate(T, pixel_x = x_diff * 1/8, pixel_y = y_diff * 1/8, time = 1, loop = 4, easing = ELASTIC_EASING)

/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner/proc/check_enraged()
	if(health <= maxHealth*0.25 && !enraged)
		SetRecoveryTime(80, 80)
		adjustHealth(-maxHealth)
		enraged = TRUE
		enraging = TRUE
		animate(src, pixel_y = pixel_y + 96, time = 100, easing = ELASTIC_EASING)
		spin(100, 10)
		sleep(80)
		playsound(src, 'sound/effects/explosion3.ogg', 100, TRUE)
		overlays += mutable_appearance('icons/effects/effects.dmi', "curse")
		animate(src, pixel_y = pixel_y - 96, time = 8, flags = ANIMATION_END_NOW)
		spin(8, 2)
		sleep(8)
		setMovetype(movement_type | FLYING)
		enraging = FALSE
		adjustHealth(-maxHealth)