//THE GLADIATOR
//Will write a description later lole
/mob/living/simple_animal/hostile/megafauna/gladiator
	name = "\proper The Gladiator"
	desc = "An immortal ash walker, whose powers have been granted by the necropolis itself."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "gladiator1"
	attacktext = "slashes"
	attack_sound = 'sound/weapons/slice.ogg'
	death_sound = 'modular_skyrat/sound/effects/gladiatordeathsound.ogg'
	deathmessage = "gets discombobulated and fucking dies."
	rapid_melee = 2
	melee_queue_distance = 2
	armour_penetration = 20
	melee_damage_lower = 35
	melee_damage_upper = 35
	speed = 1
	move_to_delay = 3
	wander = FALSE
	var/block_chance = 50
	ranged = 1
	ranged_cooldown_time = 30
	minimum_distance = 1
	health = 1500
	maxHealth = 1500
	movement_type = GROUND
	weather_immunities = list("lava","ash")
	var/phase = 1
	var/list/introduced = list() //Basically all the mobs which the gladiator has already introduced himself to.
	var/speen = FALSE
	var/speenrange = 3
	var/obj/savedloot = null
	var/stunned = FALSE
	var/stunduration = 15

/obj/item/gps/internal/gladiator
	icon_state = null
	gpstag = "Dreadful Signal"
	desc = "Let me help you to see, miner."

/mob/living/simple_animal/hostile/megafauna/gladiator/Initialize(mapload)
	. = ..()
	internal = new /obj/item/gps/internal/gladiator(src)

/mob/living/simple_animal/hostile/megafauna/gladiator/Life()
	. = ..()
	for(var/mob/living/M in view(4, src))
		if(!(M in introduced))
			introduction(M)

/mob/living/simple_animal/hostile/megafauna/gladiator/death()
	..()
	forceMove(get_step(src, src.dir))
	icon_state = "gladiator_dying"
	spawn(35)
	icon_state = "gladiator_dead"

/mob/living/simple_animal/hostile/megafauna/gladiator/apply_damage(damage, damagetype, def_zone, blocked, forced)
	if(!wander)
		wander = TRUE
	if(speen)
		blocked = 200
		visible_message("<span class='danger'>[src] brushes off all incoming attacks!")
	else if(prob(50) && (phase == 1) && !stunned)
		blocked = 200
		visible_message("<span class='danger'>[src] blocks all incoming damage with his shield!")
	..()
	update_phase()
	var/adjustment_amount = damage * 0.1
	if(world.time + adjustment_amount > next_move)
		changeNext_move(adjustment_amount)

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/introduction(mob/living/target)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/species/Hspecies = H.dna.species
		if(Hspecies.id == "ashlizard")
			say("Walker.")
			introduced |= H
		else
			var/list/messages = list("What you interfere with now isss bigger than you can imagine... If you continue, you'll bring down the necropolisss' wrath.",\
									"You cannot kill the Legion, miner.",\
									"Retreat, outlander.")
			say(pick(messages))
			introduced |= H
	else
		say("You are not welcome into the necropolisss.")
		introduced |= target

/mob/living/simple_animal/hostile/megafauna/gladiator/Move(atom/newloc, dir, step_x, step_y)
	if(speen || stunned)
		return FALSE
	else
		if(ischasm(newloc))
			var/list/possiblelocs = list()
			switch(dir)
				if(NORTH)
					possiblelocs += locate(x +1, y + 1, z)
					possiblelocs += locate(x -1, y + 1, z)
				if(EAST)
					possiblelocs += locate(x + 1, y + 1, z)
					possiblelocs += locate(x + 1, y - 1, z)
				if(WEST)
					possiblelocs += locate(x - 1, y + 1, z)
					possiblelocs += locate(x - 1, y - 1, z)
				if(SOUTH)
					possiblelocs += locate(x - 1, y - 1, z)
					possiblelocs += locate(x + 1, y - 1, z)
				if(SOUTHEAST)
					possiblelocs += locate(x + 1, y, z)
					possiblelocs += locate(x + 1, y + 1, z)
				if(SOUTHWEST)
					possiblelocs += locate(x - 1, y, z)
					possiblelocs += locate(x - 1, y + 1, z)
				if(NORTHWEST)
					possiblelocs += locate(x - 1, y, z)
					possiblelocs += locate(x - 1, y - 1, z)
				if(NORTHEAST)
					possiblelocs += locate(x + 1, y - 1, z)
					possiblelocs += locate(x + 1, y, z)
			for(var/turf/T in possiblelocs)
				if(ischasm(T))
					possiblelocs -= T
			if(possiblelocs.len)
				var/turf/validloc = pick(possiblelocs)
				return ..(validloc)
			return FALSE
		else
			..()

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/update_phase()
	var/healthpercentage = 100 * (health/maxHealth)
	switch(healthpercentage)
		if(65 to 100)
			phase = 1
			rapid_melee = initial(rapid_melee)
		if(30 to 65)
			phase = 2
			icon_state = "gladiator2"
			rapid_melee = 6
			move_to_delay = 2.5
		if(0 to 30)
			phase = 3
			icon_state = "gladiator3"
			rapid_melee = 8
			move_to_delay = 2

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/zweispin()
	visible_message("<span class='boldwarning'>[src] lifts his zweihander, and prepares to spin!</span>")
	speen = TRUE
	animate(src, color = "#ff6666", 10)
	sleep(10)
	var/list/speendirs = GLOB.alldirs.Copy()
	var/clockwise = TRUE
	if(prob(50))
		clockwise = FALSE
	var/currentdir = pick(speendirs)
	while(speendirs.len)
		var/woop = FALSE
		speendirs -= currentdir
		sleep(6 - phase)
		playsound(src, 'sound/weapons/fwoosh.wav', 50, 0)
		var/turf/old_step = get_turf(src)
		for(var/i, i >= speenrange, i++)
			var/turf/steppy = get_step(old_step, currentdir)
			new /obj/effect/temp_visual/small_smoke/halfsecond(steppy)
			for(var/mob/living/M in steppy)
				if(!faction_check(faction, M.faction))
					playsound(src, 'sound/weapons/slash.ogg', 75, 0)
					if(M.apply_damage(40, BRUTE, BODY_ZONE_CHEST))
						visible_message("<span class = 'userdanger'>[src] slashes [M] with his spinning zweihander!</span>")
					else
						visible_message("<span class = 'userdanger'>[src]'s spinning zweihander is stopped by [M]!</span>")
						woop = TRUE
		if(woop)
			break
		currentdir = angle2dir(dir2angle(currentdir) + (clockwise ? -45 : 45))
	animate(src, color = initial(color), 3)
	sleep(3)
	speen = FALSE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/chargeattack(atom/target, var/range)
	face_atom(target)
	speen = TRUE
	visible_message("<span class='boldwarning'>[src] lifts his shield, and prepares to charge!</span>")
	animate(src, color = "#ff6666", 3)
	sleep(3 + phase)
	var/longstun = FALSE
	var/dirtotarget = get_dir(src, target)
	face_atom(target)
	for(var/i = 0, i >= range, i++)
		var/turf/T = get_step(src, dirtotarget)
		if(target in T)
			if(isliving(target))
				var/mob/living/L = target
				visible_message("<span class='userdanger'>[src] knocks [L] down!</span>")
				L.DefaultCombatKnockdown(20)
				longstun = TRUE
				break
		else if(istype(T, /turf/closed))
			visible_message("<span class='userdanger'>[src] bashes his head against the [T], stunning himself!</span>")
			longstun = TRUE
			break
		else
			forceMove(src, T)
			var/time2sleep = 2
			switch(phase)
				if(1)
					time2sleep = 2.4
				if(2)
					time2sleep = 1.6
				if(3)
					time2sleep = 1
			sleep(time2sleep)
	speen = FALSE
	stunned = TRUE
	animate(src, color = initial(color), 7)
	sleep(longstun ? stunduration : (stunduration/(phase*2)))
	stunned = FALSE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/teleport(atom/target)
	var/turf/T = get_step(target, -target.dir)
	new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(src))
	sleep(4 - phase)
	if(!ischasm(T))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		forceMove(T)
	else
		var/list/possiblelocs = view(3, target)
		for(var/atom/A in possiblelocs)
			if(!isturf(A))
				possiblelocs -= A
			else
				if(ischasm(A) || istype(A, /turf/closed))
					possiblelocs -= A
		if(possiblelocs.len)
			T = pick(possiblelocs)
			new /obj/effect/temp_visual/small_smoke/halfsecond(T)
			forceMove(T)

/mob/living/simple_animal/hostile/megafauna/gladiator/AttackingTarget()
	. = ..()
	if(speen || stunned)
		return
	if(. && prob(15 * phase))
		teleport(target)

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/boneappletea(atom/target)
	var/obj/item/kitchen/knife/combat/bone/boned = new /obj/item/kitchen/knife/combat/bone(get_turf(src))
	boned.throwforce = 35
	playsound(src, 'sound/weapons/fwoosh.wav', 60, 0)
	boned.throw_at(target, 7, 3, src)

/mob/living/simple_animal/hostile/megafauna/gladiator/OpenFire()
	if(get_dist(src, target) > 4)
		ranged_cooldown += 30
		return boneappletea(target)
	switch(phase)
		if(1)
			if(prob(25))
				zweispin()
				ranged_cooldown += 60
			else
				if(prob(65))
					chargeattack(target, 8)
				else
					teleport(target)
					ranged_cooldown += 30
		if(2)
			if(prob(40))
				zweispin()
				ranged_cooldown += 45
			else
				if(prob(50))
					boneappletea(target)
					ranged_cooldown += 20
				else
					teleport(target)
					ranged_cooldown += 20
		if(3)
			if(prob(15))
				boneappletea(target)
				ranged_cooldown += 15
			else
				teleport(target)
				ranged_cooldown += 15
